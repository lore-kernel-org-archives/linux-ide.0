From: Tom Yan <tom.ty89@gmail.com>
Subject: Re: [PATCH v6 3/4] SCT Write Same / DSM Trim
Date: Mon, 22 Aug 2016 08:31:30 +0000
Message-ID: <CAGnHSEn95Z8wKfq1Nf0ntKSzze-ScP5WeAahziD5Sk0QfmEXyw@mail.gmail.com>
References: <20160822042321.24367-1-shaun@tancheff.com> <20160822042321.24367-4-shaun@tancheff.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34112 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752090AbcHVIbd (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 22 Aug 2016 04:31:33 -0400
In-Reply-To: <20160822042321.24367-4-shaun@tancheff.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaun Tancheff <shaun@tancheff.com>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>, "Martin K . Petersen" <martin.petersen@oracle.com>, Damien Le Moal <damien.lemoal@hgst.com>, Hannes Reinecke <hare@suse.de>, Josh Bingaman <josh.bingaman@seagate.com>, Hannes Reinecke <hare@suse.com>, Shaun Tancheff <shaun.tancheff@seagate.com>

As mentioned before, as of the latest draft of ACS-4, nothing about a
larger payload size is mentioned. Conservatively speaking, it sort of
means that we are allowing four 512-byte block payload on 4Kn device
regardless of the reported limit in the IDENTIFY DEVICE data. I am
really not sure if it's a good thing to do. Doesn't seem necessary
anyway, especially when our block layer does not support such a large
bio size (well, yet), so each request will end up using a payload of
two 512-byte blocks at max anyway.

Also, it's IMHO better to do it in a seperate patch (series) after the
SCT Write Same support has entered libata's repo too, because this has
nothing to with it but TRIM translation. In case the future ACS
standards has clearer/better instruction on this, it will be easier
for us to revert/follow up too.

And you'll need to fix the Block Limits VPD simulation
(ata_scsiop_inq_b0) too, so that it will advertise the Maximum Write
Same Length dynamically as per the logical sector size, otherwise your
effort will be completely in vain, even if our block layer is
overhauled in the future.

Please be noted that, since your haven't touched ata_scsiop_inq_b0 at
all, the reported Maximum Write Same Length will be:

On device with TRIM support:
- 4194240 LOGICAL sector per request split / command
-- ~=2G on non-4Kn drives
-- ~=16G on non-4Kn drives

On device without TRIM support:
- 0 --> SD_MAX_WS10_BLOCKS (65535) per request split / command
-- ~= 32M on non-4Kn drives
-- ~=256M on non-4Kn drives

Even if we ignore the upper limit(s) of the block layer, do we want
such inconsistencies?

On 22 August 2016 at 04:23, Shaun Tancheff <shaun@tancheff.com> wrote:
> Correct handling of devices with sector_size other that 512 bytes.
>
> Signed-off-by: Shaun Tancheff <shaun.tancheff@seagate.com>
> ---
> In the case of a 4Kn device sector_size it is possible to describe a much
> larger DSM Trim than the current fixed default of 512 bytes.
>
> This patch assumes the minimum descriptor is sector_size and fills out
> the descriptor accordingly.
>
> The ACS-2 specification is quite clear that the DSM command payload is
> sized as number of 512 byte transfers so a 4Kn device will operate
> correctly without this patch.
>
> v5:
>  - Added support for a sector_size descriptor other than 512 bytes.
>
>  drivers/ata/libata-scsi.c | 85 +++++++++++++++++++++++++++++++----------------
>  1 file changed, 57 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index ebf1a04..37f456e 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -3283,7 +3283,7 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
>  /**
>   * ata_format_dsm_trim_descr() - SATL Write Same to DSM Trim
>   * @cmd: SCSI command being translated
> - * @num: Maximum number of entries (nominally 64).
> + * @trmax: Maximum number of entries that will fit in sector_size bytes.
>   * @sector: Starting sector
>   * @count: Total Range of request in logical sectors
>   *
> @@ -3298,63 +3298,80 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
>   *  LBA's should be sorted order and not overlap.
>   *
>   * NOTE: this is the same format as ADD LBA(S) TO NV CACHE PINNED SET
> + *
> + * Return: Number of bytes copied into sglist.
>   */
> -static unsigned int ata_format_dsm_trim_descr(struct scsi_cmnd *cmd, u32 num,
> -                                             u64 sector, u32 count)
> +static size_t ata_format_dsm_trim_descr(struct scsi_cmnd *cmd, u32 trmax,
> +                                       u64 sector, u32 count)
>  {
> -       __le64 *buffer;
> -       u32 i = 0, used_bytes;
> +       struct scsi_device *sdp = cmd->device;
> +       size_t len = sdp->sector_size;
> +       size_t r;
> +       __le64 *buf;
> +       u32 i = 0;
>         unsigned long flags;
>
> -       BUILD_BUG_ON(512 > ATA_SCSI_RBUF_SIZE);
> +       WARN_ON(len > ATA_SCSI_RBUF_SIZE);
> +
> +       if (len > ATA_SCSI_RBUF_SIZE)
> +               len = ATA_SCSI_RBUF_SIZE;
>
>         spin_lock_irqsave(&ata_scsi_rbuf_lock, flags);
> -       buffer = ((void *)ata_scsi_rbuf);
> -       while (i < num) {
> +       buf = ((void *)ata_scsi_rbuf);
> +       memset(buf, 0, len);
> +       while (i < trmax) {
>                 u64 entry = sector |
>                         ((u64)(count > 0xffff ? 0xffff : count) << 48);
> -               buffer[i++] = __cpu_to_le64(entry);
> +               buf[i++] = __cpu_to_le64(entry);
>                 if (count <= 0xffff)
>                         break;
>                 count -= 0xffff;
>                 sector += 0xffff;
>         }
> -
> -       used_bytes = ALIGN(i * 8, 512);
> -       memset(buffer + i, 0, used_bytes - i * 8);
> -       sg_copy_from_buffer(scsi_sglist(cmd), scsi_sg_count(cmd), buffer, 512);
> +       r = sg_copy_from_buffer(scsi_sglist(cmd), scsi_sg_count(cmd), buf, len);
>         spin_unlock_irqrestore(&ata_scsi_rbuf_lock, flags);
>
> -       return used_bytes;
> +       return r;
>  }
>
>  /**
>   * ata_format_dsm_trim_descr() - SATL Write Same to ATA SCT Write Same
>   * @cmd: SCSI command being translated
>   * @lba: Starting sector
> - * @num: Number of logical sectors to be zero'd.
> + * @num: Number of sectors to be zero'd.
>   *
> - * Rewrite the WRITE SAME descriptor to be an SCT Write Same formatted
> + * Rewrite the WRITE SAME payload to be an SCT Write Same formatted
>   * descriptor.
>   * NOTE: Writes a pattern (0's) in the foreground.
> - *       Large write-same requents can timeout.
> + *
> + * Return: Number of bytes copied into sglist.
>   */
> -static void ata_format_sct_write_same(struct scsi_cmnd *cmd, u64 lba, u64 num)
> +static size_t ata_format_sct_write_same(struct scsi_cmnd *cmd, u64 lba, u64 num)
>  {
> -       u16 *sctpg;
> +       struct scsi_device *sdp = cmd->device;
> +       size_t len = sdp->sector_size;
> +       size_t r;
> +       u16 *buf;
>         unsigned long flags;
>
>         spin_lock_irqsave(&ata_scsi_rbuf_lock, flags);
> -       sctpg = ((void *)ata_scsi_rbuf);
> +       buf = ((void *)ata_scsi_rbuf);
> +
> +       put_unaligned_le16(0x0002,  &buf[0]); /* SCT_ACT_WRITE_SAME */
> +       put_unaligned_le16(0x0101,  &buf[1]); /* WRITE PTRN FG */
> +       put_unaligned_le64(lba,     &buf[2]);
> +       put_unaligned_le64(num,     &buf[6]);
> +       put_unaligned_le32(0u,      &buf[10]); /* pattern */
> +
> +       WARN_ON(len > ATA_SCSI_RBUF_SIZE);
>
> -       put_unaligned_le16(0x0002,  &sctpg[0]); /* SCT_ACT_WRITE_SAME */
> -       put_unaligned_le16(0x0101,  &sctpg[1]); /* WRITE PTRN FG */
> -       put_unaligned_le64(lba,     &sctpg[2]);
> -       put_unaligned_le64(num,     &sctpg[6]);
> -       put_unaligned_le32(0u,      &sctpg[10]);
> +       if (len > ATA_SCSI_RBUF_SIZE)
> +               len = ATA_SCSI_RBUF_SIZE;
>
> -       sg_copy_from_buffer(scsi_sglist(cmd), scsi_sg_count(cmd), sctpg, 512);
> +       r = sg_copy_from_buffer(scsi_sglist(cmd), scsi_sg_count(cmd), buf, len);
>         spin_unlock_irqrestore(&ata_scsi_rbuf_lock, flags);
> +
> +       return r;
>  }
>
>  /**
> @@ -3371,11 +3388,13 @@ static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
>  {
>         struct ata_taskfile *tf = &qc->tf;
>         struct scsi_cmnd *scmd = qc->scsicmd;
> +       struct scsi_device *sdp = scmd->device;
> +       size_t len = sdp->sector_size;
>         struct ata_device *dev = qc->dev;
>         const u8 *cdb = scmd->cmnd;
>         u64 block;
>         u32 n_block;
> -       const u32 trmax = ATA_MAX_TRIM_RNUM;
> +       const u32 trmax = len >> 3;
>         u32 size;
>         u16 fp;
>         u8 bp = 0xff;
> @@ -3420,8 +3439,16 @@ static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
>         if (!scsi_sg_count(scmd))
>                 goto invalid_param_len;
>
> +       /*
> +        * size must match sector size in bytes
> +        * For DATA SET MANAGEMENT TRIM in ACS-2 nsect (aka count)
> +        * is defined as number of 512 byte blocks to be transferred.
> +        */
>         if (unmap) {
>                 size = ata_format_dsm_trim_descr(scmd, trmax, block, n_block);
> +               if (size != len)
> +                       goto invalid_param_len;
> +
>                 if (ata_ncq_enabled(dev) && ata_fpdma_dsm_supported(dev)) {
>                         /* Newer devices support queued TRIM commands */
>                         tf->protocol = ATA_PROT_NCQ;
> @@ -3441,7 +3468,9 @@ static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
>                         tf->command = ATA_CMD_DSM;
>                 }
>         } else {
> -               ata_format_sct_write_same(scmd, block, n_block);
> +               size = ata_format_sct_write_same(scmd, block, n_block);
> +               if (size != len)
> +                       goto invalid_param_len;
>
>                 tf->hob_feature = 0;
>                 tf->feature = 0;
> --
> 2.9.3
>

From: "saeed bishara" <saeed.bishara@gmail.com>
Subject: Re: [PATCH] libata-pmp: clear hob for pmp register accesses
Date: Thu, 21 Feb 2008 23:51:10 +0200
Message-ID: <c70ff3ad0802211351s360eea12p64e4e79f359813af@mail.gmail.com>
References: <4730E312.3090900@navy.mil> <4737C16E.3070607@gmail.com>
	 <4738827D.9060405@pobox.com> <4738F935.1000708@gmail.com>
	 <47BC798F.6070900@pobox.com> <47BCF28F.5080702@gmail.com>
	 <47BD93BC.3080301@pobox.com> <47BDE489.6070701@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.182]:53992 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759833AbYBUVvM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Feb 2008 16:51:12 -0500
Received: by el-out-1112.google.com with SMTP id v27so183216ele.23
        for <linux-ide@vger.kernel.org>; Thu, 21 Feb 2008 13:51:11 -0800 (PST)
In-Reply-To: <47BDE489.6070701@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Saeed Bishara <saeed@marvell.com>

Hi,
 I just what to make it clear that this is not a bug of the Marvell's
PM, the sata specification (I'm looking at version 2.5) defines the
READ/WRITE PM registers to be extended commands, specifically, the
features HOB of the READ PM register defined to be RegNum[15:8].

saeed

On Thu, Feb 21, 2008 at 10:52 PM, Mark Lord <liml@rtr.ca> wrote:
> Mark Lord wrote:
>  > Tejun Heo wrote:
>  >> Hello, Mark.
>  >>
>  >> Mark Lord wrote:
>  >>> Tejun, I've added PMP to sata_mv, and am now trying to get it
>  >>> to work with a Marvell PM attached.
>  >>>
>  >>> And the behaviour I see is very bizarre.
>  >>>
>  >>> After hard+soft resets, the PM signature is found,
>  >>> and libata interrogates the PM registers.
>  >>>
>  >>> It successfully reads register 0, and then register 1.
>  >>> But all subsequent registers read out (incorrectly) as zeros.
>  ..
>
>  Saeed has confirmed this behaviour with a SATA analyzer.
>  The Marvell port-multiplier apparently likes to see clean HOB
>  information when accessing PMP registers.
>
>  Since sata_mv uses PIO shadow register access, this doesn't happen
>  automatically, as it might in a more purely FIS-based driver (eg. ahci).
>
>  One way to fix this is to flag these commands with ATA_TFLAG_LBA48,
>  forcing libata to write out the HOB fields with known (zero) values.
>
>  Signed-off-by: Saeed Bishara <saeed@marvell.com>
>  Acked-by: Mark Lord <mlord@pobox.com>
>  ---
>   drivers/ata/libata-pmp.c |    4 ++--
>   1 files changed, 2 insertions(+), 2 deletions(-)
>
>  diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
>  index caef2bb..d91f509 100644
>  --- a/drivers/ata/libata-pmp.c
>  +++ b/drivers/ata/libata-pmp.c
>  @@ -35,7 +35,7 @@ static unsigned int sata_pmp_read(struct ata_link *link, int reg, u32 *r_val)
>         ata_tf_init(pmp_dev, &tf);
>         tf.command = ATA_CMD_PMP_READ;
>         tf.protocol = ATA_PROT_NODATA;
>  -       tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
>  +       tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE | ATA_TFLAG_LBA48;
>         tf.feature = reg;
>         tf.device = link->pmp;
>
>  @@ -71,7 +71,7 @@ static unsigned int sata_pmp_write(struct ata_link *link, int reg, u32 val)
>         ata_tf_init(pmp_dev, &tf);
>         tf.command = ATA_CMD_PMP_WRITE;
>         tf.protocol = ATA_PROT_NODATA;
>  -       tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
>  +       tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE | ATA_TFLAG_LBA48;
>         tf.feature = reg;
>         tf.device = link->pmp;
>         tf.nsect = val & 0xff;
>  -
>  To unsubscribe from this list: send the line "unsubscribe linux-ide" in
>  the body of a message to majordomo@vger.kernel.org
>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

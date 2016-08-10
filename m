From: Shaun Tancheff <shaun.tancheff@seagate.com>
Subject: Re: [PATCH v5 1/2] Use kmap_atomic when rewriting attached page
Date: Wed, 10 Aug 2016 07:26:31 -0500
Message-ID: <CAJVOszCRQmq8dkt9AAMT=Y_nSwwmGp6Lwtz2K8EVcH8YRNzErQ@mail.gmail.com>
References: <1470790829-3793-1-git-send-email-shaun@tancheff.com>
 <1470790829-3793-2-git-send-email-shaun@tancheff.com> <CAGnHSEmg2=gOYg6OfTRStL=vx7Z2nBV3Saht8m6fpVjQvCr=dA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGnHSEmg2=gOYg6OfTRStL=vx7Z2nBV3Saht8m6fpVjQvCr=dA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tom Yan <tom.ty89@gmail.com>
Cc: Shaun Tancheff <shaun@tancheff.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>, Josh Bingaman <josh.bingaman@seagate.com>
List-Id: linux-ide@vger.kernel.org

On Wed, Aug 10, 2016 at 5:56 AM, Tom Yan <tom.ty89@gmail.com> wrote:
> On 10 August 2016 at 09:00, Shaun Tancheff <shaun@tancheff.com> wrote:
>>  static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
>>  {
>>         struct ata_taskfile *tf = &qc->tf;
>>         struct scsi_cmnd *scmd = qc->scsicmd;
>>         struct ata_device *dev = qc->dev;
>>         const u8 *cdb = scmd->cmnd;
>> +       struct scatterlist *sg;
>>         u64 block;
>>         u32 n_block;
>> +       const u32 trmax = ATA_MAX_TRIM_RNUM;
>>         u32 size;
>> -       void *buf;
>>         u16 fp;
>>         u8 bp = 0xff;
>>
>> @@ -3319,10 +3363,9 @@ static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
>>         if (!scsi_sg_count(scmd))
>>                 goto invalid_param_len;
>>
>> -       buf = page_address(sg_page(scsi_sglist(scmd)));
>> -
>> -       if (n_block <= 65535 * ATA_MAX_TRIM_RNUM) {
>> -               size = ata_set_lba_range_entries(buf, ATA_MAX_TRIM_RNUM, block, n_block);
>> +       sg = scsi_sglist(scmd);
>> +       if (n_block <= 0xffff * cmax) {
>
> Although this got moved and corrected in the next patch, but perhaps
> you should still correct the `cmax` here, which should be `trmax`.

You are correct. I will fix this up. Thanks!

>> +               size = ata_format_dsm_trim_descr(sg, trmax, block, n_block);
>>         } else {
>>                 fp = 2;
>>                 goto invalid_fld;



-- 
Shaun Tancheff

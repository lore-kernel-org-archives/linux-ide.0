From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 2/2] libata: micro-optimize tag allocation
Date: Fri, 16 Jan 2015 15:49:07 -0800
Message-ID: <CAPcyv4hWkWFYH1+d9nmw=bP-2X2kR=V4w=nEZ=QyOSMdpYAk3g@mail.gmail.com>
References: <20150116231225.18771.75061.stgit@viggo.jf.intel.com>
	<20150116231307.18771.52330.stgit@viggo.jf.intel.com>
	<20150116233100.GA1281684@devbig257.prn2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:50049 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502AbbAPXtI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Jan 2015 18:49:08 -0500
Received: by mail-wg0-f45.google.com with SMTP id y19so23130917wgg.4
        for <linux-ide@vger.kernel.org>; Fri, 16 Jan 2015 15:49:07 -0800 (PST)
In-Reply-To: <20150116233100.GA1281684@devbig257.prn2.facebook.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaohua Li <shli@fb.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Jens Axboe <axboe@fb.com>, Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@infradead.org>

On Fri, Jan 16, 2015 at 3:31 PM, Shaohua Li <shli@fb.com> wrote:
> On Fri, Jan 16, 2015 at 03:13:08PM -0800, Dan Williams wrote:
>> Jens notes, "libata tag allocator sucks. Like seriously sucks, it's
>> almost a worst case implementation."  Previously I thought SATA mmio
>> latency dominated performance profiles, but as Tejun notes:
>>
>>   "Hmmm... one problem with the existing tag allocator in ata is that
>>    it's not very efficient which actually shows up in profile when libata
>>    is used with a very zippy SSD.  Given that ata needs a different
>>    allocation policies anyway maybe the right thing to do is making the
>>    existing allocator suck less."
>>
>> So replace it with a naive enhancement that also supports the existing
>> quirks.  Hopefully, soon to be replaced by Shaohua's patches [1], but
>> those do not yet support the quirk needed by sil24 (ATA_FLAG_LOWTAG)
>> [2].
>>
>> [1]: https://urldefense.proofpoint.com/v1/url?u=http://marc.info/?l%3Dlinux-ide%26m%3D142137195324687%26w%3D2&k=ZVNjlDMF0FElm4dQtryO4A%3D%3D%0A&r=3RFlL12A7nwmLRXunVJq2g%3D%3D%0A&m=5iyIBsm0XLUeBFFdEfPvaP6LL8KiN2TcuEGgJH6RzTc%3D%0A&s=cea914a77883ea668400a1f19621d1241cab16f6a4c0e68d0749de4c2448cdb1
>> [2]: https://urldefense.proofpoint.com/v1/url?u=https://bugzilla.kernel.org/show_bug.cgi?id%3D87101&k=ZVNjlDMF0FElm4dQtryO4A%3D%3D%0A&r=3RFlL12A7nwmLRXunVJq2g%3D%3D%0A&m=5iyIBsm0XLUeBFFdEfPvaP6LL8KiN2TcuEGgJH6RzTc%3D%0A&s=82d11bc720e9f0cbd0ad6aa7e8ece18315ac1e4f97cb02d49460893e5006228e
>
> with my patch, we can fix this as:
>
>
> diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
> index d81b20d..5242897 100644
> --- a/drivers/ata/sata_sil24.c
> +++ b/drivers/ata/sata_sil24.c
> @@ -388,6 +388,7 @@ static struct scsi_host_template sil24_sht = {
>         .can_queue              = SIL24_MAX_CMDS,
>         .sg_tablesize           = SIL24_MAX_SGE,
>         .dma_boundary           = ATA_DMA_BOUNDARY,
> +       .tag_alloc_policy       = BLK_TAG_ALLOC_FIFO,
>  };
>
>  static struct ata_port_operations sil24_ops = {

Ok, thanks for that.

We still need patch1 as the minimal fix for the regression, agreed?

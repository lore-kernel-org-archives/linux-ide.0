From: Tejun Heo <htejun@gmail.com>
Subject: Re: ata_piix resume from S3 on T43P failed
Date: Fri, 12 May 2006 19:56:16 +0900
Message-ID: <446469D0.30703@gmail.com>
References: <1147334740.7273.38.camel@forrest26.sh.intel.com> <4462F667.3060504@gmail.com> <4462F767.5070003@gmail.com> <1147340790.7273.47.camel@forrest26.sh.intel.com> <20060511105555.GK4157@suse.de> <1147413106.7273.70.camel@forrest26.sh.intel.com> <20060512101713.GN4157@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:42175 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751192AbWELK4W (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 May 2006 06:56:22 -0400
Received: by py-out-1112.google.com with SMTP id x31so762016pye
        for <linux-ide@vger.kernel.org>; Fri, 12 May 2006 03:56:21 -0700 (PDT)
In-Reply-To: <20060512101713.GN4157@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: "zhao, forrest" <forrest.zhao@intel.com>, linux-ide@vger.kernel.org

Hello, Zhao, Jens.

Jens Axboe wrote:
> On Fri, May 12 2006, zhao, forrest wrote:
>> On Thu, 2006-05-11 at 12:55 +0200, Jens Axboe wrote:
>>> run dmesg prior to suspending, then it'll be cached and can be run after
>>> resume even if the disk doesn't want to talk to you.
>>>
>> Don't know why the mails with attached files were not sent to mailing
>> list, so I put them at
>> http://www.infradead.org/~forrest/suspend-resume-dmesg/
> 
> The key is the 0xef timeout, then the device is offlined and you see a
> lot of io errors due to that.
> 
> Try this:
> 
> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
> index bd14720..f120839 100644
> --- a/drivers/scsi/libata-core.c
> +++ b/drivers/scsi/libata-core.c
> @@ -4288,6 +4288,7 @@ int ata_device_resume(struct ata_port *a
>  {
>  	if (ap->flags & ATA_FLAG_SUSPENDED) {
>  		ap->flags &= ~ATA_FLAG_SUSPENDED;
> +		mdelay(2000);
>  		ata_set_mode(ap);
>  	}
>  	if (!ata_dev_present(dev))
> 

If Jens' suggestion doesn't work, can you post the same log with the 
working kernel?  In #upstream, that part of code hasn't changed much, so 
I'm curious what makes the other kernel work.

-- 
tejun

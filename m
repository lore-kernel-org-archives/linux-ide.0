From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: Re: ata_piix resume from S3 on T43P failed
Date: Tue, 16 May 2006 11:56:34 +0800
Message-ID: <1147751795.7273.80.camel@forrest26.sh.intel.com>
References: <1147334740.7273.38.camel@forrest26.sh.intel.com>
	 <4462F667.3060504@gmail.com> <4462F767.5070003@gmail.com>
	 <1147340790.7273.47.camel@forrest26.sh.intel.com>
	 <20060511105555.GK4157@suse.de>
	 <1147413106.7273.70.camel@forrest26.sh.intel.com>
	 <20060512101713.GN4157@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:57443 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751256AbWEPEHu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 May 2006 00:07:50 -0400
In-Reply-To: <20060512101713.GN4157@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On Fri, 2006-05-12 at 12:17 +0200, Jens Axboe wrote:
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

Jens,

Yes! The patch works. But I'm wondering why ata_piix driver in kernel
2.6.16-rc6 works without mdelay(2000); in ata_device_resume()?

Thanks,
Forrest

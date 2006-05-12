From: Jens Axboe <axboe@suse.de>
Subject: Re: ata_piix resume from S3 on T43P failed
Date: Fri, 12 May 2006 12:17:14 +0200
Message-ID: <20060512101713.GN4157@suse.de>
References: <1147334740.7273.38.camel@forrest26.sh.intel.com> <4462F667.3060504@gmail.com> <4462F767.5070003@gmail.com> <1147340790.7273.47.camel@forrest26.sh.intel.com> <20060511105555.GK4157@suse.de> <1147413106.7273.70.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:26474 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751136AbWELKQo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 May 2006 06:16:44 -0400
Content-Disposition: inline
In-Reply-To: <1147413106.7273.70.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On Fri, May 12 2006, zhao, forrest wrote:
> On Thu, 2006-05-11 at 12:55 +0200, Jens Axboe wrote:
> > run dmesg prior to suspending, then it'll be cached and can be run after
> > resume even if the disk doesn't want to talk to you.
> > 
> 
> Don't know why the mails with attached files were not sent to mailing
> list, so I put them at
> http://www.infradead.org/~forrest/suspend-resume-dmesg/

The key is the 0xef timeout, then the device is offlined and you see a
lot of io errors due to that.

Try this:

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index bd14720..f120839 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -4288,6 +4288,7 @@ int ata_device_resume(struct ata_port *a
 {
 	if (ap->flags & ATA_FLAG_SUSPENDED) {
 		ap->flags &= ~ATA_FLAG_SUSPENDED;
+		mdelay(2000);
 		ata_set_mode(ap);
 	}
 	if (!ata_dev_present(dev))

-- 
Jens Axboe


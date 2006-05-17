From: Jens Axboe <axboe@suse.de>
Subject: Re: ata_piix resume from S3 on T43P failed
Date: Wed, 17 May 2006 13:03:29 +0200
Message-ID: <20060517110328.GM4197@suse.de>
References: <1147334740.7273.38.camel@forrest26.sh.intel.com> <4462F667.3060504@gmail.com> <4462F767.5070003@gmail.com> <1147340790.7273.47.camel@forrest26.sh.intel.com> <20060511105555.GK4157@suse.de> <1147413106.7273.70.camel@forrest26.sh.intel.com> <20060512101713.GN4157@suse.de> <1147751795.7273.80.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:10334 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751090AbWEQLCe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 May 2006 07:02:34 -0400
Content-Disposition: inline
In-Reply-To: <1147751795.7273.80.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On Tue, May 16 2006, zhao, forrest wrote:
> On Fri, 2006-05-12 at 12:17 +0200, Jens Axboe wrote:
> > The key is the 0xef timeout, then the device is offlined and you see a
> > lot of io errors due to that.
> > 
> > Try this:
> > 
> > diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
> > index bd14720..f120839 100644
> > --- a/drivers/scsi/libata-core.c
> > +++ b/drivers/scsi/libata-core.c
> > @@ -4288,6 +4288,7 @@ int ata_device_resume(struct ata_port *a
> >  {
> >  	if (ap->flags & ATA_FLAG_SUSPENDED) {
> >  		ap->flags &= ~ATA_FLAG_SUSPENDED;
> > +		mdelay(2000);
> >  		ata_set_mode(ap);
> >  	}
> >  	if (!ata_dev_present(dev))
> > 
> 
> Jens,
> 
> Yes! The patch works. But I'm wondering why ata_piix driver in kernel
> 2.6.16-rc6 works without mdelay(2000); in ata_device_resume()?

I think Hugh traced it down to a unrelated timer change. The above
really wants to wait for BUSY clear, perhaps the best solution would be
to have piix device its own ata_piix_device_resume() that first waits
for BUSY clear, then calls ata_device_resume().

-- 
Jens Axboe


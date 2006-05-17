From: Jens Axboe <axboe@suse.de>
Subject: Re: ata_piix resume from S3 on T43P failed
Date: Wed, 17 May 2006 15:02:33 +0200
Message-ID: <20060517130233.GN4197@suse.de>
References: <1147334740.7273.38.camel@forrest26.sh.intel.com> <4462F667.3060504@gmail.com> <4462F767.5070003@gmail.com> <1147340790.7273.47.camel@forrest26.sh.intel.com> <20060511105555.GK4157@suse.de> <1147413106.7273.70.camel@forrest26.sh.intel.com> <20060512101713.GN4157@suse.de> <1147751795.7273.80.camel@forrest26.sh.intel.com> <20060517110328.GM4197@suse.de> <446B1D76.6010303@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:14167 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932240AbWEQNBv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 May 2006 09:01:51 -0400
Content-Disposition: inline
In-Reply-To: <446B1D76.6010303@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On Wed, May 17 2006, Jeff Garzik wrote:
> Jens Axboe wrote:
> >I think Hugh traced it down to a unrelated timer change. The above
> >really wants to wait for BUSY clear, perhaps the best solution would be
> >to have piix device its own ata_piix_device_resume() that first waits
> >for BUSY clear, then calls ata_device_resume().
> 
> Close...  all devices should wait for libata to signal that the bus is 
> ready to be talked to.  For some that's waiting for BSY to clear, for 
> others that's checking the SATA bus.

Ok, I meant for the ata_piix case. Same should apply to others, right?
Do whatever you need to do to make sure the hardware is ready, then call
the generic ata_device_resume() helper to handle the libata side of
things.

-- 
Jens Axboe


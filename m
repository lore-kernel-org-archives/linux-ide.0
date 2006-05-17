From: Jeff Garzik <jeff@garzik.org>
Subject: Re: ata_piix resume from S3 on T43P failed
Date: Wed, 17 May 2006 08:56:22 -0400
Message-ID: <446B1D76.6010303@garzik.org>
References: <1147334740.7273.38.camel@forrest26.sh.intel.com> <4462F667.3060504@gmail.com> <4462F767.5070003@gmail.com> <1147340790.7273.47.camel@forrest26.sh.intel.com> <20060511105555.GK4157@suse.de> <1147413106.7273.70.camel@forrest26.sh.intel.com> <20060512101713.GN4157@suse.de> <1147751795.7273.80.camel@forrest26.sh.intel.com> <20060517110328.GM4197@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:10673 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932548AbWEQM40 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 May 2006 08:56:26 -0400
In-Reply-To: <20060517110328.GM4197@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Jens Axboe wrote:
> I think Hugh traced it down to a unrelated timer change. The above
> really wants to wait for BUSY clear, perhaps the best solution would be
> to have piix device its own ata_piix_device_resume() that first waits
> for BUSY clear, then calls ata_device_resume().

Close...  all devices should wait for libata to signal that the bus is 
ready to be talked to.  For some that's waiting for BSY to clear, for 
others that's checking the SATA bus.

	Jeff



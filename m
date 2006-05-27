From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Add ata_piix's own resume function
Date: Sat, 27 May 2006 02:52:52 -0400
Message-ID: <4477F744.7070303@garzik.org>
References: <1148634262.2310.7.camel@forrest26.sh.intel.com> <20060526230534.GA3640@suse.de> <44778F2A.7070708@garzik.org> <20060527062159.GB23315@suse.de> <4477F24E.8080407@garzik.org> <20060527064641.GA24012@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:25577 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751424AbWE0Gw4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 02:52:56 -0400
In-Reply-To: <20060527064641.GA24012@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Jens Axboe wrote:
> Since there's just the one device on the bus in this case, whether its

Wrong.  ata_piix must deal with master/slave, as must libata itself.


> the device or bus posting BUSY seems pretty irrelevant. If anything, I'd
> say that the act of iterating over possible devices hanging of the pci
> device and resuming them from the pci handler is definitely the worst
> approach. The pci driver resume function should do just one thing --
> resume the device itself.

Who resumes the bus?  hmmm?

Please, read other drivers.  Control flow always starts at 
driver::resume, and since the driver knows the hardware best, it _must_ 
be the one that directs the control flow.

	Jeff



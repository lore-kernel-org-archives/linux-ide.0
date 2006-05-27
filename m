From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH alt2] libata resume fixes
Date: Sat, 27 May 2006 15:58:43 -0400
Message-ID: <4478AF73.4070007@garzik.org>
References: <20060527191323.GA26671@havoc.gtf.org> <4478A6C5.2040201@rtr.ca> <4478A74F.8070008@garzik.org> <4478A855.2070104@rtr.ca> <4478A898.6050005@garzik.org> <4478AC00.1020208@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:25999 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964929AbWE0T6q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 15:58:46 -0400
In-Reply-To: <4478AC00.1020208@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org, torvalds@osdl.org, axboe@suse.de

Mark Lord wrote:
> Okay, here's the syslog.  Find the lines that begin with ">>>>>  ",
> and you'll see ata_pci_device_resume followed by two 
> ata_scsi_device_resume.

Thanks.


> One thought about Linus's one-liner (and the original patch),
> is that two seconds may be too short --> I'd suggest a 10-second
> timeout there for notebook drive spin-up.  Or one could be very
> paranoid and use the standard ATA 31-second timeout.
> 
> I wonder if your faster 64-bit machine had that problem?
> (two seconds not long enough, whereas my 32-bit machine is slower
> gettting to that point, so two-seconds is then enough?).

Well, there's a udelay() in there to guarantee the timing, and 64-bit 
machine is definitely newer and faster, so I doubt that would explain 
the hardlock I see.  I'll test a longer ata_busy_wait() anyway, just to 
be sure.

Overall we _really really_ need to do full controller init.  I'm 
honestly surprised the delay hack works, because the resume skips ALL of 
the controller init in piix_sata_probe().  Since the Linus patch doesn't 
touch PCS at all, it is _luck_ that the controller silicon gives you a 
useful value when it goes to PCI D0 state.

I posted a version that does full bus probe as "[PATCH alt4] libata 
resume fixes" just now.

	Jeff




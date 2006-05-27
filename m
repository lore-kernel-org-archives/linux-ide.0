From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)  fails: libata issue
Date: Sat, 27 May 2006 22:24:31 +0200
Message-ID: <20060527202431.GB29172@suse.de>
References: <1148634262.2310.7.camel@forrest26.sh.intel.com> <Pine.LNX.4.64.0605262028460.5623@g5.osdl.org> <4477CEF5.9000908@garzik.org> <200605271423.40037.liml@rtr.ca> <4478A066.8090808@garzik.org> <4478A3A8.1030209@rtr.ca> <4478A553.6020001@garzik.org> <4478A76D.8070606@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:61757 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964960AbWE0UYu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 16:24:50 -0400
Content-Disposition: inline
In-Reply-To: <4478A76D.8070606@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jeff@garzik.org>, Linus Torvalds <torvalds@osdl.org>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On Sat, May 27 2006, Mark Lord wrote:
> Jeff Garzik wrote:
> >Mark Lord wrote:
> >>Same as in my original posting:
> >>>On resume from RAM, after a 30-second-ish timeout, the screen comes on
> >>>but the hard disk is NOT accessible.  "dmesg" in an already-open window
> >>>shows this (typed in from handwritten notes):
> >>>
> >>>sd 0:0:0:0: SCSI error: return code = 0x40000
> >>>end_request: I/O error, /dev/sda, sector nnnnnnn
> >>>sd 0:0:0:0: SCSI error: return code = 0x40000
> >>>end_request: I/O error, /dev/sda, sector nnnnnnn
> >>>sd 0:0:0:0: SCSI error: return code = 0x40000
> >>>end_request: I/O error, /dev/sda, sector nnnnnnn
> >>>sd 0:0:0:0: SCSI error: return code = 0x40000
> >>>end_request: I/O error, /dev/sda, sector nnnnnnn
> >>>sd 0:0:0:0: SCSI error: return code = 0x40000
> >>>end_request: I/O error, /dev/sda, sector nnnnnnn
> >>>sd 0:0:0:0: SCSI error: return code = 0x40000
> >>>end_request: I/O error, /dev/sda, sector nnnnnnn
> >>>sd 0:0:0:0: SCSI error: return code = 0x40000
> >>>end_request: I/O error, /dev/sda, sector nnnnnnn
> >
> >what is in dmesg _before_ that, though?
> 
> Nothing useful --> only the suspend-time messages from USB and whatnot.
> 
> I'll crash it again now just to confirm that, though.
> Give me another 10 minutes for the two reboots..

I'll go over this thread when I have better connectivity, but I cna say
that the non-working solutions for me all involve the 0xef command first
issued failing. The scsi messages above is just a result of the device
being taken offline after failing, so not very interesting by
themselves.


-- 
Jens Axboe


From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)
 fails: libata issue
Date: Sat, 27 May 2006 15:24:29 -0400
Message-ID: <4478A76D.8070606@rtr.ca>
References: <1148634262.2310.7.camel@forrest26.sh.intel.com> <Pine.LNX.4.64.0605262028460.5623@g5.osdl.org> <4477CEF5.9000908@garzik.org> <200605271423.40037.liml@rtr.ca> <4478A066.8090808@garzik.org> <4478A3A8.1030209@rtr.ca> <4478A553.6020001@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:15517 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964945AbWE0TY1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 15:24:27 -0400
In-Reply-To: <4478A553.6020001@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Jens Axboe <axboe@suse.de>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Mark Lord wrote:
>> Same as in my original posting:
>>> On resume from RAM, after a 30-second-ish timeout, the screen comes on
>>> but the hard disk is NOT accessible.  "dmesg" in an already-open window
>>> shows this (typed in from handwritten notes):
>>>
>>> sd 0:0:0:0: SCSI error: return code = 0x40000
>>> end_request: I/O error, /dev/sda, sector nnnnnnn
>>> sd 0:0:0:0: SCSI error: return code = 0x40000
>>> end_request: I/O error, /dev/sda, sector nnnnnnn
>>> sd 0:0:0:0: SCSI error: return code = 0x40000
>>> end_request: I/O error, /dev/sda, sector nnnnnnn
>>> sd 0:0:0:0: SCSI error: return code = 0x40000
>>> end_request: I/O error, /dev/sda, sector nnnnnnn
>>> sd 0:0:0:0: SCSI error: return code = 0x40000
>>> end_request: I/O error, /dev/sda, sector nnnnnnn
>>> sd 0:0:0:0: SCSI error: return code = 0x40000
>>> end_request: I/O error, /dev/sda, sector nnnnnnn
>>> sd 0:0:0:0: SCSI error: return code = 0x40000
>>> end_request: I/O error, /dev/sda, sector nnnnnnn
> 
> what is in dmesg _before_ that, though?

Nothing useful --> only the suspend-time messages from USB and whatnot.

I'll crash it again now just to confirm that, though.
Give me another 10 minutes for the two reboots..

Cheers

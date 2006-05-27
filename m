From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)
 fails: libata issue
Date: Sat, 27 May 2006 15:08:24 -0400
Message-ID: <4478A3A8.1030209@rtr.ca>
References: <1148634262.2310.7.camel@forrest26.sh.intel.com> <Pine.LNX.4.64.0605262028460.5623@g5.osdl.org> <4477CEF5.9000908@garzik.org> <200605271423.40037.liml@rtr.ca> <4478A066.8090808@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:31457 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964938AbWE0TI0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 15:08:26 -0400
In-Reply-To: <4478A066.8090808@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Jens Axboe <axboe@suse.de>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
>
Jeff Garzik wrote:
>..
> Output please?  Did you get any failed-to-resume messages?

Same as in my original posting:
> On resume from RAM, after a 30-second-ish timeout, the screen comes on
> but the hard disk is NOT accessible.  "dmesg" in an already-open window
> shows this (typed in from handwritten notes):
> 
> sd 0:0:0:0: SCSI error: return code = 0x40000
> end_request: I/O error, /dev/sda, sector nnnnnnn
> sd 0:0:0:0: SCSI error: return code = 0x40000
> end_request: I/O error, /dev/sda, sector nnnnnnn
> sd 0:0:0:0: SCSI error: return code = 0x40000
> end_request: I/O error, /dev/sda, sector nnnnnnn
> sd 0:0:0:0: SCSI error: return code = 0x40000
> end_request: I/O error, /dev/sda, sector nnnnnnn
> sd 0:0:0:0: SCSI error: return code = 0x40000
> end_request: I/O error, /dev/sda, sector nnnnnnn
> sd 0:0:0:0: SCSI error: return code = 0x40000
> end_request: I/O error, /dev/sda, sector nnnnnnn
> sd 0:0:0:0: SCSI error: return code = 0x40000
> end_request: I/O error, /dev/sda, sector nnnnnnn
> 
> (the nnnnnnn was actually a real number, different on each message). 


..
> Since this is claimed to be a regression, what was the last upstream 
> kernel version that worked for you?  2.6.16.x?
..
Also from the original posting:
> My ata_piix based Notebook (Dell i9300) suspends/resumes perfectly (RAM or disk)
> with 2.6.16.xx kernels, but fails resume on 2.6.17-rc5-git1 (the first 2.6.17-*
> I've attempted on this machine). 

It did NOT work any prior unpatched kernels before 2.6.16.xx.

> Finally, if you could test the updated patch I posted, and/or the one 
> that is attached, that would be preferred.

> --------------030508080204070708000504
> Content-Type: text/plain;
>  name="patch"
> Content-Transfer-Encoding: base64
> Content-Disposition: inline;
>  filename="patch"
> 
> ZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS9hdGFfcGlpeC5jIGIvZHJpdmVycy9zY3NpL2F0
> YV9waWl4LmMKaW5kZXggNmRjODgxNC4uOTQ5ZDQ5NiAxMDA2NDQKLS0tIGEvZHJpdmVycy9z
> Y3NpL2F0YV9waWl4LmMKKysrIGIvZHJpdmVycy9zY3NpL2F0YV9waWl4LmMKQEAgLTIwMSw3
...

Fix your mailer, please.  Meanwhile, I'll try to extract the patch
and apply it, but for informational purposes only.
Linus's one-liner has us all beat.

Cheers


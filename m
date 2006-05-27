From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)
 fails: libata issue
Date: Sat, 27 May 2006 15:15:31 -0400
Message-ID: <4478A553.6020001@garzik.org>
References: <1148634262.2310.7.camel@forrest26.sh.intel.com> <Pine.LNX.4.64.0605262028460.5623@g5.osdl.org> <4477CEF5.9000908@garzik.org> <200605271423.40037.liml@rtr.ca> <4478A066.8090808@garzik.org> <4478A3A8.1030209@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33934 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964942AbWE0TPk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 15:15:40 -0400
In-Reply-To: <4478A3A8.1030209@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Linus Torvalds <torvalds@osdl.org>, Jens Axboe <axboe@suse.de>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Mark Lord wrote:
> Same as in my original posting:
>> On resume from RAM, after a 30-second-ish timeout, the screen comes on
>> but the hard disk is NOT accessible.  "dmesg" in an already-open window
>> shows this (typed in from handwritten notes):
>>
>> sd 0:0:0:0: SCSI error: return code = 0x40000
>> end_request: I/O error, /dev/sda, sector nnnnnnn
>> sd 0:0:0:0: SCSI error: return code = 0x40000
>> end_request: I/O error, /dev/sda, sector nnnnnnn
>> sd 0:0:0:0: SCSI error: return code = 0x40000
>> end_request: I/O error, /dev/sda, sector nnnnnnn
>> sd 0:0:0:0: SCSI error: return code = 0x40000
>> end_request: I/O error, /dev/sda, sector nnnnnnn
>> sd 0:0:0:0: SCSI error: return code = 0x40000
>> end_request: I/O error, /dev/sda, sector nnnnnnn
>> sd 0:0:0:0: SCSI error: return code = 0x40000
>> end_request: I/O error, /dev/sda, sector nnnnnnn
>> sd 0:0:0:0: SCSI error: return code = 0x40000
>> end_request: I/O error, /dev/sda, sector nnnnnnn

what is in dmesg _before_ that, though?


> Also from the original posting:
>> My ata_piix based Notebook (Dell i9300) suspends/resumes perfectly 
>> (RAM or disk)
>> with 2.6.16.xx kernels, but fails resume on 2.6.17-rc5-git1 (the first 
>> 2.6.17-*
>> I've attempted on this machine). 
> 
> It did NOT work any prior unpatched kernels before 2.6.16.xx.

Thanks.


> Fix your mailer, please.  Meanwhile, I'll try to extract the patch
> and apply it, but for informational purposes only.
> Linus's one-liner has us all beat.

I resent it inline.  Stupid Thunderbird, its never done that before. 
Sorry about that.

If mine works, it is preferred, because that's what we need for 2.6.18+.

	Jeff




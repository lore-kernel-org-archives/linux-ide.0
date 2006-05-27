From: Mark Lord <liml@rtr.ca>
Subject: Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM) fails:
 libata issue
Date: Fri, 26 May 2006 23:22:54 -0400
Message-ID: <4477C60E.1070106@rtr.ca>
References: <1148634262.2310.7.camel@forrest26.sh.intel.com> <20060526230534.GA3640@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:36296 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751778AbWE0DW4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 May 2006 23:22:56 -0400
In-Reply-To: <20060526230534.GA3640@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: "zhao, forrest" <forrest.zhao@intel.com>, Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>

Mark Lord wrote:
> Mark Lord wrote:
>> My ata_piix based Notebook (Dell i9300) suspends/resumes perfectly (RAM 
>> or disk)
>> with 2.6.16.xx kernels, but fails resume on 2.6.17-rc5-git1 (the first 
>> 2.6.17-*
>> I've attempted on this machine).
>>
>> On resume from RAM, after a 30-second-ish timeout, the screen comes on
>> but the hard disk is NOT accessible.  "dmesg" in an already-open window
>> shows this (typed in from handwritten notes):
>>
>> sd 0:0:0:0: SCSI error: return code = 0x40000
>> end_request: I/O error, /dev/sda, sector nnnnnnn
> ...
> 
> Ahh.. the fix for this was posted earlier today by Forrest Zhao.
..
> Here is a modified version of Forrest's original patch, for 2.6.17-rc5-git1.
> It seems to have fixed the resume issue on my machine here,
> so that things are now working as they were in the unpatched 2.6.16 kernels.

> Jens Axboe wrote:
> This has the problem that it introduces scsi specific knowledge into
> ata_piix, something that is both a violation and a problem because we
> are moving libata away from scsi. I think the best way to currently do
> this is to introduce a ata_port_ops hook (pre_resume()?) that waits for
> busy clear and gets called in ata_device_resume is probably the way to go.

Well, this problem has been with us all for a year now,
and at this point it impacts practically *every* new "centrino"
notebook out there.

We have a very simple workaround (previous post) that addresses it
for 2.6.17, and it's about damn time it got fixed.

If there's a better solution for *2.6.17*, then *please* post it.
Otherwise, we have a fix.  Maybe Linus or Andrew should just apply it?

Cheers

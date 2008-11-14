From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH #upstream-fixes 1/4] libata: fix device iteration bugs
Date: Fri, 14 Nov 2008 12:24:26 -0500
Message-ID: <491DB44A.5070701@rtr.ca>
References: <6ca8fe89c868f95831328d31c27f9cdb@localhost> <1DE9BF42-39BB-4220-BDF0-62F14C854E77@it-loops.com> <4917DA12.8070307@kernel.org> <07a2f909b249db90ad6bfdddfdd17765@localhost> <49180B2E.6020604@kernel.org> <49184E1A.3010508@rtr.ca> <4918F1BC.2070602@kernel.org> <4919038B.8020407@rtr.ca> <49194E1C.9030800@ru.mvista.com> <3b5e4132a8abe8d67b4f1701a384a2d4@localhost> <491996D3.80805@rtr.ca> <4D5A0E9F-4931-449F-99F6-38C09C55983A@it-loops.com> <491A2F65.8030605@rtr.ca> <491A40AB.4070002@kernel.org> <90e002e7b2d47cad80ff952a2a81f0e7@localhost> <491A90BE.9030005@kernel.org> <1741f98465176fff86a1dda48fc965ac@localhost> <491AA18A.9090001@kernel.org> <fdc08450bd57b75c90440beab3d7534a@localhost> <491AA682.2000100@kernel.org> <f6c0b70008a38679e11dff42a0970c9c@localhost> <491CE4A6.90802@rtr.ca>
 <5595676605432696d80b8394cfd8ae83@localhost> <491DB3AB.7020306@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:44537 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750936AbYKNRXi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 Nov 2008 12:23:38 -0500
In-Reply-To: <491DB3AB.7020306@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Guntsche <mike@it-loops.com>
Cc: Tejun Heo <tj@kernel.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>

Mark Lord wrote:
> Michael Guntsche wrote:
>> On Thu, 13 Nov 2008 21:38:30 -0500, Mark Lord <liml@rtr.ca> wrote:
>>
>>> One more:  Let's see "hdparm -N" for that drive
>>> (note to self: add -N functionality to -I someday..).
>>
>> /dev/sda:
>>  max sectors   = 66055248/15723600, HPA setting seems invalid
>>
>> Hmm, is the "HPA setting seems invalid" an indication that this drive 
>> is clamped?
> ..
> 
> It's definitely clamped, but that output is a sign that you
> may need a newer version of hdparm -- could you try that again
> using hdparm-9.3 from sourceforge?
..

To clarify, the second number reported should NEVER be less than
the first number.  If it is, then there's a bug in the low-level
libata driver for your SATA/IDE controller -- it's not returning
the high-order-bytes from the SAT command.  Several drivers had
this bug until 2.6.27 or so, and some may still misbehave.

A newer version of hdparm will verify that, and also show the correct
value (hopefully) obtained via a completely different mechanism.

Thanks

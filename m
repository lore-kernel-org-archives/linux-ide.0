From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.29 regression: ATA bus errors on resume
Date: Mon, 30 Mar 2009 17:43:17 +0900
Message-ID: <49D08625.8070701@gmail.com>
References: <cjtH6-3Ll-13@gated-at.bofh.it> <20090327153044.3234722d@infradead.org> <49CDFA60.9080403@gmail.com> <200903281506.03364.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.190]:14916 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755039AbZC3InZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Mar 2009 04:43:25 -0400
In-Reply-To: <200903281506.03364.rjw@sisk.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Niel Lambrechts <niel.lambrechts@gmail.com>, Arjan van de Ven <arjan@infradead.org>, "linux.kernel" <linux-kernel@vger.kernel.org>, James Bottomley <James.Bottomley@hansenpartnership.com>, Pavel Machek <pavel@ucw.cz>, Linux IDE mailing list <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>

Hello,

Rafael J. Wysocki wrote:
> On Saturday 28 March 2009, Niel Lambrechts wrote:
>> On 03/28/2009 12:30 AM, Arjan van de Ven wrote:
>>> On Fri, 27 Mar 2009 21:10:52 +0200
>>> Niel Lambrechts <niel.lambrechts@gmail.com> wrote:
>>>
>>>   
>>>> I'm seeing some dubious looking ATA messages even on 2.6.28.9-pae,
>>>> although with all the 2.6.28 variants I used s2disk/resume has always
>>>> worked. I was wondering if these "errors" perhaps play more of a role
>>>> in 2.6.29, perhaps due to the async. changes that was mentioned?
>>>>     
>>> unless you actively enabled this via a kernel command line option there
>>> are no async changes in 2.6.29 in terms of behavior.
>>>
>>>
>>>   
>> The only non-default option I had was 'modeset=1'. From Jeff's earlier
>> comment I understood the probing behaviour changed.
>>
>> The fundamental difference is that in 2.6.29 everything initially seems
>> okay, but then there is a
>> ata1.00: exception Emask 0x10 SAct 0x3f SErr 0x50000 action0xe frozen
>> ata1.00: irq_stat 0x00400008, PHY RDY changed
>>
>> There's nothing frozen it 2.6.28.
>>
>> Should I log a kernel bug, what's the best way forward and is there
>> anything more I can do to help?
> 
> Let Tejun have a look a this, perhaps?

What Niel is seeing is probably caused by libata EH somehow moving
forward too fast and receiving the second PHY changed event after the
initial reset is complete.  That or the thaw routine is broken and
doesn't clear hotplug event properly.  Actually, this double reset
seems to happen quite often, so it might be about time to drill it
down and find out what's really going on.  But, generally, it isn't a
serious problem, all that happens is EH doing another round.  The
original one looks quite serious tho.  I'll reply separately.

Thanks.

-- 
tejun

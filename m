From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 00/86] PATA fixes
Date: Thu, 03 Dec 2009 16:28:34 -0500
Message-ID: <4B182D82.8060904@garzik.org>
References: <20091125170218.5446.13513.sendpatchset@localhost> <200912032126.58129.bzolnier@gmail.com> <4B18220B.7010305@garzik.org> <200912032201.55115.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:33571 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753291AbZLCV2a (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Dec 2009 16:28:30 -0500
In-Reply-To: <200912032201.55115.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/03/2009 04:01 PM, Bartlomiej Zolnierkiewicz wrote:
> On Thursday 03 December 2009 09:39:39 pm Jeff Garzik wrote:
>> On 12/03/2009 03:26 PM, Bartlomiej Zolnierkiewicz wrote:
>>> On Thursday 03 December 2009 09:11:19 pm Jeff Garzik wrote:
>>>> On 12/03/2009 02:45 PM, Bartlomiej Zolnierkiewicz wrote:
>>>>> On Thursday 03 December 2009 06:53:59 pm Jeff Garzik wrote:
>>>>>> On 12/03/2009 07:39 AM, Bartlomiej Zolnierkiewicz wrote:
>>>>>>> On Thursday 03 December 2009 09:07:41 am Jeff Garzik wrote:
>>>>>>>> The merge window is upon us, which by strict rules means that anything
>>>>>>>> not already in libata-dev.git#upstream needs to wait until 2.6.34.
>>>>>>>>
>>>>>>>> However, bug fixes and the like should definitely be in 2.6.33.
>>>>>>>> ->init_host is definitely 2.6.34 material.  Some of the other stuff
>>>>>>>> could go either way.
>>>>>>
>>>>>>> If you would like to apply some of my patches to 2.6.33 you are more than
>>>>>>> welcome to do it.  I can even prepare separate git tree with specific changes
>>>>>>> to make it easier for you once you tell me which changes you would like to
>>>>>>> see in it.
>>>>>>
>>>>>> OK, great.
>>>>>>
>>>>>> Can you prepare a patchset containing only fixes?  Comment-only changes
>>>>>> are acceptable too.  Trivial changes too, if they are extremely trivial :)
>>>>>>
>>>>>> Include nothing that adds features, removes or unifies drivers, etc.
>>>>>
>>>>> Since this is pretty high-level description and some changes fall into
>>>>> many categories at once (i.e. addition of proper PCI Power Management
>>>>> handling could be considered both as a fix and as a feature) I prepared
>>>>> a rather conservative set of changes (which means that unfortunately
>>>>> it misses many enhancements available in my tree):
>>>>>
>>>>>> Please do it in standard kernel submit form, which is either
>>>>>> (a) repost the patches (yes, again) being submitted for 2.6.33, or
>>>>>> (b) a standard git pull request, which includes shortlog, diffstat, and
>>>>>> all-in-one diff.
>>>>>
>>>>> Thank you for the detailed explanation of the standard kernel submit
>>>>> form (I wonder how would I know this otherwise :) but the thing is that
>>>>> at the current moment I'm not submitting anything to the upstream.
>>>>
>>>> Ok, that explains my confusion, then.  I had thought you intended to get
>>>> this stuff upstream, and into users' hands.
>>>
>>> Interesting argument but the vast majority of users use distribution kernels
>>> which are not upstream and I doubt that any self-respecting distribution would
>>> miss such amount of fixes.
>>
>> Interesting argument, but applied across 1000+ developers this is
>> clearly an unscalable development model for distributions.  Thus,
>
> Interesting that you have brought distributions' convenience before
> non-distribution developers' one.

uhwhu?  You brought up distributions.


>> patches go upstream, and are then distributed widely, to eliminate
>> massive amounts of duplicated work across distributions.
>>
>> You are essentially implying that each distribution must
>>
>> 	- discover your tree
>> 	- look through the mailing list to figure out why each of
>> 	  ~80 changes are not upstream
>> 	- individually make a decision on each of ~80 changes
>> 	- actively track your tree for updates, repeating this process
>> 	  over and over again
>
> Not really.
>
> I'm only saying that the upstream is so much hassle to deal with it that
> it is up to people wanting to see my changes upstream to do the work on
> integrating them upstream if they want to see them in upstream faster.
>
> Fair enough?

I respect your opinion, sure.  And respect that your time is your own. 
And appreciate you spending that time to batch together some patches.

But it is simple logic that a non-standard distribution method for your 
changes implies a self-imposed limited distribution, with possibly 
useful fixes and changes not getting into the hands of users that can 
use them.

That's your choice -- but it surprised me, is all.  Usually developers 
are more eager to get their changes into wide distribution, because that 
benefits the most Linux users.

If you fail to send changes upstream, most people will assume that you 
do not consider your changes "ready" for users, "ready" for wide 
distribution and use.  Because that is the common practice for nearly 
all other Linux kernel developers in all subsystems.

	Jeff



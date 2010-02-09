From: "Paul Check" <paul@thechecks.ca>
Subject: Re: Intermittent SATA link down SStatus 0
Date: Tue, 9 Feb 2010 00:32:44 -0500
Message-ID: <12193ff15b0deef3609ea93f54e5b485.squirrel@thechecks.ca>
References: <f4d0374cb498479438e76ac749465a7d.squirrel@thechecks.ca>
    <4B5D26EF.4030709@kernel.org>
    <loom.20100205T041929-66@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from d72-38-7-254.commercial1.cgocable.net ([72.38.7.254]:1125 "EHLO
	max" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751692Ab0BIFcq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Feb 2010 00:32:46 -0500
Received: from d72-38-7-254.commercial1.cgocable.net
	([72.38.7.254] helo=thechecks.ca ident=www-data)
	by max with esmtp (Exim 4.71)
	(envelope-from <paul@thechecks.ca>)
	id 1NeiiK-0000y0-NX
	for linux-ide@vger.kernel.org; Tue, 09 Feb 2010 00:32:45 -0500
In-Reply-To: <loom.20100205T041929-66@post.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

FYI I haven't tried the commit / fix but I am still having the problems,
so uninstalling PATA did not help, just as many said it likely wouldn't.

Once I try the rc5 and test for many reboots I will report back.  P

> Tejun Heo <tj <at> kernel.org> writes:
>
>>
>> On 01/22/2010 12:57 AM, Paul Check wrote:
>> > I am having an intermittent problem:
>> >
>> > ata1.01: SATA link down (SStatus 0 SControl 301)
>> >
>> > which is causing one of my four hard drives to not get recognized.
>>
>> Most likely fixed by commit 5040ab67a2c6d5710ba497dc52a8f7035729d7b0.
>> Can you please try 2.6.33-rc5?
>>
>> Thanks.
>>
>
> I've been having intermittent SATA troubles as well recently (Ubuntu 9.10,
> kernel 2.6.31-17). So here I am after a quick search on Google and it
> looks like
> you've already fixed the problem.  I'm no expert on SATA protocol or
> anything,
> but reading the diff of that commit looks like it sure does address my
> problem.
>  I'm really just here to extend a sincere THANK YOU, to Tejun and all the
> people
> that work on this stuff.
>
> I'm not sure if it matters or not, but for whatever reason on my box, the
> problem happens pretty reliably after a long power off cycle (its been off
> >18
> hours when I turn it on). I've never seen it fail on a subsequent reboot,
> even
> with a short power cycle.  I may have to try compiling the kernel for
> myself to
> see if it truly fixes it. I haven't built a kernel in a long time, but
> maybe
> I'll give a whirl again.
>
> Again thanks!
>
> - Tim
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



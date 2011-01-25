From: Dave Howorth <dhoworth@mrc-lmb.cam.ac.uk>
Subject: Re: sata_via bus errors fixed?
Date: Tue, 25 Jan 2011 10:35:29 +0000
Message-ID: <4D3EA771.3070206@mrc-lmb.cam.ac.uk>
References: <4D3DA387.8080301@mrc-lmb.cam.ac.uk> <20110124170432.GH27510@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:47492 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017Ab1AYKfb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Jan 2011 05:35:31 -0500
Received: from mail.mrc-lmb.cam.ac.uk ([131.111.85.9]:41564 helo=mail.lmb.internal)
	by ppsw-41.csi.cam.ac.uk (ppsw.cam.ac.uk [131.111.8.136]:25)
	with esmtp id 1PhgFG-0007YD-QJ (Exim 4.72) for linux-ide@vger.kernel.org
	(return-path <dhoworth@mrc-lmb.cam.ac.uk>); Tue, 25 Jan 2011 10:35:30 +0000
Received: from cpepc210-3.lmb.internal ([10.14.0.2])
	by mail.lmb.internal with esmtp (Exim 4.63)
	(envelope-from <dhoworth@mrc-lmb.cam.ac.uk>)
	id 1PhgFF-0007NO-Vk
	for linux-ide@vger.kernel.org; Tue, 25 Jan 2011 10:35:30 +0000
In-Reply-To: <20110124170432.GH27510@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Hmmm... there is no message which shows why EH kicked in.  Weird.  Can
> you please post the output of dmesg instead after those failures?

Hello again.

I gave back the borrowed Sil 3512 adapter so I can't provide more data
for that. I never ran that with Knoppix so I don't know whether it would
be 'mended' or not.

Last night I booted with the VIA 6421A adapter and the 1 TB drive and
recorded various data. They're a bit big to put in an email so I've put
them on pastebin; I hope that's OK. They're at:

dmesg               http://pastebin.com/FF3ZtcXy
lspci               http://pastebin.com/u5y8XrWm
smartctl-a-dev-sda  http://pastebin.com/m5YNRw2t
var-log-messages    http://pastebin.com/mVrkyTF2

>> So I'm curious whether:
>> (1) My case is support for wider usefulness of the 'magic patch', or
> 
> I doubt it.  The problem is via specific and you seem to be
> experiencing similar problem on the sil controller too.

The sil problems were similar in effect, in that they both produced a
flaky system, but the error messages were different in detail. I'm not
qualified to tell whether the differences were significant or not.

Unfortunately I've returned the borrowed Sil card and the priority for
me now is to see whether I can trust my system using the VIA card. I
could probably borrow the Sil card again if it would be helpful.

> It seems like the hardware definitely is flaky.  SATA is one of the
> first things which malfunction when the system has has interference
> issues.  I have no idea why the new kernel makes it happier tho.

Yes, a hardware glitch does seem the strongest candidate. But the newish
kernel does seem to make it completely solid AFAICT. Cash-wise my
alternative is a new mobo, cpu, ram & psu so there's a bit of an
incentive to persevere. But mostly I guess it's just a perverse desire
to understand what's going on that is driving me.

I suppose I could try various kernel versions to see if it's possible to
isolate one change that causes the improved behaviour. That would be a
bit of a learning curve and I'm not sure how much time it would need.

Cheers, Dave

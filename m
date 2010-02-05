From: Tim <tmisc@pertuit.net>
Subject: Re: Intermittent SATA link down SStatus 0
Date: Fri, 5 Feb 2010 03:29:43 +0000 (UTC)
Message-ID: <loom.20100205T041929-66@post.gmane.org>
References: <f4d0374cb498479438e76ac749465a7d.squirrel@thechecks.ca> <4B5D26EF.4030709@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:45705 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751423Ab0BIFUJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Feb 2010 00:20:09 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-ide@m.gmane.org>)
	id 1NeiW5-0006zU-Ll
	for linux-ide@vger.kernel.org; Tue, 09 Feb 2010 06:20:05 +0100
Received: from adsl-68-94-0-82.dsl.rcsntx.swbell.net ([68.94.0.82])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 09 Feb 2010 06:20:05 +0100
Received: from tmisc by adsl-68-94-0-82.dsl.rcsntx.swbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 09 Feb 2010 06:20:05 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Tejun Heo <tj <at> kernel.org> writes:

> 
> On 01/22/2010 12:57 AM, Paul Check wrote:
> > I am having an intermittent problem:
> > 
> > ata1.01: SATA link down (SStatus 0 SControl 301)
> > 
> > which is causing one of my four hard drives to not get recognized.
> 
> Most likely fixed by commit 5040ab67a2c6d5710ba497dc52a8f7035729d7b0.
> Can you please try 2.6.33-rc5?
> 
> Thanks.
> 

I've been having intermittent SATA troubles as well recently (Ubuntu 9.10,
kernel 2.6.31-17). So here I am after a quick search on Google and it looks like
you've already fixed the problem.  I'm no expert on SATA protocol or anything,
but reading the diff of that commit looks like it sure does address my problem.
 I'm really just here to extend a sincere THANK YOU, to Tejun and all the people
that work on this stuff.

I'm not sure if it matters or not, but for whatever reason on my box, the
problem happens pretty reliably after a long power off cycle (its been off >18
hours when I turn it on). I've never seen it fail on a subsequent reboot, even
with a short power cycle.  I may have to try compiling the kernel for myself to
see if it truly fixes it. I haven't built a kernel in a long time, but maybe
I'll give a whirl again.

Again thanks!

- Tim


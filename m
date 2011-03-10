From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 30802] exception & eSATA hard link resets
Date: Thu, 10 Mar 2011 19:40:23 GMT
Message-ID: <201103101940.p2AJeNpK008906@demeter1.kernel.org>
References: <bug-30802-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter1.kernel.org ([140.211.167.39]:51985 "EHLO
	demeter1.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125Ab1CJTkZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Mar 2011 14:40:25 -0500
Received: from demeter1.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter1.kernel.org (8.14.4/8.14.3) with ESMTP id p2AJeNbP008908
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Thu, 10 Mar 2011 19:40:23 GMT
In-Reply-To: <bug-30802-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=30802





--- Comment #7 from Anonymous Emailer <anonymous@kernel-bugs.osdl.org>  2011-03-10 19:40:20 ---
Reply-To: zrubish@googlemail.com

Hi,
you are right in all points:
- it is that kind of disk
- I was not using original power supply, because I thought the stronger one
with the more convenient switch should work... Maybe switch is broken, but
doesn't matter now.

I've asked the dealer for the original and it works now. I've tested with
more demanding tests and not a single problem reported. Issue can be closed.

Thank you very much for *excellent* support (among best in my 15 years
professional IT career),
Damjan

P.S.: I'll obey guidelines about report in case I'll be in the position to
do it again (not likely though). However, I intend to attach logs that way
at the very beginning, but web UI looked for me like there can be only one
file attached. Therefore I've decided for an archive. Sorry.

2011/3/10 <bugzilla-daemon@bugzilla.kernel.org>

> https://bugzilla.kernel.org/show_bug.cgi?id=30802
>
>
> Tejun Heo <tj@kernel.org> changed:
>
>           What    |Removed                     |Added
>
> ----------------------------------------------------------------------------
>                 CC|                            |tj@kernel.org
>
>
>
>
> --- Comment #6 from Tejun Heo <tj@kernel.org>  2011-03-10 10:40:22 ---
> First of all, please don't paste kernel log in-line and don't attach them
> as
> tar.gz either unless the file is really big.  Attach them as separate
> text/plain files.
>
> It definitely looks like hardware problem to me.  You're trying to use wd
> raptor 15k rpm drive, right?  I don't know your setup but it could be that
> the
> enclosure you're using isn't upto the task power-wise.  The FLUSH_CACHE
> failure
> combined with PHY going down is also indicative of power problems.  Can you
> please do the followings?
>
> 1. Boot and run "smartctl -a" on the hard drive.
> 2. Trigger the problem.
> 3. Reset the computer but don't power cycle the enclosure.
> 4. Run "smartctl -a" on the drive again.
>
> Post the two outputs from the smartctl.
>
> Thanks.
>
> --
> Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
> ------- You are receiving this mail because: -------
> You reported the bug.
>

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are on the CC list for the bug.

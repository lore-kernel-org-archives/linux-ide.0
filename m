From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 30802] exception & eSATA hard link resets
Date: Thu, 10 Mar 2011 08:51:10 GMT
Message-ID: <201103100851.p2A8pAYr025847@demeter2.kernel.org>
References: <bug-30802-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter2.kernel.org ([140.211.167.42]:56497 "EHLO
	demeter2.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271Ab1CJIvL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Mar 2011 03:51:11 -0500
Received: from demeter2.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter2.kernel.org (8.14.4/8.14.3) with ESMTP id p2A8pAxZ025848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Thu, 10 Mar 2011 08:51:11 GMT
In-Reply-To: <bug-30802-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=30802





--- Comment #4 from Anonymous Emailer <anonymous@kernel-bugs.osdl.org>  2011-03-10 08:51:08 ---
Reply-To: zrubish@googlemail.com

Hi,
it does not recover. I have to reboot.
Br,

2011/3/10 <bugzilla-daemon@bugzilla.kernel.org>

> https://bugzilla.kernel.org/show_bug.cgi?id=30802
>
>
> Robert Hancock <hancockrwd@gmail.com> changed:
>
>           What    |Removed                     |Added
>
> ----------------------------------------------------------------------------
>                 CC|                            |hancockrwd@gmail.com
>
>
>
>
> --- Comment #3 from Robert Hancock <hancockrwd@gmail.com>  2011-03-10
> 02:23:40 ---
> So you're getting stuff like:
>
> [20698.759685] ata6: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action
> 0xe
> frozen
> [20698.759691] ata6: irq_stat 0x00400040, connection status changed
> [20698.759697] ata6: SError: { PHYRdyChg CommWake DevExch }
> [20698.759706] ata6: hard resetting link
>
> Your controller's reporting a bunch of link state change events occurring.
> My
> first inclination is to suspect a problem with the eSATA cable or drive
> enclosure. A lot of these seem to be rather flaky as far as power and/or
> the
> solidity of the cable connections.
>
> Does it recover if you disconnect/power off and reconnect the drive?
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

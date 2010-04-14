From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14994] Random Panic/Freeze due to BUG: unable to handle kernel
 NULL pointer dereference at 00000024(?)
Date: Wed, 14 Apr 2010 20:50:56 GMT
Message-ID: <201004142050.o3EKou9M002724@demeter.kernel.org>
References: <bug-14994-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:54140 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755688Ab0DNUvF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Apr 2010 16:51:05 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o3EKp05b002736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Wed, 14 Apr 2010 20:51:00 GMT
In-Reply-To: <bug-14994-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=14994





--- Comment #22 from Anonymous Emailer <anonymous@kernel-bugs.osdl.org>  2010-04-14 20:48:26 ---
Reply-To: bp@alien8.de

From: Borislav Petkov <bp@alien8.de>
Date: Wed, Apr 14, 2010 at 10:07:37AM +0200

Hi,

 [ Mark, please try replying with a simple mail instead over bugzilla
 since it is much easier to work that way, thanks ]

> --- Comment #21 from Marc H. Thoben <kernelbug@develz.org>  2010-04-14 18:42:53 ---
> Created an attachment (id=26001)
 --> (https://bugzilla.kernel.org/attachment.cgi?id=26001)
>  --> (https://bugzilla.kernel.org/attachment.cgi?id=26001)
> dmesg, normal ide-cd_mod, tainted kernel 2.6.34-rc4
> 
> Pity I couldn't get Nouveau working with 2.6.34-rc4 without recompiling X/Mesa
> - which I am not able to.
> 
> So I ran Nvidia again - but it's the same kernel panic, I believe.

No, tainted kernel doesn't help. The only info I get from this is that
it might be that the proprietary crap interferes with the cdrom. How do
I know it doesn't?

Well, I don't because I can't look at the source code. So the reason
I'm asking you to retry without the nvidia driver is so that we can be
really sure whether there's a bug.

Alternatively, if feel like you must use the nvidia driver, you can
always try libata and use the scsi sr_mod driver for your cdrom. Simply
enable CONFIG_BLK_DEV_SR or since you're using distro kernel, simply
blacklist ide-cd_mod and load sr_mod (or something to that extent -
there should be some description how to do this the debian way so use
your favourite search engine).

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.

From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14994] Random Panic/Freeze due to BUG: unable to handle kernel
 NULL pointer dereference at 00000024(?)
Date: Sun, 11 Apr 2010 19:17:22 GMT
Message-ID: <201004111917.o3BJHMTf006466@demeter.kernel.org>
References: <bug-14994-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:46930 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693Ab0DKTR2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Apr 2010 15:17:28 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o3BJHNVJ006475
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Sun, 11 Apr 2010 19:17:23 GMT
In-Reply-To: <bug-14994-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=14994





--- Comment #13 from Borislav Petkov <bbpetkov@yahoo.de>  2010-04-11 19:17:08 ---
(In reply to comment #10)
> when I got the new hardware I bought it with an ATI card. For 2 weeks it kept
> crashing - no matter if ran the closed-source driver or without. Blaming the
> ATI driver I bought an Nvidia card and had the same problem. I ran Xorg with
> the nvidia driver, with nv and with vesa. It happened for all of them (yes, I
> made sure the kernel wasn't tainted by nvidia's driver).

Nope, you can't do that. When you load a proprietary driver, your kernel is
automatically tainted. It is in the oops:

Apr 11 18:34:29 sunshade [ 332.126868] Pid: 0, comm: swapper Tainted: P        
  2.6.32-4-amd64+mht.1 #1 P55A-UD4

The P means "Proprietary module has been loaded."

And there was a reason I asked you to try this without the proprietary
nvidia driver. Especially if you have a bunch of nvidia-driver functions
in the backtrace:

Apr 11 18:34:29 sunshade [ 332.127092]  [<ffffffffa0ac506c>] ?
cdrom_newpc_intr+0x819/0x84a [ide_cd_mod]
Apr 11 18:34:29 sunshade [ 332.127095]  [<ffffffffa0ac4853>] ?
cdrom_newpc_intr+0x0/0x84a [ide_cd_mod]
Apr 11 18:34:29 sunshade [ 332.127101]  [<ffffffffa010df5c>] ?
ide_intr+0x17c/0x20f [ide_core]
Apr 11 18:34:29 sunshade [ 332.127105]  [<ffffffff81048985>] ?
default_wake_function+0x0/0xf
Apr 11 18:34:29 sunshade [ 332.127109]  [<ffffffff81092dd4>] ?
handle_IRQ_event+0x55/0x109
Apr 11 18:34:29 sunshade [ 332.127112]  [<ffffffff8109489d>] ?
handle_fasteoi_irq+0x76/0xac
Apr 11 18:34:29 sunshade [ 332.127171]  [<ffffffff81013843>] ?
handle_irq+0x17/0x1d
Apr 11 18:34:29 sunshade [ 332.127174]  [<ffffffff81012f0f>] ? do_IRQ+0x54/0xb2
Apr 11 18:34:29 sunshade [ 332.127177]  [<ffffffff81011413>] ?
ret_from_intr+0x0/0x11
Apr 11 18:34:29 sunshade [ 332.127299]  [<ffffffffa05bbf09>] ?
_nv005370rm+0x20/0x22 [nvidia]
Apr 11 18:34:29 sunshade [ 332.127429]  [<ffffffffa040aa19>] ?
_nv012025rm+0x35/0xe1 [nvidia]
Apr 11 18:34:29 sunshade [ 332.127561]  [<ffffffffa04728f3>] ?
_nv011220rm+0x1498/0x15a7 [nvidia]
Apr 11 18:34:29 sunshade [ 332.127680]  [<ffffffffa04feb15>] ?
_nv008600rm+0x37d/0x813 [nvidia]
Apr 11 18:34:29 sunshade [ 332.127798]  [<ffffffffa04fdfc6>] ?
_nv008603rm+0x66/0x90 [nvidia]
Apr 11 18:34:29 sunshade [ 332.127907]  [<ffffffffa05bcbc0>] ?
_nv003827rm+0xa0/0xd3 [nvidia]
Apr 11 18:34:29 sunshade [ 332.128017]  [<ffffffffa05c2853>] ?
rm_isr_bh+0x5a/0x8d [nvidia]

See all those _nv0* things, they may very well be puzzling your cdrom
drive. I know its crazy. So yes, please try the whole thing _without_
the nvidia driver and catch the logs again exactly as you've done it
now.

Thanks,
Boris.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.

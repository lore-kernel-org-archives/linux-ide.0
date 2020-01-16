Return-Path: <SRS0=KJEs=3F=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99921C33CAF
	for <linux-ide@archiver.kernel.org>; Thu, 16 Jan 2020 22:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A7420748
	for <linux-ide@archiver.kernel.org>; Thu, 16 Jan 2020 22:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732827AbgAPWhN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 16 Jan 2020 17:37:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:40240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729631AbgAPWhM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 16 Jan 2020 17:37:12 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ide@vger.kernel.org
Subject: [Bug 205107] No HDD spindown/parking on shutdown
Date:   Thu, 16 Jan 2020 22:37:11 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo io_ide@kernel-bugs.osdl.org
X-Bugzilla-Product: IO/Storage
X-Bugzilla-Component: IDE
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: helder.armando@hotmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: io_ide@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-205107-11633-s45gC2zgRK@https.bugzilla.kernel.org/>
In-Reply-To: <bug-205107-11633@https.bugzilla.kernel.org/>
References: <bug-205107-11633@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=205107

--- Comment #9 from Hélder (helder.armando@hotmail.com) ---
Greetings,

I'm sorry for the delay, I have been pushing this aside for too long. I was
stuck at trying out a non-systemd Linux distro as I could not download the
image. The distro was going to be Antix.
This is related to another problem I have been having with Linux. 
The rtl8188ee driver makes my computer always disconnect from the Wifi and this
seems to be a recurring problem for users of the same computer model as mine
(Toshiba Satellite series).
I have tried so many solutions for the past few months, I can't even recall
half of them.

>> 08:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8188EE
>> Wireless Network Adapter (rev 01)
I am not in a position where I can try wired connections.

My Wifi connection continuously drops (on average, every 2 mins). The problem
is not the router's or the provider's, as every other device (incl. my
computer, back when it ran Windows 10) seem to connect just fine. I have
updated the kernel and the problem got fixed for a while, but it just started
happening again after not too long. It disconnects on its own, over time, but I
think it disconnects sooner when I start downloading things.
If I restart the network manager it seems to connect for a while only to drop
again right away. 
As a side note, if I'm using the Internet on the phone at the same, it seems to
work slightly better. This led me to try out more solutions, including those
related to disabling power-saving, but all in vain. What a strange scenario - I
was only able to update the kernel by leaving my phone simultaneously playing a
10-hour BBC Earth video on Youtube, right beside my computer. Even then it kept
on dropping, only this time less as often.


When it comes to the HDD problem, I have been using that script ever since.
The cable IS usb3, but connected to a usb2 port. If it connected to usb3, it
would keep shutting down with every slight touch to the chord, so I ignore its
"usb3 power".

I'm not overthinking the problem because it is clearly not healthy for the HDD.
Additionally, it clearly seems to be a software problem; shouldn't bugs always
be fixed? I may have found a fix by writing down a script, but why can't this
be fixed on the kernel at once? This is still unsolved.
I've already stated that the problem does not occur on Windows or FreeBSD.

You wondered about which drives were affected.
Sda may or may not be affected, but the external hdd is on sdb/sdc and it is
definitely not being shut down properly.

Mint ran the same version of the kernel, yes, but I tried it primarily to see
if the problem was down to Lubuntu's code.

I filed it under IDE by mistake.
If I umount  but do not unplug the HDD, the problem does not occur.

I await your reply,
Hélder

-- 
You are receiving this mail because:
You are watching the assignee of the bug.

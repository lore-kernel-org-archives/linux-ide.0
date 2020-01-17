Return-Path: <SRS0=uYUo=3G=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4E9C33CB1
	for <linux-ide@archiver.kernel.org>; Fri, 17 Jan 2020 14:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB992087E
	for <linux-ide@archiver.kernel.org>; Fri, 17 Jan 2020 14:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgAQOU3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 17 Jan 2020 09:20:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:47324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbgAQOU3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 17 Jan 2020 09:20:29 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ide@vger.kernel.org
Subject: [Bug 205107] No HDD spindown/parking on shutdown
Date:   Fri, 17 Jan 2020 14:20:28 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo io_ide@kernel-bugs.osdl.org
X-Bugzilla-Product: IO/Storage
X-Bugzilla-Component: IDE
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: kaurman@outlook.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: io_ide@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-205107-11633-gnOHGbqqMf@https.bugzilla.kernel.org/>
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

--- Comment #10 from Kaur Männamaa (kaurman@outlook.com) ---
(In reply to Hélder from comment #9)
> Greetings,
> 
> I'm sorry for the delay, I have been pushing this aside for too long. I was
> stuck at trying out a non-systemd Linux distro as I could not download the
> image. The distro was going to be Antix.
> This is related to another problem I have been having with Linux. 
> The rtl8188ee driver makes my computer always disconnect from the Wifi and
> this seems to be a recurring problem for users of the same computer model as
> mine (Toshiba Satellite series).
> I have tried so many solutions for the past few months, I can't even recall
> half of them.
> 
> >> 08:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8188EE
> >> Wireless Network Adapter (rev 01)
> I am not in a position where I can try wired connections.
> 

Indeed, there seem to be quite a few threads about this or very similar issues.
Had no time for proper research but there seemed to be some solutions as well
so hopefully you'll find a way to solve this eventually. If you're stuck, feel
free to email me & describe what you have tried so far. I'm no expert but I
wouldn't mind looking into this.

However, as for now, let's concentrate on the problem at hand.


> When it comes to the HDD problem, I have been using that script ever since.
> The cable IS usb3, but connected to a usb2 port. If it connected to usb3, it
> would keep shutting down with every slight touch to the chord, so I ignore
> its "usb3 power".
> 
> I'm not overthinking the problem because it is clearly not healthy for the
> HDD. Additionally, it clearly seems to be a software problem; shouldn't bugs
> always be fixed? I may have found a fix by writing down a script, but why
> can't this be fixed on the kernel at once? This is still unsolved.
> I've already stated that the problem does not occur on Windows or FreeBSD.

Don't get me wrong. I had no intention of belittling the problem. I asked as
you had included multiple drives, which initially confused me a bit. As for the
problem as such, it is certainly worth at least looking into. While a drive can
take a considerable number of such brutal shutdowns, the problem should indeed
be dealt with in the long run.

Let's assume for now that it affects only external / USB drives. As I
understand, this is what your SMART data & observations seem to support as
well.

I did some testing (using linux 5.4.12) with my own external drive and had
rather intriguing results. In short, the problem seems to exist on shutdown
(cannot read SMART to confirm but that's what my ears tell me) but not when the
system is halted (shutdown -H). Halting results in the drive spinning down as
it should. In my case internal drives are fine either way as expected, no
shutdown issues whatsoever.


This may indeed mean that power is cut too early as you suggested but I dare
not speculate here at the moment. 

Perhaps I can test with some other external drives in the case of which SMART
data is available (easy to access). Just to check once more that the problem is
indeed there.

I'll contact someone more knowledgeable. Let's see what they have to say.



Kaur

-- 
You are receiving this mail because:
You are watching the assignee of the bug.

From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11943] Boot fails at scsi0:MESH with hde: lost interrupt, AEC6260
Date: Sun,  9 Nov 2008 16:10:48 -0800 (PST)
Message-ID: <20081110001048.54378108042@picon.linux-foundation.org>
References: <bug-11943-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44686 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756281AbYKJAKv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Nov 2008 19:10:51 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mAA0AmYd004734
	for <linux-ide@vger.kernel.org>; Sun, 9 Nov 2008 16:10:49 -0800
In-Reply-To: <bug-11943-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11943





------- Comment #22 from eshaffer1@mac.com  2008-11-09 16:10 -------
(In reply to comment #20)
> Ah, now I understand -- "irqpoll" only helps in getting past IDE messages but
> boot still hangs on mesh driver initialization, right? [ I thought that you can
> now boot successfully the installed system using "irqpoll". ]
> 
> If so this really looks more like a generic platform problem affecting both IDE
> and SCSI (mesh driver has an "interesting" IRQ handling routine that will loop
> forever if IRQ is not cleared).
> 

Correct, "irqpoll /irqfixup" only allow the system to read the partition and
disk info prior to scsi0 : MESH init. Still results in hang at scsi0 : MESH
with subsequent hde/f/h: lost interrupt messages. Installed system has never
successfully completed boot with or without "irqpoll / irqfixup". 

It is curious though that Live CD and alternate CD both load and operate
without error (no hang or stall)...this is dmesg snip from Live CD:

[   14.024619] /build/buildd/linux-2.6.24/drivers/hid/usbhid/hid-core.c:
v2.6:USB HID core driver
[   14.812490] scsi0 : MESH
[   18.354244] hde: max request size: 128KiB
[   18.376470] hde: 195813072 sectors (100256 MB) w/8192KiB Cache,
CHS=65535/16/63
[   18.378049] hde: cache flushes supported
[   18.378165]  hde: [mac] hde1 hde2 hde3 hde4
[   18.387956] hdf: max request size: 128KiB
[   18.401188] hdf: 240121728 sectors (122942 MB) w/7936KiB Cache,
CHS=65535/16/63
[   18.401337] hdf: cache flushes supported
[   18.401413]  hdf: [mac] hdf1 hdf2 hdf3 hdf4 hdf5 hdf6 hdf7 hdf8 hdf9 hdf10
hdf11
[   18.410500] hdh: max request size: 128KiB
[   18.430172] hdh: 195813072 sectors (100256 MB) w/8192KiB Cache,
CHS=65535/16/63
[   18.432317] hdh: cache flushes supported
[   18.432417]  hdh: [mac] hdh1 hdh2 hdh3 hdh4


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.

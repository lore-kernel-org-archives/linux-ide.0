From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 111151] [pata_amd][pata_acpi] Internal base address register
 error prevents initialization of PATA drive
Date: Fri, 22 Jan 2016 20:57:09 +0000
Message-ID: <bug-111151-11633-mRlI54EmX2@https.bugzilla.kernel.org/>
References: <bug-111151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54944 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754854AbcAVU5N (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 Jan 2016 15:57:13 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 90142202F2
	for <linux-ide@vger.kernel.org>; Fri, 22 Jan 2016 20:57:12 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 185D42058C
	for <linux-ide@vger.kernel.org>; Fri, 22 Jan 2016 20:57:10 +0000 (UTC)
In-Reply-To: <bug-111151-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=111151

Alan <alan@lxorguk.ukuu.org.uk> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |alan@lxorguk.ukuu.org.uk

--- Comment #1 from Alan <alan@lxorguk.ukuu.org.uk> ---
You say "sata|ide interface: based on Marvell 88i8030 controller chip"

The 88i8030 is a PATA/SATA bridge, it's not a controller chip. It's an ancient
lump of glue for nailing a SATA driver to a PATA port.


[1.916367] pata_amd 0000:00:09.0: version 0.4.1
[1.916383] pata_amd 0000:00:09.0: can't enable device: BAR 0 [io  size 0x0008]
not assigned
[1.916453] pata_amd: probe of 0000:00:09.0 failed with error -22
[2.509228] pata_acpi 0000:00:09.0: can't enable device: BAR 0 [io  size 0x0008]
not assigned
[2.509299] pata_acpi: probe of 0000:00:09.0 failed with error -22

So the BIOS hasn't configured the controller by the look of it. That or it is
disabled in the NVRAM settings.

It tried pata_amd, that failed it tried pata_acpi that failed for the same
reason.

The Ultra-AL is known to work so that suggests to me there's perhaps some kind
of setting error on your board.

Might be useful if you could do an lspci -vvxxx with the box booting something
like a live USB installation, and then attach it. That would at least allow
folks to see how the firmware has left the setup.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.

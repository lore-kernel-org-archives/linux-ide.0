From: "Huang, Shane" <Shane.Huang@amd.com>
Subject: RE: AMD 890GX vs 6Gbps SATA?
Date: Mon, 15 Nov 2010 15:45:19 +0800
Message-ID: <1E8B869C0C6913418421A406C094DF7C82D812@sshaexmb1.amd.com>
References: <2DEEA3AB13739D45A22ADDB5086AEA0B915107@sshaexmb1.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:6921 "EHLO
	VA3EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752808Ab0KOHpd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 Nov 2010 02:45:33 -0500
Content-Class: urn:content-classes:message
In-Reply-To: <2DEEA3AB13739D45A22ADDB5086AEA0B915107@sshaexmb1.amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, cloos@jhcloos.com
Cc: "Xu, Andiry" <Andiry.Xu@amd.com>, "Petkov, Borislav" <Borislav.Petkov@amd.com>, "Huang, Shane" <Shane.Huang@amd.com>

Hi James,

Can you send us your full dmesg and lspci?

I submitted one patch to support SATA AHCI 6Gbps message
in 2008, does your kernel contain it?

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commi
t;h=8522ee25f3a645577d41e71328cd4fcf8610dfeb


Thanks,
Shane

----- Forwarded message from James Cloos <cloos@jhcloos.com> -----

Date: Sun, 14 Nov 2010 12:50:41 -0500
From: James Cloos <cloos@jhcloos.com>
To: linux-ide@vger.kernel.org
Subject: AMD 890GX vs 6Gbps SATA?
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/24.0.50 (gnu/linux)

All of the ad copy and doc I can find claim that the sata controller in
the 890gx supports 6Gbps sata3.  But I still get this:

ahci 0000:00:11.0: AHCI 0001.0200 32 slots 6 ports 3 Gbps 0x3f impl SATA
mode
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: ATA-8: WDC WD1002FAEX-xxxxxx, 05.xxxxx, max UDMA/133

I hadn't noticed before because that box's first drive only supports 3
Gbps.

Does the 6Gpbs mode require that all of the disks are sata3?  (That
would
be /most/ annoying, given that optical drives all seem to be 1.5Gbps.)

Did MSI screw something up on the board?

Or is the ad copy exaggerative?

I took a look though the bios config; I didn't find anything relevant.

-JimC


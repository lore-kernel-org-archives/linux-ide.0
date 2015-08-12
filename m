From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 102741] pata_hpt37x driver refuses to operate with Adaptec
 1200A at UDMA/100
Date: Wed, 12 Aug 2015 18:41:02 +0000
Message-ID: <bug-102741-11633-fOQXV9YrCg@https.bugzilla.kernel.org/>
References: <bug-102741-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43039 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750771AbbHLSlK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 12 Aug 2015 14:41:10 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id D7E2120722
	for <linux-ide@vger.kernel.org>; Wed, 12 Aug 2015 18:41:04 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id E7D322071E
	for <linux-ide@vger.kernel.org>; Wed, 12 Aug 2015 18:41:02 +0000 (UTC)
In-Reply-To: <bug-102741-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=102741

--- Comment #1 from Sergei Shtylyov <sshtylyov@ru.mvista.com> ---
(In reply to Andreas E from comment #0)

> The card is properly initialized using the pata_hpt370x kernel driver.

pata_hpt37x, you mean. I've already fixed the subject.

> However, it will always show as UDMA/66 which simply cannot be. Of course,
> I've even tried brand-new cables with it, but I think it has nothing to so
> with that.

Sure.

> The drive connected to it is a Samsung SpinPoint T133 (HD 400 LD), which
> *definitly* can do UDMA/100.
> The hardware is capable of doing so, too:

> # lspci -knn |grep HPT
> 01:09.0 Mass storage controller [0180]: HighPoint Technologies, Inc. 
> HPT366/368/370/370A/372/372N [1103:0004] (rev 03)
>  Subsystem: HighPoint Technologies, Inc. HPT370 UDMA100 [1103:0005]

Yes, it's the original HPT370 chip.

> Now let's take a look at the dmesg from kernel:

> [    1.992359] pata_hpt37x: HPT370 using 33MHz bus clock
> [    2.015478] scsi host10: pata_hpt37x
> [    2.023431] scsi host11: pata_hpt37x
> 
> [    2.023610] ata11: PATA max UDMA/66 cmd 0x8c00 ctl 0x9000 bmdma 0x9c00
> irq 19
> [    2.023614] ata12: PATA max UDMA/66 cmd 0x9400 ctl 0x9800 bmdma 0x9c08
> irq 19
> 
> ('ata12' is the Samsung drive; 'ata11' is currently empty.)

> This can't be correct.
> Why only at such low speed, i. e. UDMA/66?

The HPT370 speed was artificiallly limited to UDMA/66, mimicking what I did for
drivers/ide/hpt366.c. And in case of the IDE driver, the reason was two--fold:

1) UDMA/100 is not properly reachable with 33 MHz PCI clock;
2) UDMA/66 showed much better figures than UDMA/100 on HPT370 I was testing on.

There were good reasons not to use DPLL clock, which is 48 MHz on HPT370[A].

-- 
You are receiving this mail because:
You are watching the assignee of the bug.

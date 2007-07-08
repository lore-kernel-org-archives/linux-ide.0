From: "buthysia@virgilio.it" <buthysia@virgilio.it>
Subject: invalid map value
Date: Sun, 8 Jul 2007 10:28:21 +0100 (GMT+01:00)
Message-ID: <113a52882e6.buthysia@virgilio.it>
Reply-To: "buthysia@virgilio.it" <buthysia@virgilio.it>
Mime-Version: 1.0
Content-Type: text/plain;charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vsmtp4.tin.it ([212.216.176.224]:59751 "EHLO vsmtp4.tin.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751650AbXGHJoI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 8 Jul 2007 05:44:08 -0400
Received: from pswm13.cp.tin.it (192.168.70.37) by vsmtp4.tin.it (7.3.122)
        id 4676686F001E82CD for linux-ide@vger.kernel.org; Sun, 8 Jul 2007 11:28:22 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello Jeff,
is correct this email address??!(linux-ide@vger.kernel.org)

My problem:
ata_piix 0000:00:1f.2: MAP [ P0 P2 XX XX ]
ata_piix 0000:
00:1f.2: invalid MAP value 0

Controller:
00:1f.2 IDE interface: Intel 
Corporation 82801GBM/GHM (ICH7 Family)
SATA IDE Controller (rev 02) 
(prog-if 8f [Master SecP SecO PriP PriO])
Subsystem: Sony Corporation 
Unknown device 81ef
Flags: bus master, 66MHz, medium devsel, latency 0, 
IRQ 21
I/O ports at 18c8 [size=8]
I/O ports at 18ac [size=4]
I/O ports 
at 18c0 [size=8]
I/O ports at 18a8 [size=4]
I/O ports at 18b0 [size=16]
Memory at d2304400 (32-bit, non-prefetchable) [size=1K]
Capabilities: 
[70] Power Management version 2

the notebook is a sony vaio fe-21m 
with hd FUJITSU MHV2160B.
kernel:Linux version 2.6.20-gentoo-r8 
compiled with gcc version 4.1.2.

Is it a serious problem?!?...is there 
a workaround to fix this?!
Sorry for my english!
Regards!
Daniele.

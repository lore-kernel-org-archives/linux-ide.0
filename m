From: Tejun Heo <htejun@gmail.com>
Subject: Re: ata_piix on MacBook4,1: fail to startup in a certain situation
Date: Wed, 28 May 2008 23:23:48 +0900
Message-ID: <483D6AF4.8000502@gmail.com>
References: <20080528075106.F2C3D29C127@m02-blue.in.shared-server.net>	<20080528075747.A18A5114160@m03-blue.in.shared-server.net>	<483D1429.3080804@gmail.com> <20080528092117.4A5177080E8@m04-blue.in.shared-server.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020600070609050901060602"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.227]:14030 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbYE1OXy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 May 2008 10:23:54 -0400
Received: by rv-out-0506.google.com with SMTP id l9so3548712rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 28 May 2008 07:23:54 -0700 (PDT)
In-Reply-To: <20080528092117.4A5177080E8@m04-blue.in.shared-server.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: MATSUBAYASHI 'Shaolin' Kohji <shaolin@rhythmaning.org>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------020600070609050901060602
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

MATSUBAYASHI 'Shaolin' Kohji wrote:
> At Wed, 28 May 2008 17:13:29 +0900,
> Tejun Heo wrote:
>> Please post the result of "lspci -nnvvv".  Thanks.
> 
> Thanks, I have attached the lspci -nnvvv output far below:
> 
> 
>>> At Wed, 28 May 2008 16:51:05 +0900,
>>> MATSUBAYASHI 'Shaolin' Kohji wrote:
>>>> Hi, I've been running 2.6.25 kernel with the patch you posted
>>>> (cb6716c879ecf49e2af344926c6a476821812061) on newest MacBook4,1
>>>> and works very fine except a certain situation.
>>>>
>>>>
>>>> The case I could reproduced is as follows:
>>>>
>>>> (1) boot kernel 2.6.25 w/ your patch (or 2.6.25.4 which already
>>>>     includes your patch), WITH AC ADAPTER PLUGGED
>>>> (2) before executing "reboot", UNPLUG AC ADAPTER
>>>> (3) then execute "reboot"
>>>> (4) system reboots, but stops booting with the following messages:
>>>>     ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
>>>> (5) then if I plug the AC adapter, system likely to continue booting
>>>>     with the following message:
>>>>     ata_piix 0000:00:1f.2: SCR access via SIDPR is available but doesn't work
>>>> (5a) sometimes system still keep stopping even though I plug the AC adapter
>>>>
>>>>
>>>> By inserting many printk() functions on ata_piix.c,
>>>> I confirmed the pause (between 4 and 5) occurs just before
>>>> the following line:
>>>>
>>>>     /* SCR access via SIDPR doesn't work on some configurations.
>>>>      * Give it a test drive by inhibiting power save modes which
>>>>      * we'll do anyway.
>>>>      */
>>>>     scontrol = piix_sidpr_read(dev0, SCR_CONTROL);
>>>>
>>>>
>>>> I also confirmed that the following:
>>>>
>>> (2a) before executing "poweroff", KEEP AC ADAPTER PLUGGED
>>> (3a) then execute "poweroff"
>>> (3b) system shuts down, then I UNPLUG AC ADAPTER
>>> (4a) press power button to boot, and sometimes stops booting like
>>>      the above (4) and sometimes booting fine without any problems
> 
> 
> $ sudo /sbin/lspci -nnvvv
> 00:1f.2 IDE interface [0101]: Intel Corporation 82801HBM/HEM (ICH8M/ICH8M-E) SATA IDE Controller [8086:2828] (rev 03) (prog-if 8f [Master SecP SecO PriP PriO])
> 	Subsystem: Apple Computer Inc. Unknown device [106b:00a1]
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0
> 	Interrupt: pin B routed to IRQ 18
> 	Region 0: I/O ports at 60f8 [size=8]
> 	Region 1: I/O ports at 611c [size=4]
> 	Region 2: I/O ports at 60f0 [size=8]
> 	Region 3: I/O ports at 6118 [size=4]
> 	Region 4: I/O ports at 6020 [size=16]
> 	Region 5: I/O ports at 4000 [size=16]
> 	Capabilities: [70] Power Management version 3
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

Hmmm... What is apple doing with ich8m?  :-(

Does the attached patch fix the problem?

-- 
tejun

--------------020600070609050901060602
Content-Type: text/x-patch;
 name="ata_piix-apple.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ata_piix-apple.patch"

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index a9027b8..4e90d94 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -251,6 +251,7 @@ static const struct pci_device_id piix_pci_tbl[] = {
 	{ 0x8086, 0x2828, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
 	/* Mobile SATA Controller IDE (ICH8M), Apple */
 	{ 0x8086, 0x2828, 0x106b, 0x00a0, 0, 0, ich8m_apple_sata },
+	{ 0x8086, 0x2828, 0x106b, 0x00a1, 0, 0, ich8m_apple_sata },
 	/* SATA Controller IDE (ICH9) */
 	{ 0x8086, 0x2920, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
 	/* SATA Controller IDE (ICH9) */

--------------020600070609050901060602--

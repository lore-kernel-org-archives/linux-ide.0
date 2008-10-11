From: Lars Michael Jogback <lm@jogback.se>
Subject: Problem w/ hotplug on sata_sil24 w/ PMP (sil3726)
Date: Sat, 11 Oct 2008 16:27:35 +0200
Message-ID: <20081011142735.GB5904@cleopatra.jogback.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.jogback.se ([192.165.82.10]:60135 "EHLO mail.jogback.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753296AbYJKP2m (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 11 Oct 2008 11:28:42 -0400
Received: from [2a00:801:a:1::1:1] (HELO cleopatra.jogback.se)
  by mail.jogback.se (CommuniGate Pro SMTP 5.2.6)
  with ESMTPS id 8267801 for linux-ide@vger.kernel.org; Sat, 11 Oct 2008 16:28:29 +0200
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I've got trouble to get a drive to reconnect to the system after
hotplug.

I'm using Linux 2.6.26 (Debian 2.6.26-8) on AMD64. The controller card
is any Sil3124-based, and the disks are connected to a Sil3726.

The disks in this case (but I've got the same behaviour on different
disks) is SAMSUNG HD103UJ. Their Spin_Up_Time according to smartctl is
11030 (which I translate to approx 11 seconds, right?)

The disks are mounted in drivecages.

When I yank the disk this happens:
[75044.264218] ata4.03: exception Emask 0x10 SAct 0x0 SErr 0x4010000 action 0xf
[75044.264322] ata4: SError: { PHYRdyChg DevExch }
[75044.264971] ata4.03: hard resetting link
[75045.007015] ata4.03: SATA link down (SStatus 0 SControl 320)
[75045.007164] ata4: failed to recover some devices, retrying in 5 secs
[75050.035389] ata4.03: hard resetting link
[75050.371528] ata4.03: SATA link down (SStatus 0 SControl 320)
[75050.371672] ata4: failed to recover some devices, retrying in 5 secs
[75055.387768] ata4.03: hard resetting link
[75055.724346] ata4.03: SATA link down (SStatus 0 SControl 320)
[75055.724797] ata4.03: disabled
[75056.228377] ata4: EH complete
[75056.228469] ata4.03: detaching (SCSI 4:3:0:0)
[75056.228830] sd 4:3:0:0: [sdt] Synchronizing SCSI cache
[75056.228959] sd 4:3:0:0: [sdt] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[75056.229149] sd 4:3:0:0: [sdt] Stopping disk
[75056.229250] sd 4:3:0:0: [sdt] START_STOP FAILED
[75056.229346] sd 4:3:0:0: [sdt] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK

And when I plug the disk this happens.
[75096.396748] ata4.03: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0xf
[75096.396849] ata4: SError: { PHYRdyChg CommWake DevExch }
[75096.716825] ata4.03: hard resetting link
[75097.461358] ata4.03: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[75097.477638] ata4.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[75097.477745] ata4.15: hard resetting link
[75099.622365] ata4.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[75099.943070] ata4.00: hard resetting link
[75100.278871] ata4.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[75100.278971] ata4.01: hard resetting link
[75100.615444] ata4.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[75100.615545] ata4.02: hard resetting link
[75100.950786] ata4.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[75100.950887] ata4.03: hard resetting link
[75101.287528] ata4.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[75101.287626] ata4.05: hard resetting link
[75101.624445] ata4.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[75101.640432] ata4.00: configured for UDMA/100
[75101.652704] ata4.01: configured for UDMA/100
[75101.666964] ata4.02: configured for UDMA/100
[75101.684114] ata4.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[75101.684211] ata4.15: hard resetting link
[75103.828553] ata4.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[75104.149612] ata4.00: hard resetting link
[75104.486756] ata4.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[75104.486855] ata4.01: hard resetting link
[75104.823978] ata4.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[75104.824079] ata4.02: hard resetting link
[75105.162597] ata4.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[75105.162698] ata4.03: hard resetting link
[75105.501892] ata4.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[75105.501993] ata4.05: hard resetting link
[75105.838207] ata4.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[75105.851061] ata4.00: configured for UDMA/100
[75105.863553] ata4.01: configured for UDMA/100
[75105.876447] ata4.02: configured for UDMA/100
[75105.890214] ata4.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[75105.890321] ata4.03: failed to recover link after 3 tries, disabling
[75105.890415] ata4: failed to recover PMP, retrying in 5 secs
[75110.903191] ata4.15: hard resetting link
[75113.144415] ata4.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[75113.788536] ata4.00: hard resetting link
[75114.127956] ata4.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[75114.127956] ata4.01: hard resetting link
[75114.468727] ata4.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[75114.468830] ata4.02: hard resetting link
[75114.803270] ata4.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[75114.803371] ata4.05: hard resetting link
[75115.143819] ata4.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[75115.157855] ata4.00: configured for UDMA/100
[75115.170739] ata4.01: configured for UDMA/100
[75115.183895] ata4.02: configured for UDMA/100
[75115.841430] ata4: EH complete

As I understand it, the first IDENTIFY happens 1 second after hotplug,
the second 5 seconds after hotplug, and the last and third one happens 9
seconds after the hotplug, and as I understand this disk need at least
11 seconds to spin-up.

The only way I can get the disk back online is to yank the cable between
the controller and the PMP, then it works.

Is it someway to extend the timeout to wait for spin-up of the disk?

Best Regards,
/LM


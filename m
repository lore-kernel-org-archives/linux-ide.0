Received: from out198-149.us.a.mail.aliyun.com (out198-149.us.a.mail.aliyun.com [47.90.198.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9792396567
	for <linux-ide@vger.kernel.org>; Thu, 16 Apr 2026 13:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776344711; cv=none; b=lXP2CHbs0ld4UIwzzB71QdEeivs7ibiIG7aWZ4XbmYBYVlAo7gJDefgkCV5q88uwK74EuP8+qHwkX9pbSfXH1WEkUjcvupvU+o7Mt+ecV759X/ASa1yUOccAKNpKe/ppWCrTo39NOTMbUG2RCblruMRtF6gCnF5it3Kl+CM953A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776344711; c=relaxed/simple;
	bh=7oSM03IOroJgWiQLmivDIr1KC4OwlBARWl03xSkQpww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NeaDctJH3uj71t9HvhQK0gDKHqkVPyhKkW37oBrAuwdi9cjZ8vvYY/peKvV1VtzXD1ZFHFdknzZQIo2StpRDzbLd/VeZMzx4IummVaUzo4V6H5ge+HSFUinDPz1ivrmV3jOwT5dUC//Z5RY2d02i6AzCzgvYc6NBjSeeL0FAZBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=alancui.cc; spf=pass smtp.mailfrom=alancui.cc; dkim=pass (2048-bit key) header.d=alancui.cc header.i=@alancui.cc header.b=j6nv611O; arc=none smtp.client-ip=47.90.198.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=alancui.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alancui.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alancui.cc header.i=@alancui.cc header.b="j6nv611O"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=alancui.cc; s=default;
	t=1776344691; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=R4uqxVWsZaB7NWNMMed0IkxkvDaDh95OZPlAoDVLkiE=;
	b=j6nv611OIr0OHgGKqEByX7uYvTojL+7Sz5s1wr4jTm+v3z95BOtdS0ceizitJrQpesQwrE92jVGUAYdZE9Q983hqSOR6feW9NBAeJnEN4t+NVhPH8Oj3tDWPfdl3JAiIoBQG1697okz/46vpFmpIHaxrYrGBRp/Nkw1KYxsx48dl86S/hUodM/fkBSs494BQbgE0OdRyH8W8aPWjv+uL6D+sZiNU/U4MP9KoXCcXPoKb6Hva1m7cVMvB7gL1r+w0lD81XnSX6XBNe20aTrBLdMrnL+Em/nUOLRkgEwMwI+fX5T+ZCwZ6G48LUSHmredhXjLZY3QlqbE+Md75UQLz9w==
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06893432|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00331234-0.000432459-0.996255;FP=6808661802182284598|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032053168;MF=me@alancui.cc;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.hDaej2n_1776344370;
Received: from alanarchdesktop.localnet(mailfrom:me@alancui.cc fp:SMTPD_---.hDaej2n_1776344370 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 16 Apr 2026 20:59:31 +0800
From: AlanCui4080 <me@alancui.cc>
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject:
 Re: Default IDENTIFY timeout is 5000ms which is too short for enterprise
 disks
Date: Thu, 16 Apr 2026 20:59:30 +0800
Message-ID: <23071769.EfDdHjke4D@alanarchdesktop>
In-Reply-To: <ad-HTImFZxdtkD2J@ryzen>
References:
 <14015677.uLZWGnKmhe@alanarchdesktop>
 <6740c3b7-c63c-4181-b36e-962e07bb468f@kernel.org> <ad-HTImFZxdtkD2J@ryzen>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi

On Wednesday, 15 April 2026 20:40=EF=BC=8Cyou wrote=EF=BC=9A

> Alan,
> could you please provide a full dmesg (dmesg that has not been cut)
> when reproducing your problem on kernel v7.0.

Here is a full dmesg before enter the suspend and recovery from it:

$ sudo systemctl suspend

[12951.183287] r8169 0000:07:00.0 enp7s0: Link is Down
[12951.209606] PM: suspend entry (deep)
[12951.253352] Filesystems sync: 0.043 seconds
[12955.016893] Freezing user space processes
[12955.018682] Freezing user space processes completed (elapsed 0.001 secon=
ds)
[12955.018686] OOM killer disabled.
[12955.018688] Freezing remaining freezable tasks
[12955.019625] Freezing remaining freezable tasks completed (elapsed 0.000 =
seconds)
[12955.019644] printk: Suspending console(s) (use no_console_suspend to deb=
ug)
[12955.027700] serial 00:04: disabled
[12955.036574] sd 1:0:0:0: [sda] Synchronizing SCSI cache
[12955.037560] sd 3:0:0:0: [sdb] Synchronizing SCSI cache
[12955.194975] ACPI: PM: Preparing to enter system sleep state S3
[12955.701415] ACPI: PM: Saving platform NVS memory
[12955.701483] Disabling non-boot CPUs ...
[12955.703600] smpboot: CPU 15 is now offline
[12955.706609] smpboot: CPU 14 is now offline
[12955.709581] smpboot: CPU 13 is now offline
[12955.712508] smpboot: CPU 12 is now offline
[12955.715410] smpboot: CPU 11 is now offline
[12955.718240] smpboot: CPU 10 is now offline
[12955.721183] smpboot: CPU 9 is now offline
[12955.724271] smpboot: CPU 8 is now offline
[12955.725278] Spectre V2 : Update user space SMT mitigation: STIBP off
[12955.727089] smpboot: CPU 7 is now offline
[12955.729733] smpboot: CPU 6 is now offline
[12955.732059] smpboot: CPU 5 is now offline
[12955.734550] smpboot: CPU 4 is now offline
[12955.737036] smpboot: CPU 3 is now offline
[12955.739410] smpboot: CPU 2 is now offline
[12955.741822] smpboot: CPU 1 is now offline
[12955.743174] ACPI: PM: Low-level resume complete
[12955.743192] ACPI: PM: Restoring platform NVS memory
[12955.743331] LVT offset 0 assigned for vector 0x400
[12955.743893] Enabling non-boot CPUs ...
[12955.743930] smpboot: Booting Node 0 Processor 1 APIC 0x2
[12955.747020] CPU1 is up
[12955.747038] smpboot: Booting Node 0 Processor 2 APIC 0x4
[12955.750123] CPU2 is up
[12955.750147] smpboot: Booting Node 0 Processor 3 APIC 0x6
[12955.753787] CPU3 is up
[12955.753808] smpboot: Booting Node 0 Processor 4 APIC 0x8
[12955.757092] CPU4 is up
[12955.757112] smpboot: Booting Node 0 Processor 5 APIC 0xa
[12955.760262] CPU5 is up
[12955.760295] smpboot: Booting Node 0 Processor 6 APIC 0xc
[12955.763945] CPU6 is up
[12955.763969] smpboot: Booting Node 0 Processor 7 APIC 0xe
[12955.767190] CPU7 is up
[12955.767212] smpboot: Booting Node 0 Processor 8 APIC 0x1
[12955.770965] Spectre V2 : Update user space SMT mitigation: STIBP always-=
on
[12955.770995] CPU8 is up
[12955.771014] smpboot: Booting Node 0 Processor 9 APIC 0x3
[12955.774292] CPU9 is up
[12955.774314] smpboot: Booting Node 0 Processor 10 APIC 0x5
[12955.778002] CPU10 is up
[12955.778025] smpboot: Booting Node 0 Processor 11 APIC 0x7
[12955.781355] CPU11 is up
[12955.781376] smpboot: Booting Node 0 Processor 12 APIC 0x9
[12955.785077] CPU12 is up
[12955.785106] smpboot: Booting Node 0 Processor 13 APIC 0xb
[12955.789075] CPU13 is up
[12955.789106] smpboot: Booting Node 0 Processor 14 APIC 0xd
[12955.792527] CPU14 is up
[12955.792550] smpboot: Booting Node 0 Processor 15 APIC 0xf
[12955.796288] CPU15 is up
[12955.797605] ACPI: PM: Waking up from system sleep state S3
[12955.800715] xhci_hcd 0000:02:00.0: xHC error in resume, USBSTS 0x401, Re=
init
[12955.800718] usb usb1: root hub lost power or was reset
[12955.800720] usb usb2: root hub lost power or was reset
[12955.801742] serial 00:04: activated
[12955.858626] nvme nvme0: D3 entry latency set to 8 seconds
[12955.865177] nvme nvme1: 8/0/0 default/read/poll queues
[12955.874829] nvme nvme0: 16/0/0 default/read/poll queues
[12956.110891] ata3: SATA link down (SStatus 0 SControl 300)
[12956.110924] ata1: SATA link down (SStatus 0 SControl 300)
[12956.110955] ata5: SATA link down (SStatus 0 SControl 330)
[12956.260598] usb 1-9: reset low-speed USB device number 7 using xhci_hcd
[12956.617639] usb 1-6: WARN: invalid context state for evaluate context co=
mmand.
[12956.790599] usb 1-6: reset full-speed USB device number 3 using xhci_hcd
[12956.841562] ata6: failed to resume link (SControl 0)
[12956.841577] ata6: SATA link down (SStatus 0 SControl 0)
[12957.058571] usb 1-1: WARN: invalid context state for evaluate context co=
mmand.
[12957.231590] usb 1-1: reset full-speed USB device number 2 using xhci_hcd
[12957.498554] usb 1-8: WARN: invalid context state for evaluate context co=
mmand.
[12957.671531] usb 1-8: reset full-speed USB device number 5 using xhci_hcd
[12958.111579] usb 1-7: reset high-speed USB device number 4 using xhci_hcd
[12958.576614] usb 1-7.3: WARN: invalid context state for evaluate context =
command.
[12958.648571] usb 1-7.3: reset full-speed USB device number 6 using xhci_h=
cd
[12958.876493] OOM killer enabled.
[12958.876496] Restarting tasks: Starting
[12958.879178] Bluetooth: hci0: CSR: Setting up dongle with HCI ver=3D6 rev=
=3D22bb
[12958.879183] Bluetooth: hci0: LMP ver=3D6 subver=3D22bb; manufacturer=3D10
[12958.879299] Restarting tasks: Done
[12958.879306] efivarfs: resyncing variable state
[12958.886795] efivarfs: finished resyncing variable state
[12958.886811] random: crng reseeded on system resumption
[12959.047801] Bluetooth: MGMT ver 1.23
[12959.427062] NVRM: _kgspIsHeartbeatTimedOut: Heartbeat timed out, current=
TimeMs 2367851435 heartbeat 0 heartbeatWithOffsetMs 0 diff 2367851435 timeo=
ut 5200
[12959.427065] NVRM: _kgspRpcRecvPoll: GSP RM heartbeat timed out
[12960.627839] PM: suspend exit
[12960.661209] Realtek Internal NBASE-T PHY r8169-0-700:00: attached PHY dr=
iver (mii_bus:phy_addr=3Dr8169-0-700:00, irq=3DMAC)
[12960.820346] r8169 0000:07:00.0 enp7s0: Link is Down
[12961.113196] ata2: link is slow to respond, please be patient (ready=3D0)
[12961.114200] ata4: link is slow to respond, please be patient (ready=3D0)
[12963.428372] r8169 0000:07:00.0 enp7s0: Link is Up - 1Gbps/Full - flow co=
ntrol rx/tx
[12965.816162] ata2: found unknown device (class 0)
[12965.816180] ata4: found unknown device (class 0)
[12965.969160] ata2: found unknown device (class 0)
[12965.969171] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[12965.970159] ata4: found unknown device (class 0)
[12965.970167] ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[12981.369196] ata2.00: qc timeout after 15000 msecs (cmd 0xec)
[12981.369207] ata2.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)
[12981.369210] ata2.00: revalidation failed (errno=3D-5)
[12981.369226] ata4.00: qc timeout after 15000 msecs (cmd 0xec)
[12981.369236] ata4.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)
[12981.369238] ata4.00: revalidation failed (errno=3D-5)
[12981.833047] ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[12981.833134] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[12981.869506] ata2.00: configured for UDMA/133
[12981.879537] ata4.00: configured for UDMA/133

> And please explain your problem as detailed as you can, including which
> drive/port (ataX.YY) that you are having a problem with.

There is a soft RAID on ata2.00 and ata4.00. When i recovery from suspend,
the ata port will be failed at revalidation and "some software"
will see it as a failure, then kick the disk out of the RAID. So I started
to reproduce it.  (Those two are enterprise-grade disk, starts up really sl=
owly)

And, This problem will only happened at recovery from suspend or when i put=
 the
disk into "Standby_Z" mode. I guess, the datasheet of this disk said the re=
covery
from standby costs, at typical, 9 seconds or at maximum, 23 seconds, so tha=
t may
caused by the spinup time too long for those two disks. I enlong the timeou=
t,
then this problem is being "relaxed", during 10 recoveries, only 2 times
the revalidation failed. Damien said a disk that properly implemented the A=
TA
specification should have response of ATA commands though they are spining =
up.
That is strange, you can see the revalidation on second time will immediate=
ly succeed,
and the total time (6s) is still short than 9 seconds. The difference betwe=
en the
failed recovery to succeed one is that ata won't report "found unkown devic=
e" like
[  332.991862] ata4: found unknown device (class 0)

I attached more disk as test (they are just regular customer-grade), they
did not go wrong. And at most strange, the three new attached disk also wil=
l relaxed
the problem without adjustment on timeout (like 50 pct time failed, 50 pct =
time succeed).

So, at least now, I have no idea about why it happened.

> Then that timeout value will be used for each retry:
> https://github.com/torvalds/linux/blob/v7.0/drivers/ata/libata-core.c#L16=
12-L1617

> I.e. if you specify an explicit probe timeout value, you will not
> automatically get a larger timeout timeout for each retry.

But as far as i seen, the qc timeout will frezze the port, then reset it.
I just don't want the port failed explicitly, or without a port reset.

Alan




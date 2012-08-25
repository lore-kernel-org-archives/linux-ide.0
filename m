From: Adko Branil <adkobranil@yahoo.com>
Subject: HDD problem, software bug, bios bug, or hardware ?
Date: Fri, 24 Aug 2012 17:54:08 -0700 (PDT)
Message-ID: <1345856048.38987.YahooMailNeo@web124702.mail.ne1.yahoo.com>
Reply-To: Adko Branil <adkobranil@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nm23-vm4.bullet.mail.ne1.yahoo.com ([98.138.91.183]:23244 "HELO
	nm23-vm4.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755164Ab2HYAyK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 24 Aug 2012 20:54:10 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

My system hangs from time to time, after few hours work(which differs f=
rom minutes to 8-9 hours), with kernel panic. Before that begins it wor=
ked fine for about 6 years - no software or hardware changes during thi=
s period.
I have some photos of the screen after panic, the first two are with th=
e old linux kernel 2.6.16.27:

http://picpaste.com/pics/img00005-73m0unO0.1345852235.jpg
http://picpaste.com/pics/P170812_12.01-MeZrs3zv.1345817375.jpg

-they can enlarge on click.


Then i installed slackware-current with their default kernel "huge.s" a=
nd the crashes continued:

http://picpaste.com/pics/P210812_15.34-3NSTEV8f.1345816730.jpg

then i swithced off the swap:

http://picpaste.com/pics/P230812_15.06-hB12169n.1345812390.jpg

after that i managed to save one message with netconsole (swap is off):

	1. [13330.042569] BUG: unable to handle kernel paging request at 00006=
0ff80001f1c
	2. [13330.043554] IP: [<ffffffff810b17e0>] no_action+0x10/0x10
	3. [13330.043554] PGD 0=20
	4. [13330.043554] Oops: 0002 [#1] SMP=20
	5. [13330.043554] CPU 1=20
	6. [13330.043554] Modules linked in: ipv6=20
lp netconsole snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq=20
snd_pcm_oss snd_mixer_oss fuse nouveau mxm_wmi wmi video ttm=20
drm_kms_helper drm amd64_agp processor thermal_sys k8temp agpgart hwmon=
=20
snd_via82xx snd_ac97_codec snd_mpu401_uart snd_rawmidi snd_seq_device=20
snd_pcm snd_page_alloc snd_timer snd soundcore ac97_bus ppdev parport_p=
c i2c_algo_bit gameport evdev shpchp button i2c_viapro i2c_core loop sk=
ge parport [last unloaded: lp]
	7. [13330.043554]=20
	8. [13330.043554] Pid: 0, comm: swapper/1 Not tainted 3.2.27 #2 To Be =
=46illed By O.E.M. To Be Filled By O.E.M./A8V Deluxe
	9. [13330.043554] RIP: 0010:[<ffffffff810b17e0>] =A0[<ffffffff810b17e0=
>] no_action+0x10/0x10
	10. [13330.043554] RSP: 0018:ffff88007fd03f10 =A0EFLAGS: 00010086
	11. [13330.043554] RAX: 000060ff80001f1c RBX: ffff88007aef2c00 RCX: 00=
000000fffffffa
	12. [13330.043554] RDX: 00000000000000d0 RSI: ffff88007ae93f80 RDI: ff=
ff88007aef2c00
	13. [13330.043554] RBP: ffff88007fd03f38 R08: ffff88007aef2c00 R09: ff=
ff88007cc00000
	14. [13330.043554] R10: 0000000000000000 R11: 0000000000000000 R12: ff=
ff88007aef2c8c
	15. [13330.043554] R13: 0000000000000011 R14: 0000000000000000 R15: 00=
00000000000000
	16. [13330.043554] FS: =A000007f674b3e6740(0000) GS:ffff88007fd00000(0=
000) knlGS:00000000f7369700
	17. [13330.043554] CS: =A00010 DS: 0000 ES: 0000 CR0: 000000008005003b
	18. [13330.043554] CR2: 000060ff80001f1c CR3: 000000006f115000 CR4: 00=
000000000006e0
	19. [13330.043554] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00=
00000000000000
	20. [13330.043554] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 00=
00000000000400
	21. [13330.043554] Process swapper/1 (pid: 0, threadinfo ffff88007bd18=
000, task ffff88007d0ec4c0)
	22. [13330.043554] Stack:
	23. [13330.043554] =A0ffffffff810b1a10 ffff88007fd03f58 ffff88007aef2c=
00 0000000000000051
	24. [13330.043554] =A00000000000000011 ffff88007fd03f58 ffffffff810b48=
79 ffff88007fd03f58
	25. [13330.043554] =A00000000000000011 ffff88007fd03f78 ffffffff81003d=
12 ffff88007fd03f78
	26. [13330.043554] Call Trace:
	27. [13330.043554] =A0<IRQ>=20
	28. [13330.043554] =A0[<ffffffff810b1a10>] ? handle_irq_event+0x40/0x7=
0
	29. [13330.043554] =A0[<ffffffff810b4879>] handle_fasteoi_irq+0x59/0x1=
00
	30. [13330.043554] =A0[<ffffffff81003d12>] handle_irq+0x22/0x40
	31. [13330.043554] =A0[<ffffffff81b3158a>] do_IRQ+0x5a/0xe0
	32. [13330.043554] =A0[<ffffffff81b2e82b>] common_interrupt+0x6b/0x6b
	33. [13330.043554] =A0<EOI>

=A0here is link to dmesg, before that last crash: http://pastebin.com/A=
f7bb34x

And at the end i noticed scary messages in the syslog:

[31770.094556] REISERFS warning (device sda1): clm-6006 reiserfs_dirty_=
inode: writing inode 347717 on readonly FS
[31770.472848] REISERFS warning (device sda1): clm-6006 reiserfs_dirty_=
inode: writing inode 347740 on readonly FS
[31790.796117] REISERFS warning (device sda1): clm-6006 reiserfs_dirty_=
inode: writing inode 426162 on readonly FS


after which i have done reiserfsck immediately - no corruption were fou=
nd.
Never seen such messages before, i have syslogs for 17 days before that=
=A0 - no messages like this.

I have done some tests with smartmontools before - when it was the old =
linux (2.6.16.27) - the result of "smartctl -s on -a /dev/sda" is:

smartctl 5.43 2012-06-30 r3573 [x86_64-linux-3.5.2] (local build)
Copyright (C) 2002-12 by Bruce Allen, http://smartmontools.sourceforge.=
net

=3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
Model Family:=A0=A0=A0=A0 Seagate Barracuda 7200.7 and 7200.7 Plus
Device Model:=A0=A0=A0=A0 ST3200822AS
Serial Number:=A0=A0=A0 4LJ221BB
=46irmware Version: 3.01
User Capacity:=A0=A0=A0 200,049,647,616 bytes [200 GB]
Sector Size:=A0=A0=A0=A0=A0 512 bytes logical/physical
Device is:=A0=A0=A0=A0=A0=A0=A0 In smartctl database [for details use: =
-P show]
ATA Version is:=A0=A0 6
ATA Standard is:=A0 ATA/ATAPI-6 T13 1410D revision 2
Local Time is:=A0=A0=A0 Sat Aug 25 03:09:01 2012 MSK
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=3D=3D=3D START OF ENABLE/DISABLE COMMANDS SECTION =3D=3D=3D
SMART Enabled.

=3D=3D=3D START OF READ SMART DATA SECTION =3D=3D=3D
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:=A0 (0x82) Offline data collection activ=
ity
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 was completed without err=
or.
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Auto Offline Data Collect=
ion: Enabled.
Self-test execution status:=A0=A0=A0=A0=A0 (=A0=A0 0) The previous self=
-test routine completed
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 without error or no self-=
test has ever=20
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 been run.
Total time to complete Offline=20
data collection:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (=A0 430)=
 seconds.
Offline data collection
capabilities:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
(0x5b) SMART execute Offline immediate.
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Auto Offline data collect=
ion on/off support.
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Suspend Offline collectio=
n upon new
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 command.
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Offline surface scan supp=
orted.
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Self-test supported.
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No Conveyance Self-test s=
upported.
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Selective Self-test suppo=
rted.
SMART capabilities:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (0x0003) Saves SMA=
RT data before entering
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 power-saving mode.
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Supports SMART auto save =
timer.
Error logging capability:=A0=A0=A0=A0=A0=A0=A0 (0x01) Error logging sup=
ported.
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No General Purpose Loggin=
g support.
Short self-test routine=20
recommended polling time:=A0=A0=A0=A0=A0=A0=A0 (=A0=A0 1) minutes.
Extended self-test routine
recommended polling time:=A0=A0=A0=A0=A0=A0=A0 ( 111) minutes.

SMART Attributes Data Structure revision number: 10
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME=A0=A0=A0=A0=A0=A0=A0=A0=A0 FLAG=A0=A0=A0=A0 VALUE WO=
RST THRESH TYPE=A0=A0=A0=A0=A0 UPDATED=A0 WHEN_FAILED RAW_VALUE
=A0 1 Raw_Read_Error_Rate=A0=A0=A0=A0 0x000f=A0=A0 050=A0=A0 046=A0=A0 =
006=A0=A0=A0 Pre-fail=A0 Always=A0=A0=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0 1=
79699255
=A0 3 Spin_Up_Time=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x0003=A0=A0 097=A0=
=A0 096=A0=A0 000=A0=A0=A0 Pre-fail=A0 Always=A0=A0=A0=A0=A0=A0 -=A0=A0=
=A0=A0=A0=A0 0
=A0 4 Start_Stop_Count=A0=A0=A0=A0=A0=A0=A0 0x0032=A0=A0 100=A0=A0 100=A0=
=A0 020=A0=A0=A0 Old_age=A0=A0 Always=A0=A0=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=
=A0 123
=A0 5 Reallocated_Sector_Ct=A0=A0 0x0033=A0=A0 100=A0=A0 100=A0=A0 036=A0=
=A0=A0 Pre-fail=A0 Always=A0=A0=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0 6
=A0 7 Seek_Error_Rate=A0=A0=A0=A0=A0=A0=A0=A0 0x000f=A0=A0 078=A0=A0 06=
0=A0=A0 030=A0=A0=A0 Pre-fail=A0 Always=A0=A0=A0=A0=A0=A0 -=A0=A0=A0=A0=
=A0=A0 81170784
=A0 9 Power_On_Hours=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x0032=A0=A0 039=A0=A0 =
039=A0=A0 000=A0=A0=A0 Old_age=A0=A0 Always=A0=A0=A0=A0=A0=A0 -=A0=A0=A0=
=A0=A0=A0 53553
=A010 Spin_Retry_Count=A0=A0=A0=A0=A0=A0=A0 0x0013=A0=A0 100=A0=A0 100=A0=
=A0 097=A0=A0=A0 Pre-fail=A0 Always=A0=A0=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=
 0
=A012 Power_Cycle_Count=A0=A0=A0=A0=A0=A0 0x0032=A0=A0 100=A0=A0 100=A0=
=A0 020=A0=A0=A0 Old_age=A0=A0 Always=A0=A0=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=
=A0 142
194 Temperature_Celsius=A0=A0=A0=A0 0x0022=A0=A0 037=A0=A0 054=A0=A0 00=
0=A0=A0=A0 Old_age=A0=A0 Always=A0=A0=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0 3=
7
195 Hardware_ECC_Recovered=A0 0x001a=A0=A0 050=A0=A0 046=A0=A0 000=A0=A0=
=A0 Old_age=A0=A0 Always=A0=A0=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0 17969925=
5
197 Current_Pending_Sector=A0 0x0012=A0=A0 100=A0=A0 100=A0=A0 000=A0=A0=
=A0 Old_age=A0=A0 Always=A0=A0=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0 0
198 Offline_Uncorrectable=A0=A0 0x0010=A0=A0 100=A0=A0 100=A0=A0 000=A0=
=A0=A0 Old_age=A0=A0 Offline=A0=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0 0
199 UDMA_CRC_Error_Count=A0=A0=A0 0x003e=A0=A0 200=A0=A0 198=A0=A0 000=A0=
=A0=A0 Old_age=A0=A0 Always=A0=A0=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0 2
200 Multi_Zone_Error_Rate=A0=A0 0x0000=A0=A0 100=A0=A0 253=A0=A0 000=A0=
=A0=A0 Old_age=A0=A0 Offline=A0=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0 0
202 Data_Address_Mark_Errs=A0 0x0032=A0=A0 100=A0=A0 253=A0=A0 000=A0=A0=
=A0 Old_age=A0=A0 Always=A0=A0=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0 0

SMART Error Log Version: 1
ATA Error Count: 2
=A0=A0=A0=A0=A0=A0=A0 CR =3D Command Register [HEX]
=A0=A0=A0=A0=A0=A0=A0 FR =3D Features Register [HEX]
=A0=A0=A0=A0=A0=A0=A0 SC =3D Sector Count Register [HEX]
=A0=A0=A0=A0=A0=A0=A0 SN =3D Sector Number Register [HEX]
=A0=A0=A0=A0=A0=A0=A0 CL =3D Cylinder Low Register [HEX]
=A0=A0=A0=A0=A0=A0=A0 CH =3D Cylinder High Register [HEX]
=A0=A0=A0=A0=A0=A0=A0 DH =3D Device/Head Register [HEX]
=A0=A0=A0=A0=A0=A0=A0 DC =3D Device Command Register [HEX]
=A0=A0=A0=A0=A0=A0=A0 ER =3D Error register [HEX]
=A0=A0=A0=A0=A0=A0=A0 ST =3D Status register [HEX]
Powered_Up_Time is measured from power on, and printed as
DDd+hh:mm:SS.sss where DD=3Ddays, hh=3Dhours, mm=3Dminutes,
SS=3Dsec, and sss=3Dmillisec. It "wraps" after 49.710 days.

Error 2 occurred at disk power-on lifetime: 13784 hours (574 days + 8 h=
ours)
=A0 When the command that caused the error occurred, the device was act=
ive or idle.

=A0 After command completion occurred, registers were:
=A0 ER ST SC SN CL CH DH
=A0 -- -- -- -- -- -- --
=A0 84 51 00 7a 7d 1d e0=A0 Error: ICRC, ABRT at LBA =3D 0x001d7d7a =3D=
 1932666

=A0 Commands leading to the command that caused the error were:
=A0 CR FR SC SN CL CH DH DC=A0=A0 Powered_Up_Time=A0 Command/Feature_Na=
me
=A0 -- -- -- -- -- -- -- --=A0 ----------------=A0 --------------------
=A0 25 00 00 7b 7c 1d e0 00=A0=A0=A0=A0=A0 22:14:23.595=A0 READ DMA EXT
=A0 25 00 00 7b 7b 1d e0 00=A0=A0=A0=A0=A0 22:14:23.593=A0 READ DMA EXT
=A0 25 00 00 7b 7a 1d e0 00=A0=A0=A0=A0=A0 22:14:23.576=A0 READ DMA EXT
=A0 25 00 00 7b 79 1d e0 00=A0=A0=A0=A0=A0 22:14:23.567=A0 READ DMA EXT
=A0 25 00 00 7b 78 1d e0 00=A0=A0=A0=A0=A0 22:14:23.566=A0 READ DMA EXT

Error 1 occurred at disk power-on lifetime: 13784 hours (574 days + 8 h=
ours)
=A0 When the command that caused the error occurred, the device was act=
ive or idle.

=A0 After command completion occurred, registers were:
=A0 ER ST SC SN CL CH DH
=A0 -- -- -- -- -- -- --
=A0 84 51 00 fa 0e 01 e0=A0 Error: ICRC, ABRT at LBA =3D 0x00010efa =3D=
 69370

=A0 Commands leading to the command that caused the error were:
=A0 CR FR SC SN CL CH DH DC=A0=A0 Powered_Up_Time=A0 Command/Feature_Na=
me
=A0 -- -- -- -- -- -- -- --=A0 ----------------=A0 --------------------
=A0 25 00 00 fb 0d 01 e0 00=A0=A0=A0=A0=A0 22:13:03.489=A0 READ DMA EXT
=A0 25 00 00 fb 0c 01 e0 00=A0=A0=A0=A0=A0 22:13:03.487=A0 READ DMA EXT
=A0 25 00 00 fb 0b 01 e0 00=A0=A0=A0=A0=A0 22:13:03.701=A0 READ DMA EXT
=A0 25 00 00 fb 09 01 e0 00=A0=A0=A0=A0=A0 22:13:03.682=A0 READ DMA EXT
=A0 25 00 00 fb 07 01 e0 00=A0=A0=A0=A0=A0 22:13:03.681=A0 READ DMA EXT

SMART Self-test log structure revision number 1
Num=A0 Test_Description=A0=A0=A0 Status=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 Remaining=A0 LifeTime(hours)=A0 LBA_of_first_error
# 1=A0 Extended offline=A0=A0=A0 Completed without error=A0=A0=A0=A0=A0=
=A0 00%=A0=A0=A0=A0 53153=A0=A0=A0=A0=A0=A0=A0=A0 -
# 2=A0 Short offline=A0=A0=A0=A0=A0=A0 Completed without error=A0=A0=A0=
=A0=A0=A0 00%=A0=A0=A0=A0 53152=A0=A0=A0=A0=A0=A0=A0=A0 -
# 3=A0 Short offline=A0=A0=A0=A0=A0=A0 Completed without error=A0=A0=A0=
=A0=A0=A0 00%=A0=A0=A0=A0 53152=A0=A0=A0=A0=A0=A0=A0=A0 -
# 4=A0 Short offline=A0=A0=A0=A0=A0=A0 Completed without error=A0=A0=A0=
=A0=A0=A0 00%=A0=A0=A0=A0 53152=A0=A0=A0=A0=A0=A0=A0=A0 -
# 5=A0 Short offline=A0=A0=A0=A0=A0=A0 Completed without error=A0=A0=A0=
=A0=A0=A0 00%=A0=A0=A0=A0 53152=A0=A0=A0=A0=A0=A0=A0=A0 -
# 6=A0 Short offline=A0=A0=A0=A0=A0=A0 Completed without error=A0=A0=A0=
=A0=A0=A0 00%=A0=A0=A0=A0 53148=A0=A0=A0=A0=A0=A0=A0=A0 -
# 7=A0 Short offline=A0=A0=A0=A0=A0=A0 Completed without error=A0=A0=A0=
=A0=A0=A0 00%=A0=A0=A0=A0 53148=A0=A0=A0=A0=A0=A0=A0=A0 -
# 8=A0 Short offline=A0=A0=A0=A0=A0=A0 Completed without error=A0=A0=A0=
=A0=A0=A0 00%=A0=A0=A0=A0 53148=A0=A0=A0=A0=A0=A0=A0=A0 -
# 9=A0 Extended offline=A0=A0=A0 Aborted by host=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 80%=A0=A0=A0=A0 53148=A0=A0=A0=A0=A0=A0=A0=A0 -
#10=A0 Short offline=A0=A0=A0=A0=A0=A0 Completed without error=A0=A0=A0=
=A0=A0=A0 00%=A0=A0=A0=A0 53147=A0=A0=A0=A0=A0=A0=A0=A0 -
#11=A0 Short offline=A0=A0=A0=A0=A0=A0 Completed without error=A0=A0=A0=
=A0=A0=A0 00%=A0=A0=A0=A0 53147=A0=A0=A0=A0=A0=A0=A0=A0 -

SMART Selective self-test log data structure revision number 1
=A0SPAN=A0 MIN_LBA=A0 MAX_LBA=A0 CURRENT_TEST_STATUS
=A0=A0=A0 1=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0 0=A0 Not_testin=
g
=A0=A0=A0 2=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0 0=A0 Not_testin=
g
=A0=A0=A0 3=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0 0=A0 Not_testin=
g
=A0=A0=A0 4=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0 0=A0 Not_testin=
g
=A0=A0=A0 5=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0 0=A0 Not_testin=
g
Selective self-test flags (0x0):
=A0 After scanning selected spans, do NOT read-scan remainder of disk.
If Selective self-test is pending on power-up, resume after 0 minute de=
lay.


And soon after that (you can see the time of the messages)" i just succ=
eed to to capture one whole panic message(i am hoping it is):

[32874.215014] BUG: unable to handle kernel NULL pointer dereference at=
 0000000000000086
[32874.215192] IP: [<ffffffff819f9440>] start_show+0x30/0x30
[32874.215192] PGD 7afe0067 PUD 7497e067 PMD 0=20
[32874.215192] Oops: 0002 [#1] SMP=20
[32874.215192] CPU 1=20
[32874.215192] Modules linked in: netconsole ipt_REJECT xt_tcpudp iptab=
le_raw iptable_mangle iptable_nat nf_nat nf_conntrack_ipv4 nf_defrag_ip=
v4 nf_conntrack iptable_filter ip_tables x_tables ipv6 snd_seq_dummy sn=
d_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss fuse nou=
veau mxm_wmi wmi video ttm drm_kms_helper snd_via82xx snd_ac97_codec sn=
d_mpu401_uart snd_rawmidi snd_seq_device snd_pcm snd_page_alloc drm snd=
_timer amd64_agp processor i2c_algo_bit snd shpchp k8temp agpgart therm=
al_sys i2c_viapro hwmon i2c_core skge soundcore ac97_bus gameport evdev=
 ppdev button parport_pc parport loop [last unloaded: lp]
[32874.215192]=20
[32874.215192] Pid: 0, comm: swapper/1 Not tainted 3.2.27 #2 To Be Fill=
ed By O.E.M. To Be Filled By O.E.M./A8V Deluxe
[32874.215192] RIP: 0010:[<ffffffff819f9440>]=A0 [<ffffffff819f9440>] s=
tart_show+0x30/0x30
[32874.215192] RSP: 0018:ffff88007fd03eb0=A0 EFLAGS: 00010006
[32874.215192] RAX: 0000000000000086 RBX: ffffffff820c2fc0 RCX: 0000000=
000000001
[32874.215192] RDX: 00001de61fe84bdb RSI: 0000000000000000 RDI: fffffff=
f820c2fc0
[32874.215192] RBP: ffff88007fd03ed8 R08: 0000000000000000 R09: 0000000=
000000001
[32874.215192] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000=
000008069
[32874.215192] R13: 00000000484f99af R14: 0000000000ab2476 R15: 0000000=
000000000
[32874.215192] FS:=A0 00007f61bddf4740(0000) GS:ffff88007fd00000(0000) =
knlGS:00000000f75fc6c0
[32874.215192] CS:=A0 0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[32874.215192] CR2: 0000000000000086 CR3: 00000000746e8000 CR4: 0000000=
0000006e0
[32874.215192] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
[32874.215192] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000=
000000400
[32874.215192] Process swapper/1 (pid: 0, threadinfo ffff88007bd18000, =
task ffff88007d0ec4c0)
[32874.215192] Stack:
[32874.215192]=A0 ffffffff8107df04 ffff88007fd12680 0000000000000001 00=
0000000000d300
[32874.215192]=A0 0000000000000000 ffff88007fd03ef8 ffffffff8107ab80 ff=
ff88007fd0d300
[32874.215192]=A0 0000000000000001 ffff88007fd03f08 ffffffff8107abe9 ff=
ff88007fd03f28
[32874.215192] Call Trace:
[32874.215192]=A0 <IRQ>=20
[32874.215192]=A0 [<ffffffff8107df04>] ? ktime_get+0x64/0xe0
[32874.215192]=A0 [<ffffffff8107ab80>] sched_clock_tick+0x40/0x90
[32874.215192]=A0 [<ffffffff8107abe9>] sched_clock_idle_wakeup_event+0x=
19/0x20
[32874.215192]=A0 [<ffffffff8108538e>] tick_nohz_stop_idle+0x3e/0x50
[32874.215192]=A0 [<ffffffff81085b77>] tick_check_idle+0xb7/0xd0
[32874.215192]=A0 [<ffffffff8105a749>] irq_enter+0x69/0x70
[32874.215192]=A0 [<ffffffff81b31653>] smp_apic_timer_interrupt+0x43/0x=
99
[32874.215192]=A0 [<ffffffff81b2f9cb>] apic_timer_interrupt+0x6b/0x70
[32874.215192]=A0 <EOI>=20
[32874.215192]=A0 [<ffffffff8107aa58>] ? sched_clock_cpu+0xa8/0x120
[32874.215192]=A0 [<ffffffff8100a89a>] ? default_idle+0x5a/0x180
[32874.215192]=A0 [<ffffffff810009b6>] cpu_idle+0xf6/0x110
[32874.215192]=A0 [<ffffffff81b146ea>] start_secondary+0x1cf/0x1d6
[32874.215192] Code: 66 66 66 90 48 8b 0f 48 c7 c2 0d 46 dc 81 48 89 f0=
 be 00 10 00 00 48 89 c7 31 c0 e8 5b 71 b9 ff 5d 48 98 c3 0f 1f 80 00 0=
0 00 00 <55> 48 89 e5 66 66 66 66 90 8b 15 39 31 6f 00 ed 25 ff ff ff 0=
0=20
[32874.215192] RIP=A0 [<ffffffff819f9440>] start_show+0x30/0x30
[32874.215192]=A0 RSP <ffff88007fd03eb0>
[32874.215192] CR2: 0000000000000086
[32874.215192] [drm] nouveau 0000:01:00.0: Setting dpms mode 0 on vga e=
ncoder (output 0)
[32874.215192] ---[ end trace 90aad159d8ed7c1e ]---
[32874.215192] Kernel panic - not syncing: Fatal exception in interrupt
[32874.215192] Pid: 0, comm: swapper/1 Tainted: G=A0=A0=A0=A0=A0 D=A0=A0=
=A0=A0=A0 3.2.27 #2
[32874.215192] Call Trace:
[32874.215192]=A0 <IRQ>=A0 [<ffffffff81b1aeea>] panic+0x91/0x189
[32874.215192]=A0 [<ffffffff81005491>] oops_end+0x91/0xa0
[32874.215192]=A0 [<ffffffff81b1a85f>] no_context+0x1fa/0x225
[32874.215192]=A0 [<ffffffff81b1aa3b>] __bad_area_nosemaphore+0x1b1/0x1=
d0
[32874.215192]=A0 [<ffffffff81b1aa6d>] bad_area_nosemaphore+0x13/0x15
[32874.215192]=A0 [<ffffffff81028794>] do_page_fault+0x2b4/0x480
[32874.215192]=A0 [<ffffffff8104aa6c>] ? load_balance+0xac/0x780
[32874.215192]=A0 [<ffffffff81a1b1e0>] ? skb_release_head_state+0x60/0x=
100
[32874.215192]=A0 [<ffffffff81a1affe>] ? __kfree_skb+0x1e/0xa0
[32874.215192]=A0 [<ffffffff81a1b0b1>] ? consume_skb+0x31/0x70
[32874.215192]=A0 [<ffffffff81b2ea2f>] page_fault+0x1f/0x30
[32874.215192]=A0 [<ffffffff819f9440>] ? start_show+0x30/0x30
[32874.215192]=A0 [<ffffffff8107df04>] ? ktime_get+0x64/0xe0
[32874.215192]=A0 [<ffffffff8107ab80>] sched_clock_tick+0x40/0x90
[32874.215192]=A0 [<ffffffff8107abe9>] sched_clock_idle_wakeup_event+0x=
19/0x20
[32874.215192]=A0 [<ffffffff8108538e>] tick_nohz_stop_idle+0x3e/0x50
[32874.215192]=A0 [<ffffffff81085b77>] tick_check_idle+0xb7/0xd0
[32874.215192]=A0 [<ffffffff8105a749>] irq_enter+0x69/0x70
[32874.215192]=A0 [<ffffffff81b31653>] smp_apic_timer_interrupt+0x43/0x=
99
[32874.215192]=A0 [<ffffffff81b2f9cb>] apic_timer_interrupt+0x6b/0x70
[32874.215192]=A0 <EOI>=A0 [<ffffffff8107aa58>] ? sched_clock_cpu+0xa8/=
0x120
[32874.215192]=A0 [<ffffffff8100a89a>] ? default_idle+0x5a/0x180
[32874.215192]=A0 [<ffffffff810009b6>] cpu_idle+0xf6/0x110
[32874.215192]=A0 [<ffffffff81b146ea>] start_secondary+0x1cf/0x1d6
[32874.215192] panic occurred, switching back to text console.

swap is off again.

After that i ran the machine with the newest kernel - 3.5.2, and if it =
happens again i will try "nosmp" option.Any ideas of what should be the=
 reason, or how to catch it, will be welcome.

Is that the right place to ask, or should i send it to kernel@vger.kern=
el.org, or somewhere else ?
Thanks in advance !

Adko.

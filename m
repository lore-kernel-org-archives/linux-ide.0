From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 15815] pata_legacy causes machine check
Date: Wed, 21 Apr 2010 01:06:54 GMT
Message-ID: <201004210106.o3L16s0Z032521@demeter.kernel.org>
References: <bug-15815-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:55665 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754127Ab0DUBGz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Apr 2010 21:06:55 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o3L16sED032522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Wed, 21 Apr 2010 01:06:55 GMT
In-Reply-To: <bug-15815-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=15815





--- Comment #1 from Robert Hancock <hancockrwd@gmail.com>  2010-04-21 01:06:49 ---
On 04/20/2010 04:47 AM, bugzilla-daemon@bugzilla.kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=15815
>
>             Summary: pata_legacy causes machine check
>             Product: IO/Storage
>             Version: 2.5
>      Kernel Version: 2.6.34-rc4
>            Platform: All
>          OS/Version: Linux
>                Tree: Mainline
>              Status: NEW
>            Severity: normal
>            Priority: P1
>           Component: IDE
>          AssignedTo: io_ide@kernel-bugs.osdl.org
>          ReportedBy: joerg@alea.gnuu.de
>          Regression: No
>
>
> Hi,
>
> upon load of the module pata_legacy, the kernel prints out these
> messages:
>
> [  292.354954] Machine check in kernel mode.
> [  292.362298] Caused by (from SRR1=141030): Transfer error ack signal
> [  292.369603] Machine check in kernel mode.
> [  292.376759] Caused by (from SRR1=141030): Transfer error ack signal
> [  292.384021] Machine check in kernel mode.
> [  292.391157] Caused by (from SRR1=141030): Transfer error ack signal
> [  292.398301] Machine check in kernel mode.
> [  292.405328] Caused by (from SRR1=141030): Transfer error ack signal
> [  292.412479] Machine check in kernel mode.
> [  292.419481] Caused by (from SRR1=141030): Transfer error ack signal
> [  292.426554] Machine check in kernel mode.
> [  292.433432] Caused by (from SRR1=141030): Transfer error ack signal
> [  292.440304] Machine check in kernel mode.
> [  292.446972] Caused by (from SRR1=141030): Transfer error ack signal
> [  292.453776] Machine check in kernel mode.
> [  292.460357] Caused by (from SRR1=141030): Transfer error ack signal
> [  292.466907] Machine check in kernel mode.
> [  292.473329] Caused by (from SRR1=141030): Transfer error ack signal
> [  292.479881] Machine check in kernel mode.
> [  292.486311] Caused by (from SRR1=141030): Transfer error ack signal
> [  292.492893] Machine check in kernel mode.
> [  292.499426] Caused by (from SRR1=141030): Transfer error ack signal
> [  292.506763] Machine check in kernel mode.
> [  292.513518] Caused by (from SRR1=141030): Transfer error ack signal
> [  292.520355] Oops: Machine check, sig: 7 [#1]
> [  292.527133] PowerMac
> [  292.533814] last sysfs file: /sys/module/libata/initstate
> [  292.540592] Modules linked in: pata_legacy(+) ext2 sd_mod firewire_ohci
> libata firewire_core crc_itu_t [last unloaded: pata_macio]
> [  292.554912] NIP: c001610c LR: ea0eae88 CTR: c0016104
> [  292.562118] REGS: e6dc3d60 TRAP: 0200   Not tainted  (2.6.34-rc4-test-2)
> [  292.569473] MSR: 00141030<ME,IR,DR>   CR: 24022488  XER: 20000000
> [  292.577030] TASK = e6cc6ed0[525] 'modprobe' THREAD: e6dc2000
> [  292.577219] GPR00: ea0eb4ec e6dc3e10 e6cc6ed0 000000ac fce793f6 e6d78000
> e6c8ac14 00000001
> [  292.585036] GPR08: 00000000 ea4aa9c4 ea4aaaa8 c0016104 84022488 1002582c
> ea4aa9c4 00810001
> [  292.592931] GPR16: 00810001 c049785c 00000001 000003f6 00000001 ea4aa6ae
> ea4aa810 00000000
> [  292.600904] GPR24: 000001f0 ea4aa810 e6d78000 e6c8ac14 00000000 00000000
> 00000001 e6d78000
> [  292.616742] NIP [c001610c] ioread8+0x8/0x18
> [  292.624785] LR [ea0eae88] ata_sff_check_status+0x14/0x28 [libata]
> [  292.632830] Call Trace:
> [  292.640880] [e6dc3e10] [ea4aa6ae] legacy_base_port_ops+0x1ea/0xfffff754
> [pata_legacy] (unreliable)
> [  292.649324] [e6dc3e20] [ea0eb4ec] ata_sff_freeze+0x4c/0x74 [libata]
> [  292.657787] [e6dc3e30] [ea0e575c] __ata_port_freeze+0x3c/0x5c [libata]
> [  292.666279] [e6dc3e40] [ea0e57ac] ata_eh_freeze_port+0x30/0x58 [libata]
> [  292.674799] [e6dc3e50] [ea0db1e0] ata_host_start+0x26c/0x300 [libata]
> [  292.683299] [e6dc3e70] [ea0db2b0] ata_host_activate+0x3c/0x144 [libata]
> [  292.691773] [e6dc3e90] [ea4afdb0] legacy_init+0xdb0/0x1008 [pata_legacy]
> [  292.700254] [e6dc3f00] [c0003eec] do_one_initcall+0x70/0x20c
> [  292.708741] [e6dc3f20] [c0062c0c] sys_init_module+0xf4/0x248
> [  292.717165] [e6dc3f40] [c0012e2c] ret_from_syscall+0x0/0x38
> [  292.725520] --- Exception: c01 at 0xff5e0c4
> [  292.725523]     LR = 0x100057b0
> [  292.741928] Instruction dump:
> [  292.749996] 7fe3fb78 83410018 7c0803a6 8361001c 83810020 83a10024 83c10028
> 83e1002c
> [  292.758398] 38210030 4e800020 7c0004ac 88630000<0c030000>  4c00012c 5463063e
> 4e800020
> [  292.767014] ---[ end trace 529ce4fa7f676244 ]---
>
> % cat /proc/cpuinfo
> processor    : 0
> cpu        : 7455, altivec supported
> clock        : 606.000000MHz
> revision    : 3.3 (pvr 8001 0303)
> bogomips    : 36.86
> timebase    : 18432000
> platform    : PowerMac
> model        : PowerBook6,3
> machine        : PowerBook6,3
> motherboard    : PowerBook6,3 MacRISC3 Power Macintosh
> detected as    : 287 (iBook G4)
> pmac flags    : 0000001b
> L2 cache    : 256K unified
> pmac-generation    : NewWorld
> Memory        : 640 MB
>
> % lspci
> 0000:00:0b.0 Host bridge: Apple Computer Inc. UniNorth 2 AGP
> 0000:00:10.0 VGA compatible controller: ATI Technologies Inc M9+ 5C63 [Radeon
> Mobility 9200 (AGP)] (rev 01)
> 0001:10:0b.0 Host bridge: Apple Computer Inc. UniNorth 2 PCI
> 0001:10:12.0 Network controller: Broadcom Corporation BCM4306 802.11b/g
> Wireless LAN Controller (rev 03)
> 0001:10:17.0 Class ff00: Apple Computer Inc. KeyLargo/Intrepid Mac I/O
> 0001:10:18.0 USB Controller: Apple Computer Inc. KeyLargo/Intrepid USB
> 0001:10:19.0 USB Controller: Apple Computer Inc. KeyLargo/Intrepid USB
> 0001:10:1a.0 USB Controller: Apple Computer Inc. KeyLargo/Intrepid USB
> 0001:10:1b.0 USB Controller: NEC Corporation USB (rev 43)
> 0001:10:1b.1 USB Controller: NEC Corporation USB (rev 43)
> 0001:10:1b.2 USB Controller: NEC Corporation USB 2.0 (rev 04)
> 0002:20:0b.0 Host bridge: Apple Computer Inc. UniNorth 2 Internal PCI
> 0002:20:0d.0 Class ff00: Apple Computer Inc. UniNorth/Intrepid ATA/100
> 0002:20:0e.0 FireWire (IEEE 1394): Apple Computer Inc. UniNorth 2 FireWire (rev
> 81)
> 0002:20:0f.0 Ethernet controller: Apple Computer Inc. UniNorth 2 GMAC (Sun GEM)
> (rev 80)

Hmm. This driver basically bangs on some legacy IDE IO ports and tries 
to see if there's anything there. It seems like this machine doesn't 
like that very much.

Does it really make sense for this driver to be enabled for non-x86?

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.

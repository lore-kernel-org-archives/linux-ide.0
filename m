From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11635] New: strange message in dmesg for IDE HDD: cannot use LBA48 DMA - PIO mode will be used for accessing sectors > 268435456
Date: Wed, 24 Sep 2008 02:20:28 -0700 (PDT)
Message-ID: <bug-11635-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53887 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751538AbYIXJVA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Sep 2008 05:21:00 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8O9KTmL029058
	for <linux-ide@vger.kernel.org>; Wed, 24 Sep 2008 02:20:30 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11635

           Summary: strange message in dmesg for IDE HDD: cannot use LBA48
                    DMA - PIO mode will be used for accessing sectors >
                    268435456
           Product: IO/Storage
           Version: 2.5
     KernelVersion: 2.6.26.1
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: enrique_pinos@yahoo.es


Latest working kernel version: unknown
Earliest failing kernel version: detected on kernel-2.6.25
Distribution: gentoo
Hardware Environment: Asus A7A266 motherboard with BIOS upgraded to latest
release (no beta version of upgrade) lspci output:
00:00.0 Host bridge: ALi Corporation M1647 Northbridge [MAGiK 1 / MobileMAGiK
1] (rev 04)
00:01.0 PCI bridge: ALi Corporation PCI to AGP Controller
00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
00:04.0 IDE interface: ALi Corporation M5229 IDE (rev c4)
00:05.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
00:06.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
00:07.0 ISA bridge: ALi Corporation M1533/M1535 PCI to ISA Bridge [Aladdin
IV/V/V+]
00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
00:0c.0 Serial controller: Rockwell International HCF 56k Data/Fax Modem (rev
01)
00:11.0 Bridge: ALi Corporation M7101 Power Management Controller [PMU]
01:00.0 VGA compatible controller: nVidia Corporation NV4 [RIVA TNT] (rev 04)

Software Environment: Gentoo Linux.
Problem Description: Hdd is slow and dmesg show a strange message

Steps to reproduce:compile kernel and boot

Output of script/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux AServer 2.6.26.1 #1 Wed Sep 24 00:18:06 CEST 2008 i686 AMD Athlon(TM)
XP1600+ AuthenticAMD GNU/Linux

Gnu C                  4.1.2
Gnu make               3.81
binutils               2.18
util-linux             2.13.1.1
mount                  2.13.1.1
module-init-tools      3.4
e2fsprogs              1.40.9
reiserfsprogs          3.6.19
Linux C Library        2.6.1
Dynamic linker (ldd)   2.6.1
Procps                 3.2.7
Net-tools              1.60
Kbd                    1.13
Sh-utils               6.9
udev                   124
Modules Loaded         ipt_REJECT ipt_LOG ipt_addrtype xt_pkttype xt_multiport
xt_MARK xt_mac xt_iprange xt_tcpudp xt_state nf_conntrack_ipv4 nf_conntrack
iptable_mangle nfnetlink iptable_filter ip_tables x_tables ohci_hcd usbcore
i2c_ali1535

dmesg output:
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: cannot use LBA48 DMA - PIO mode will be used for accessing sectors >
268435456
hda: 488397168 sectors (250059 MB) w/8192KiB Cache, CHS=30401/255/63
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4
hdc: max request size: 128KiB
hdc: cannot use LBA48 DMA - PIO mode will be used for accessing sectors >
268435456
hdc: 488397168 sectors (250059 MB) w/8192KiB Cache, CHS=30401/255/63

hdparm output:
hdparm -Tt /dev/hdc output:
/dev/hdc:
 Timing cached reads:   388 MB in  2.01 seconds = 193.07 MB/sec
 Timing buffered disk reads:  142 MB in  3.03 seconds =  46.89 MB/sec
(I want to get something above 500MB/sec)

May it help (googled)
i found that related info:
https://bugs.launchpad.net/ubuntu/+source/linux-source-2.6.20/+bug/119730
http://osdir.com/ml/ide/2005-03/msg00064.html


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.

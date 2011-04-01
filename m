From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 32472] New: Mips ar71xx can't allocate I/O resource for
 mini-pci IDE storage.
Date: Fri, 1 Apr 2011 20:44:59 GMT
Message-ID: <bug-32472-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter1.kernel.org ([140.211.167.39]:33874 "EHLO
	demeter1.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754298Ab1DAUpA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Apr 2011 16:45:00 -0400
Received: from demeter1.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter1.kernel.org (8.14.4/8.14.3) with ESMTP id p31Kj0Ss012220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Fri, 1 Apr 2011 20:45:00 GMT
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=32472

           Summary: Mips ar71xx can't allocate I/O resource for mini-pci
                    IDE storage.
           Product: IO/Storage
           Version: 2.5
    Kernel Version: Linux OpenWrt 2.6.32.25
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: ciusss@gmail.com
        Regression: No


Hi, 
I have system composed by: router station pro ( architecture mips cpu ar7161 )
with openwrt backfire 10.03-rc4, i have installed only Axiomtek AX8931A Mini
PCI IDE Control Module in free slot.

>From dmesg command :
{{{
root@OpenWrt:~# dmesg | grep pci
pci 0000:00:00.0: reg 10 32bit mmio pref: [0x000000-0xfffffff]
pci 0000:00:00.0: reg 14 io port: [0x00-0xff]
pci 0000:00:00.0: supports D1 D2
pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot
pci 0000:00:00.0: PME# disabled
pci 0000:00:11.0: reg 10 io port: [0x1f0-0x1f7]
pci 0000:00:11.0: reg 14 io port: [0x3f4-0x3f7]
pci 0000:00:11.0: reg 18 io port: [0x170-0x177]
pci 0000:00:11.0: reg 1c io port: [0x374-0x377]
pci 0000:00:11.0: reg 20 io port: [0x6800-0x680f]
pci 0000:00:11.0: reg 24 32bit mmio: [0x000000-0x003fff]
pci 0000:00:11.0: reg 30 32bit mmio pref: [0x0dc000-0x0dffff]
pci 0000:00:11.0: supports D1
pci 0000:00:11.0: BAR 4: can't allocate I/O resource [0x00-0x00]
pci 0000:00:11.0: BAR 0: can't allocate I/O resource [0x00-0x00]
pci 0000:00:11.0: BAR 2: can't allocate I/O resource [0x00-0x00]
pci 0000:00:11.0: BAR 1: can't allocate I/O resource [0x00-0x00]
pci 0000:00:11.0: BAR 3: can't allocate I/O resource [0x00-0x00]
ath_pci: trunk
}}}
resource of id:
{{{
root@OpenWrt:~# cat /sys/bus/pci/devices/0000\:00\:11.0/resource  
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000010000000 0x0000000010003fff 0x0000000000020200
0x0000000010004000 0x0000000010007fff 0x0000000000027200
root@OpenWrt:~# 
}}}

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.

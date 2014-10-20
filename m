From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 86611] New: USB TO IDE Bridge stopped to work properly after
 kernel upgrade linux-3.12.21 -> linux-3.14.14
Date: Mon, 20 Oct 2014 21:26:09 +0000
Message-ID: <bug-86611-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:46222 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751192AbaJTV0N (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 20 Oct 2014 17:26:13 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 7A33820123
	for <linux-ide@vger.kernel.org>; Mon, 20 Oct 2014 21:26:12 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id CF521201EF
	for <linux-ide@vger.kernel.org>; Mon, 20 Oct 2014 21:26:09 +0000 (UTC)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=86611

            Bug ID: 86611
           Summary: USB TO IDE Bridge stopped to work properly after
                    kernel upgrade linux-3.12.21 -> linux-3.14.14
           Product: IO/Storage
           Version: 2.5
    Kernel Version: 3.14.14, 3.16.6
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
          Assignee: io_ide@kernel-bugs.osdl.org
          Reporter: newchief@king.net.pl
        Regression: No

As in summary: 058f:6390 USB to IDE bridge is not working anymore.

On linux-3.12.21 dmesg says:

[  302.674422] hub 1-0:1.0: state 7 ports 8 chg 0000 evt 0010
[  302.674438] ehci-pci 0000:00:1d.7: GetStatus port:4 status 001002 0  ACK
POWER sig=se0 CSC
[  302.674464] hub 1-0:1.0: port 4, status 0100, change 0001, 12 Mb/s
[  302.700011] ehci-pci 0000:00:1d.7: GetStatus port:4 status 001c03 0  ACK
POWER sig=? CSC CONNECT
[  302.804017] hub 1-0:1.0: debounce: port 4: total 125ms stable 100ms status
0x501
[  302.855244] ehci-pci 0000:00:1d.7: port 4 reset complete, port enabled
[  302.855248] ehci-pci 0000:00:1d.7: GetStatus port:4 status 001005 0  ACK
POWER sig=se0 PE CONNECT
[  302.906018] usb 1-4: new high-speed USB device number 5 using ehci-pci
[  305.083246] ehci-pci 0000:00:1d.7: port 4 reset complete, port enabled
[  305.083251] ehci-pci 0000:00:1d.7: GetStatus port:4 status 001005 0  ACK
POWER sig=se0 PE CONNECT
[  307.272882] usb 1-4: default language 0x0409
[  307.273507] usb 1-4: udev 5, busnum 1, minor = 4
[  307.273511] usb 1-4: New USB device found, idVendor=058f, idProduct=6390
[  307.273515] usb 1-4: New USB device strings: Mfr=1, Product=2,
SerialNumber=0
[  307.273518] usb 1-4: Product: USB TO IDE Bridge
[  307.273520] usb 1-4: Manufacturer: Generic
[  307.273627] usb 1-4: usb_probe_device
[  307.273631] usb 1-4: configuration #1 chosen from 1 choice
[  307.273753] usb 1-4: adding 1-4:1.0 (config #1, interface 0)
[  307.273778] usb-storage 1-4:1.0: usb_probe_interface
[  307.273782] usb-storage 1-4:1.0: usb_probe_interface - got id
[  307.273785] usb-storage 1-4:1.0: USB Mass Storage device detected
[  307.275163] scsi9 : usb-storage 1-4:1.0
[  307.275274] hub 1-0:1.0: state 7 ports 8 chg 0000 evt 0010
[  329.811259] ehci-pci 0000:00:1d.7: port 4 reset complete, port enabled
[  329.811267] ehci-pci 0000:00:1d.7: GetStatus port:4 status 001005 0  ACK
POWER sig=se0 PE CONNECT
[  329.862020] usb 1-4: reset high-speed USB device number 5 using ehci-pci
[  330.017254] ehci-pci 0000:00:1d.7: port 4 reset complete, port enabled
[  330.017259] ehci-pci 0000:00:1d.7: GetStatus port:4 status 001005 0  ACK
POWER sig=se0 PE CONNECT
[  330.172408] scsi 9:0:0:0: Direct-Access     Generic  USB Disk         9.02
PQ: 0 ANSI: 2
[  330.172653] sd 9:0:0:0: Attached scsi generic sg6 type 0
[  330.173648] sd 9:0:0:0: [sdf] 976773168 512-byte logical blocks: (500 GB/465
GiB)
[  330.174641] sd 9:0:0:0: [sdf] Write Protect is off
[  330.174644] sd 9:0:0:0: [sdf] Mode Sense: 03 00 00 00
[  330.176027] sd 9:0:0:0: [sdf] No Caching mode page found
[  330.176030] sd 9:0:0:0: [sdf] Assuming drive cache: write through
[  330.181516] sd 9:0:0:0: [sdf] No Caching mode page found
[  330.181520] sd 9:0:0:0: [sdf] Assuming drive cache: write through
[  330.204155]  sdf: sdf1
[  330.207903] sd 9:0:0:0: [sdf] No Caching mode page found
[  330.207910] sd 9:0:0:0: [sdf] Assuming drive cache: write through
[  330.207914] sd 9:0:0:0: [sdf] Attached SCSI disk

On 3.14.14 it says:

[ 4280.846576] ehci-pci 0000:00:1d.7: GetStatus port:4 status 001003 0  ACK
POWER sig=se0 CSC CONNECT
[ 4280.872016] ehci-pci 0000:00:1d.7: GetStatus port:4 status 001c03 0  ACK
POWER sig=? CSC CONNECT
[ 4281.027259] ehci-pci 0000:00:1d.7: port 4 reset complete, port enabled
[ 4281.027263] ehci-pci 0000:00:1d.7: GetStatus port:4 status 001005 0  ACK
POWER sig=se0 PE CONNECT
[ 4281.078020] usb 1-4: new high-speed USB device number 5 using ehci-pci
[ 4283.255265] ehci-pci 0000:00:1d.7: port 4 reset complete, port enabled
[ 4283.255275] ehci-pci 0000:00:1d.7: GetStatus port:4 status 001005 0  ACK
POWER sig=se0 PE CONNECT
[ 4285.446403] usb 1-4: New USB device found, idVendor=058f, idProduct=6390
[ 4285.446410] usb 1-4: New USB device strings: Mfr=1, Product=2,
SerialNumber=0
[ 4285.446412] usb 1-4: Product: USB TO IDE Bridge
[ 4285.446414] usb 1-4: Manufacturer: Generic
[ 4285.446538] usb 1-4: usb_probe_device
[ 4285.446673] usb-storage 1-4:1.0: usb_probe_interface
[ 4285.446677] usb-storage 1-4:1.0: usb_probe_interface - got id
[ 4285.446681] usb-storage 1-4:1.0: USB Mass Storage device detected
[ 4285.447407] scsi9 : usb-storage 1-4:1.0
[ 4307.805273] ehci-pci 0000:00:1d.7: port 4 reset complete, port enabled
[ 4307.805282] ehci-pci 0000:00:1d.7: GetStatus port:4 status 001005 0  ACK
POWER sig=se0 PE CONNECT
[ 4307.856022] usb 1-4: reset high-speed USB device number 5 using ehci-pci
[ 4308.018268] ehci-pci 0000:00:1d.7: port 4 reset complete, port enabled
[ 4308.018273] ehci-pci 0000:00:1d.7: GetStatus port:4 status 001005 0  ACK
POWER sig=se0 PE CONNECT

And there's nothing after. I've found that on 3.14.14 scsi_probe_lun function
does not result in following output:

sd 9:0:0:0: [sdf] 976773168 512-byte logical blocks: (500 GB/465 GiB)

which is the case for 3.12.21.

Also I tried Fedora with 3.16.6 - still USB TO IDE Bridge does not work
properly.

Some time ago 058f:6390 was quite popular and I think it would be good to have
it still supported (it is not listed as unusual device). I still have huge IDE
disks with archive storage, it would be wasteful to throw them away.

Note that other usb-storage devices (smartphones, SD card readers) work for me
properly with 3.14.14 and newer.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.

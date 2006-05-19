From: "martin schneebacher" <martin.schneebacher@gmail.com>
Subject: (unknown)
Date: Fri, 19 May 2006 11:28:39 +0200
Message-ID: <e30fb88b0605190228u76a14b9h94a8c32f9c7e5058@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:54190 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751271AbWESJ2l (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 May 2006 05:28:41 -0400
Received: by nf-out-0910.google.com with SMTP id o63so29645nfa
        for <linux-ide@vger.kernel.org>; Fri, 19 May 2006 02:28:39 -0700 (PDT)
Subject: 
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

hi all.

since 2.6.17-rc2 (maybe rc1 too) the resume from standby doesn't work
anymore. the system hangs for a while, then it comes back but the sata
drive doesn't work. i have to turn the power off and restart the
computer. i don't know how to debug it, maybe you could give me a hint
if it's necessary.

actual kernel: 2.6.17-rc4
bootoptions:  libata.atapi_enabled=1 vga=791 quiet pci=assign-busses

lspci:
0000:00:00.0 Host bridge: Intel Corporation Mobile 915GM/PM/GMS/910GML
Express Processor to DRAM Controller (rev 03)
0000:00:01.0 PCI bridge: Intel Corporation Mobile 915GM/PM Express PCI
Express Root Port (rev 03)
0000:00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) PCI Express Port 1 (rev 04)
0000:00: 1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW
(ICH6 Family) USB UHCI #1 (rev 04)
0000:00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW
(ICH6 Family) USB UHCI #2 (rev 04)
0000:00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW
(ICH6 Family) USB UHCI #3 (rev 04)
0000:00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW
(ICH6 Family) USB UHCI #4 (rev 04)
0000:00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW
(ICH6 Family) USB2 EHCI Controller (rev 04)
0000:00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev d4)
0000:00:1e.2 Multimedia audio controller: Intel Corporation
82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97 Audio Controller (rev 04)
0000:00: 1e.3 Modem: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) AC'97 Modem Controller (rev 04)
0000:00:1f.0 ISA bridge: Intel Corporation 82801FBM (ICH6M) LPC
Interface Bridge (rev 04)
0000:00:1f.2 IDE interface: Intel Corporation 82801FBM (ICH6M) SATA
Controller (rev 04)
0000:00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) SMBus Controller (rev 04)
0000:01:00.0 VGA compatible controller: nVidia Corporation NV43
[GeForce Go 6600] (rev a2)
0000:03:05.0 Ethernet controller: Atheros Communications, Inc. AR5212
802.11abg NIC (rev 01)
0000:03:07.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8169 Gigabit Ethernet (rev 10)
0000:03:09.0 CardBus bridge: Texas Instruments PCIxx21/x515 Cardbus Controller
0000:03:09.2 FireWire (IEEE 1394): Texas Instruments OHCI Compliant
IEEE 1394 Host Controller
0000:03:09.3 Mass storage controller: Texas Instruments PCIxx21
Integrated FlashMedia Controller
0000:03:09.4 0805: Texas Instruments PCI6411, PCI6421, PCI6611,
PCI6621, PCI7411, PCI7421, PCI7611, PCI7621 Secure Digital (SD)
Controller

hdd:
hitachi travelstar  HTS541080G9SA00

bye...masc.

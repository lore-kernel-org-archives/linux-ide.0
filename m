From: Udo van den Heuvel <udovdh@xs4all.nl>
Subject: Re: sata_via issue for VIA Epia SP8000 in 2.6.18[.1]?
Date: Sun, 22 Oct 2006 15:16:13 +0200
Message-ID: <453B6F1D.5030208@xs4all.nl>
References: <453B67B6.9060708@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-vbr10.xs4all.nl ([194.109.24.30]:58125 "EHLO
	smtp-vbr10.xs4all.nl") by vger.kernel.org with ESMTP
	id S1750870AbWJVNQQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 22 Oct 2006 09:16:16 -0400
Received: from [192.168.10.69] (pindarots.xs4all.nl [82.92.197.115])
	(authenticated bits=0)
	by smtp-vbr10.xs4all.nl (8.13.8/8.13.8) with ESMTP id k9MDGERT034107
	for <linux-ide@vger.kernel.org>; Sun, 22 Oct 2006 15:16:15 +0200 (CEST)
	(envelope-from udovdh@xs4all.nl)
In-Reply-To: <453B67B6.9060708@xs4all.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Udo van den Heuvel wrote:
> Now I try to get 2.6.18.1 working. SATA is detected by this kernel but
> disk gives timeout while 2.6.17.13 boots fine.

By changing quirks.c, quirk_via_irq to be mopre precise to

[...]
                        pci_name(dev), irq, new_irq);
                udelay(15);     /* unknown if delay really needed */
                pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
        }
}
DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irq)
/*DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA,
PCI_DEVICE_ID_VIA_82C586_0, quirk_via_irq);
DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1,
quirk_via_irq);
DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_2,
quirk_via_irq);
DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_3,
quirk_via_irq);
DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA,
PCI_DEVICE_ID_VIA_8235_USB_2, quirk_via_irq);
DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686,
quirk_via_irq);
DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_4,
quirk_via_irq);
DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_5,
quirk_via_irq);*/

stuff starts booting again.
This issue has been there since 2.6,17.x. Please FIX!

Thanks,
Udo


PS:

# lspci
00:00.0 Host bridge: VIA Technologies, Inc. CN400/PM880 Host Bridge
00:00.1 Host bridge: VIA Technologies, Inc. CN400/PM880 Host Bridge
00:00.2 Host bridge: VIA Technologies, Inc. CN400/PM880 Host Bridge
00:00.3 Host bridge: VIA Technologies, Inc. CN400/PM880 Host Bridge
00:00.4 Host bridge: VIA Technologies, Inc. CN400/PM880 Host Bridge
00:00.7 Host bridge: VIA Technologies, Inc. CN400/PM880 Host Bridge
00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
00:0d.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
Controller (rev 80)
00:0f.0 IDE interface: VIA Technologies, Inc. VIA VT6420 SATA RAID
Controller (rev 80)
00:0f.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 81)
00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 81)
00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 81)
00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 81)
00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge
[KT600/K8T800/K8T890 South]
00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II]
(rev 78)
00:14.0 Multimedia controller: Philips Semiconductors SAA7146 (rev 01)
01:00.0 VGA compatible controller: VIA Technologies, Inc. S3 Unichrome
Pro VGA Adapter (rev 02)

# cat /proc/interrupts
           CPU0
  0:     341650          XT-PIC  timer
  1:         48          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:          1          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 10:      13348          XT-PIC  libata, VIA8237, uhci_hcd:usb3,
uhci_hcd:usb4, ehci_hcd:usb5, ohci1394
 11:    4945538          XT-PIC  uhci_hcd:usb1, uhci_hcd:usb2, eth0,
via@pci:0000:01:00.0
 12:       3389          XT-PIC  i8042
 14:      11782          XT-PIC  ide0
NMI:          0
ERR:          0

What other info is useful?

From: Tim Small <tim@seoss.co.uk>
Subject: sata_sil24 - Silicon Image 3124 cards lock-up machine with 3.16-rc6
 (work with 3.2), MSI works with neither kernel
Date: Sat, 26 Jul 2014 16:33:50 +0100
Message-ID: <53D3CA5E.7090807@seoss.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay1.allsecuredomains.com ([78.47.234.210]:43462 "EHLO
	relay1.allsecuredomains.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751434AbaGZP7g (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 26 Jul 2014 11:59:36 -0400
Received: from [81.174.144.187] (helo=[172.19.198.5])
	by relay1.allsecuredomains.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <tim@seoss.co.uk>)
	id 1XB3yo-0005TA-FT
	for linux-ide@vger.kernel.org; Sat, 26 Jul 2014 16:33:50 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

I've not got too far debugging this, but thought I'd post here in case
anyone had any bright ideas...

I have a single box with multiple drives and controller cards - it's
Intel Sandy Bridge based with a Gigabyte GA-PH67-UD3-B3 motherboard.

The problem has appeared with the Syba/IOCrest "PEX40008" Silicon Image
3124 cards - these are a slightly unusual card with the PCI-X SiI3124
chip sitting behind a PCI Express (single lane PCIe 1.0) to PCI-X bridge.

01:00.0 PCI bridge: Pericom Semiconductor Device e111 (rev
02)                                                                                                                                            

02:04.0 Mass storage controller: Silicon Image, Inc. SiI 3124 PCI-X
Serial ATA Controller (rev 02)

apparently identical to this one:

http://www.ebay.com/itm/171387103100


Under heavy I/O (e.g. raid rebuild, or multiple 'dd'), after a few
minutes the box locks up, normally with messages like:

sata_sil24 0000:02:04.0: IRQ status == 0xffffffff, PCI fault or device removal?

(ref my recent patch to identify which card gets the IRQ status error
message).

The issue appears with multiple cards bought at different times from
different vendors.

I can't get this lock-up to occur with the 3124 cards on the 3.2 kernel.

If I move all the active disks to Silicon Image 3132 based controllers
instead, I don't see the lock-up on either 3.2 or 3.16-rc6

I'm currently testing using a single 3124 PCI card behind a different
PCIe to PCI bridge chip (an ITE 8892 on the motherboard) and haven't had
any lockups after a couple of hours, but this controller is limited to
about 75 MB/sec throughput, due to being on a 33MHz PCI bus (limitation
of the ITE 8892 bridge chip), whereas the PEX40008 cards get circa 200
MB/sec throughput (limited by a single PCIe slot running at PCIe 1.0
speeds).

/proc/interrupts [excerpt below] on this box shows shared IRQs to the
Silicon Image cards:

 16:    4053039          0 IO-APIC-fasteoi   sata_sil24, sata_sil24
 18:         82     573633 IO-APIC-fasteoi   sata_sil24, ehci_hcd:usb1,
i801_smbus
 19:        114    5553654 IO-APIC-fasteoi   sata_sil24, sata_sil24 
 23:         37          0 IO-APIC-fasteoi   ehci_hcd:usb2
 41:     184317          0 PCI-MSI-edge      eth0 
 42:     184364          0 PCI-MSI-edge      ahci 
 43:          3    3489756 PCI-MSI-edge      ahci 
 44:         12          0 PCI-MSI-edge      mei_me
 45:        422          0 PCI-MSI-edge      snd_hda_intel

... and seeing as the fault seems to be IRQ related, I thought I'd use
the "msi=1" parameter to the sata_sil24 driver to try and enable message
signalled interrupts, but I didn't have any luck on this -

The 3132 cards enumerate drives correctly and receive a few hundred or a
few thousand interrupts (e.g. 2050 on one card, ans 2041 to the other in
the test I just ran), and thereafter don't get any further interrupts,
causing subsequent I/O to fail:

~# hdparm -t /dev/sdi

/dev/sdi:
 Timing buffered disk reads: read(2097152) returned 131072 bytes

... whereas the 3124 cards don't receive any interrupts at all (all
counts zero in /proc/interrupts).

MSI is already in use and working fine for the Intel H67 AHCI
controller, and also an ASMedia ASM1062 based PCIe card in the same machine.

Same MSI failure on both the 3.2 and 3.16rc6 kernels on this box.

Unfortunately, my opportunities to debug on this box are a bit limited
due to pressure to keep it in service, but I have a couple of 3124 and
3132 cards that I can borrow from the machine in question and elsewhere,
and put into another box to test.

Any suggestions for things which would throw more light on the matter (I
know that using git bisect is a possibility)?

Tim.

-- 
South East Open Source Solutions Limited
Registered in England and Wales with company number 06134732.  
Registered Office: 2 Powell Gardens, Redhill, Surrey, RH1 1TQ
VAT number: 900 6633 53  http://seoss.co.uk/ +44-(0)1273-808309


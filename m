From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: sata_promise: port is slow to respond, reset failed
Date: Tue, 4 Sep 2007 10:14:51 +0200
Message-ID: <18141.5115.238011.870159@alkaid.it.uu.se>
References: <200709030811.l838BC9a026315@harpo.it.uu.se>
	<46DC70AE.6050100@how.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:48385 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751300AbXIDIO4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Sep 2007 04:14:56 -0400
In-Reply-To: <46DC70AE.6050100@how.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peter Favrholdt <linux-ide@how.dk>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org

Peter Favrholdt writes:
 > Hi,
 > 
 > Below some more info on my two systems:
 > 
 > Mikael Pettersson wrote:
 > > I assume the PE1800 has some Intel chipset? Which one?
...
 > 0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev c2)
 > 0000:00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge 
 > (rev 02)

ICH5. Should be decent enough.

 > > And the machine that does have problems, what chipset does it have?
...
 > 00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge (rev a3)

nForce2. Hmm..

 > cat /proc/interrupts
 >             CPU0
 >    0:         79    XT-PIC-XT        timer
 >    1:          2    XT-PIC-XT        i8042
 >    2:          0    XT-PIC-XT        cascade
 >    5:     141710    XT-PIC-XT        sk98lin
 >    6:          5    XT-PIC-XT        floppy
 >    7:         35    XT-PIC-XT        parport0
 >    8:          1    XT-PIC-XT        rtc
 >    9:          6    XT-PIC-XT        acpi, ehci_hcd:usb1, ohci1394
 >   10:          0    XT-PIC-XT        MPU401 UART
 >   11:      27474    XT-PIC-XT        libata, libata, ohci_hcd:usb3, 
 > NVidia nForce2
 >   12:      15057    XT-PIC-XT        ohci_hcd:usb2
 >   14:      23211    XT-PIC-XT        ide0
 >   15:      32805    XT-PIC-XT        ide1
 > NMI:       3911
 > LOC:     917176
 > ERR:          0
 > 
 > The promise card is sharing IRQ11 with usb, the other libata device, and 
 > nForce2 (wonder what that is?)

That "mystery" device makes me strongly suspect that you've
loaded the binary-only nvidia drivers. If that's true, then
the machine's problems may just as well be caused by that driver,
not sata_promise. (We've seen that happen before.)

 > > I'm actually beginning to think there's some PCI compatibility breakage
 > > somewhere, as I too see sata_promise working fine in some machines but
 > > not in others. Alas, my knowledge of PCI tweakables is close to nil.
 > 
 > I second that (although I'm really clueless about PCI).
 > 
 > Could it be that at 3.0Gbps with 4 ports running at full speed 
 > contention on the pci bus cause this behavior? This would explain why a 
 > PCI-X port helps (or limiting to 1.5Gbps). Or maybe it is an NFORCE2 
 > issue... Or too many IRQ-handlers on the same IRQ...
 > 
 > I wish I could do something more to help. Unfortunately it is almost 
 > impossible for me to do tests on the Intel system (as it is a production 
 > system) - though I might be able to try some things late at night in the 
 > weekends ;-)
 > 
 > Guess at this point it would be nice to be able to reproduce the 
 > behavior on an Intel system...

I can reproduce it on an Intel 440BX chipset machine with a PIII.
However, that chipset, while very good in its day, is rather old now.

I'll run some more tests this weekend on less ancient hardware.

/Mikael

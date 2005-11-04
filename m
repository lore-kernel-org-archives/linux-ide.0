From: Don Carroll <ibedonc@star-c.com>
Subject: Asus A8V , via vt8251 AHCI time
Date: Thu, 3 Nov 2005 20:36:36 -0600
Message-ID: <20051104023636.GA19368@vcr.star-c.com>
References: <20051101064058.GA4902@vcr.star-c.com> <Pine.LNX.4.58.0511010736550.11761@shark.he.net> <20051101192449.GA9719@vcr.star-c.com> <Pine.LNX.4.58.0511011237080.11761@shark.he.net> <20051102034151.GA7583@vcr.star-c.com> <20051101195715.212ea264.rdunlap@xenotime.net> <20051102043643.GA5577@vcr.star-c.com> <20051101205659.7e97c145.rdunlap@xenotime.net> <20051102051343.GA7057@vcr.star-c.com> <20051101211203.68f1e119.rdunlap@xenotime.net>
Reply-To: ibedonc@star-c.com, ibedonc@star-c.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dpc6935171158.direcpc.com ([69.35.171.158]:3543 "EHLO
	vcr.star-c.com") by vger.kernel.org with ESMTP id S1161115AbVKDCh3
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 3 Nov 2005 21:37:29 -0500
Received: from vcr.star-c.com ([192.168.1.2])
	by vcr.star-c.com (8.13.4/8.13.1) with ESMTP id jA42at7f026783
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Thu, 3 Nov 2005 20:37:04 -0600
Received: (from don@localhost)
	by vcr.star-c.com (8.12.9-20030917/8.13.4/Submit) id jA42aavo026649
	for linux-ide@vger.kernel.org; Thu, 3 Nov 2005 20:36:36 -0600
Content-Disposition: inline
In-Reply-To: <20051101211203.68f1e119.rdunlap@xenotime.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

anyone alse got any ideas
on this

Jeff Garzik  ??


On Tue, Nov 01, 2005 at 09:12:03PM -0800, Randy.Dunlap wrote:
> On Tue, 1 Nov 2005 23:13:43 -0600 Don Carroll wrote:
> 
> > On Tue, Nov 01, 2005 at 08:56:59PM -0800, Randy.Dunlap wrote:
> > > On Tue, 1 Nov 2005 22:36:43 -0600 Don Carroll wrote:
> > > 
> > > > I think it was , I can try again
> > > > 
> > > > the next one is without MSI
> > > > 
> > > 
> > > I'm sorry to put you to all of that trouble.
> > Hey I want to get it working :)
> > was no trouble  (I am systems Eng)
> 
> OK, good.
> 
> > > I've seen some very similar issues which turned out to be MSI-related,
> > > but this one doesn't seem to be that way -- unless MSI + irqpoll
> > > (your next test) happens to work for you -- then manybe it will
> > > give us some more evidence.  If it does boot, please send us
> > > the contents of /proc/interrupts .
> > nope , still times out  
> > 
> > here is /proc/interrupts anyway
> > irq 19 is the ahci
> 
> and irq 16 also (libata on both of them).
> How do you know which one is for which controller/drive(s)?
> 
> Anyone else out there have ideas??
> 
> 
> >           CPU0       CPU1
> >   0:        333     459694    IO-APIC-edge  timer
> >   1:          3       4244    IO-APIC-edge  i8042
> >   8:          0          0    IO-APIC-edge  rtc
> >   9:          0          0   IO-APIC-level  acpi
> >  12:         31      51463    IO-APIC-edge  i8042
> >  15:          5      14079    IO-APIC-edge  ide1
> >  16:         26      72751   IO-APIC-level  libata
> >  17:          0          0   IO-APIC-level  uhci_hcd:usb1
> >  18:          0         77   IO-APIC-level  uhci_hcd:usb2, ehci_hcd:usb5,
> > VIA8237
> >  19:          0          0   IO-APIC-level  uhci_hcd:usb3, libata
> >  20:          2       2824   IO-APIC-level  uhci_hcd:usb4, eth0
> > NMI:        641       1026
> > LOC:     459992     459969
> > ERR:          0
> > MIS:          0
> 
> 
> ---
> ~Randy

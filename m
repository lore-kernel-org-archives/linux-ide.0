From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: sata_promise: port is slow to respond, reset failed
Date: Tue, 4 Sep 2007 20:47:57 +0200
Message-ID: <18141.43101.618644.38451@alkaid.it.uu.se>
References: <200709030811.l838BC9a026315@harpo.it.uu.se>
	<46DC70AE.6050100@how.dk>
	<18141.5115.238011.870159@alkaid.it.uu.se>
	<46DD93DD.8020100@how.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:53857 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751993AbXIDSsd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Sep 2007 14:48:33 -0400
In-Reply-To: <46DD93DD.8020100@how.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peter Favrholdt <linux-ide@how.dk>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org

Peter Favrholdt writes:
 > Mikael Pettersson wrote:
 > > nForce2. Hmm..
 > 
 > Peter Favrholdt wrote:
 > >  >   11:      27474    XT-PIC-XT        libata, libata, ohci_hcd:usb3, 
 > >  > NVidia nForce2
 > 
 > > That "mystery" device makes me strongly suspect that you've
 > > loaded the binary-only nvidia drivers. If that's true, then
 > > the machine's problems may just as well be caused by that driver,
 > > not sata_promise. (We've seen that happen before.)
 > 
 > I didn't load any special NVidia driver - vanilla kernel only. The 
 > graphics card is Matrox G550. The nForce2 could be the nForce2 SMBus or 
 > the nForce2 IDE. Here is the result of dmesg | grep -i nforce
 > [   26.379422] NFORCE2: IDE controller at PCI slot 0000:00:09.0
 > [   26.379481] NFORCE2: chipset revision 162
 > [   26.379525] NFORCE2: not 100% native mode: will probe irqs later
 > [   26.379575] NFORCE2: BIOS didn't set cable bits correctly. Enabling 
 > workaround.
 > [   26.379634] NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
 > [   31.861284] i2c_adapter i2c-0: nForce2 SMBus adapter at 0x5000
 > [   31.861391] i2c_adapter i2c-1: nForce2 SMBus adapter at 0x5500

OK, sorry about that. The 'NVidia nForce2' string does occur in two
sound drivers, so that may be where it's coming from.

 > > I can reproduce it on an Intel 440BX chipset machine with a PIII.
 > > However, that chipset, while very good in its day, is rather old now.
 > 
 > I believe the problem here only shows if all four sata ports are 
 > stressed simultaneously (I should test this thoroughly). The dependence 
 > on Barracuda 7200.10 could be because these disks are faster than the 
 > others tested, this needed in order for the PCI contention to arise? 
 > (I'm still wild-guessing here).

On my old 440BX reading a single Barracuda (7200.10 or .9 I don't remember)
or Spinpoint disk was enough to trigger the errors.

/Mikael

From: Soeren Sonnenburg <kernel@nn7.de>
Subject: Re: sata sil3114 vs. certain seagate drives results in filesystem
	corruptions
Date: Mon, 22 Oct 2007 07:56:07 +0200
Message-ID: <1193032567.10246.17.camel@localhost>
References: <1192863324.5720.162.camel@localhost>
	 <471C071C.2010202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754589AbXJVF43@vger.kernel.org>
In-Reply-To: <471C071C.2010202@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Bernd Schubert <bs@q-leap.de>
List-Id: linux-ide@vger.kernel.org

On Mon, 2007-10-22 at 11:12 +0900, Tejun Heo wrote:
> Helo,
> 
> Soeren Sonnenburg wrote:
> > I finally managed to find a *reproducible* setup and way to trigger
> > random corruptions using a sata sil 3114 controller connected to 4
> > seagate drives
> > 
> > port 1: ST3400832AS sda
> > port 2: ST3400620AS sdb
> > port 3: ST3750640AS sdc
> > port 4: ST3750640AS sdd
> > 
> > sda & sdb form md0 via a raid1 setup followed by an additional
> > devicemapper layer ( root ). sdc and sdb are separate and also have an
> > additional device mapper layer ( public ) and ( backups ).
> > 
> > Now when I write large files of zeros to root(sda&sdb) and read the file
> > back in it contains a few nonzero entries:
> > 
> > # dd if=/dev/zero of=/foo bs=1M count=2000
> > # hexdump /foo
> > 0000000 0000 0000 0000 0000 0000 0000 0000 0000
> > *
> > <after >1GB random parts, within large blocks of zeroes> 
> > 
> > I can reliably trigger this on the md0 / devmapper-root setup when I
> > write about 2GB of data (note that this machine has 1.5G of memory - and
> > still 1GB is often enough to see this problem). Here it does not matter
> > where in the filesystem I do these writes.
> 
> Thanks.  I'll try to reproduce the problem here.  What's your motherboard?

It is an asus a7v8x with a AMD Athlon(TM) XP 3000+ and admittingly
almost completely filled pci slots (4 dvb cards, 1 with the sil3114; 1
empty; in the agp slot a radeon 9200). Nevertheless I would not expect
the power supply to be the problem (it got replaced recently by a 500W
one), enough cooling (it is winter in germany + several fans).

> > Now promise_sata is converted to new EH, so I simply gave it a go, i.e.
> > I attached ST3400832AS and ST3400620AS to the promise controller and
> > rebooted and redid the experiments from above.
> > 
> > No data corruptions whatsoever. I even ran the dd on all three devmapped
> > mount points simultaneously with a size of 30GB each, still no
> > corruption. However the error messages I've seen a year ago are back for
> > the ST3400832AS and ST3400620AS attached to the promise controller (see
> > below).
> [--snip--]
> > ata1.00: exception Emask 0x10 SAct 0x0 SErr 0x100 action 0x2
> > ata1.00: port_status 0x20200000
> > ata1.00: cmd 25/00:00:c0:b6:74/00:01:20:00:00/e0 tag 0 cdb 0x0 data 131072 in
> >          res 51/0c:00:c0:b6:74/0c:01:20:00:00/e0 Emask 0x10 (ATA bus error)
> > ata1: soft resetting port
> 
> Yeah, still the same.  Your drives don't like the way promise controller
> speaks to them (e.g. promise generates signals which are ) but now that
> sata_promise has proper EH.  It can recover from those errors.  As long
> as nothing worse happens, it should be okay.

These errors only appear when I generate some stress (like with the dd).
The machine is now up 2 days 8hrs and no further such warnings in the
log.

Soeren

From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: libata interface fatal error
Date: Mon, 18 Jun 2007 09:05:30 +0200 (MEST)
Message-ID: <200706180705.l5I75U6r000348@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:60831 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758816AbXFRHFn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 18 Jun 2007 03:05:43 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tomi.Orava@ncircle.nullnet.fi, htejun@gmail.com
Cc: florian@effenberger.org, jeff@garzik.org, linux-ide@vger.kernel.org, mikpe@it.uu.se

On Mon, 18 Jun 2007 15:28:44 +0900, Tejun Heo wrote:
> Yeah, it seems promise has some problem with 3G link.  Cc'ing Mikael
> Pettersson and quoting whole body for him.  Mikael, does this look familiar?
> 
> Tomi Orava wrote:
> > Hi Tejun,
> > 
> > I've been trying to find a solution for a long time for quite a similar
> > libata errror messages as shown in this thread. Perhaps you might get have
> > some ideas what the actual originator might be:
> > 
> > With the latest 2.6.22-rc4-git4 kernel I still get the following error
> > messages
> > with high I/O load:
> > 
> > sd 2:0:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
> > sd 2:0:0:0: [sdc] Write Protect is off
> > sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
> > sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't
> > support DPO or FUA
> > ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
> > ata3.00: (port_status 0x20080000)
> > ata3.00: cmd c8/00:08:af:91:49/00:00:00:00:00/e5 tag 0 cdb 0x0 data 4096 in
> >          res 50/00:00:b6:91:49/00:00:11:00:00/e5 Emask 0x2 (HSM violation)
> > ata3: soft resetting port
> > ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> > ata3.00: ata_hpa_resize 1: sectors = 976773168, hpa_sectors = 976773168
> > ata3.00: ata_hpa_resize 1: sectors = 976773168, hpa_sectors = 976773168
> > ata3.00: configured for UDMA/133
> > ata3: EH complete
> > 
> > ... and later in the chain ...
> > 
> > sd 2:0:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
> > sd 2:0:0:0: [sdc] Write Protect is off
> > sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
> > sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't
> > support DPO or FUA
> > ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
> > ata3.00: (port_status 0x20080000)
> > ata3.00: cmd c8/00:08:67:74:65/00:00:00:00:00/ec tag 0 cdb 0x0 data 4096 in
> >          res 50/00:00:6e:74:65/00:00:1b:00:00/ec Emask 0x2 (HSM violation)
> > ata3: soft resetting port
> > ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> > ata3.00: ata_hpa_resize 1: sectors = 976773168, hpa_sectors = 976773168
> > ata3.00: ata_hpa_resize 1: sectors = 976773168, hpa_sectors = 976773168
> > ata3.00: configured for UDMA/100
> > ata3: EH complete
> > 
> > --- This goes on until UDMA/33 has been reched
...
> > and the problems relate only to Seagate 7200.10 SATA-disks, never with the
> > older 7200.7 SATA-disks alll connected to Promise Sata 300TX4-controller.
...
> > PS. These problems are not special to this single machine as a friend at work
> >       has the same Promise Sata300TX4 card with exactly the same Seagate
> > 7200.10
> >       SATA-disks on an intel-based P4 machine with similar problems under
> > I/O-load.

Yes, this is familiar. Several people have reported problems with
Seagate's 7200.10 disks in 3Gbps operation on sata_promise.
Unfortunately the error reports don't really give a clue as to what
the root cause is.

I used to be able to forcibly trigger similar errors with their
7200.9 disks, but I can't seem to do that any more.

/Mikael

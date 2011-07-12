From: Derry Bryson <derry@high-rely.com>
Subject: RE: Problem w/ hotplug on sata_sil24 w/ PMP (sil3726)
Date: Tue, 12 Jul 2011 19:21:17 +0000
Message-ID: <359604ECF8F440408B9634E6146249B4321C2569@mail.scl.local>
References: <359604ECF8F440408B9634E6146249B42923805F@mail.scl.local>
 <20110628095723.GC3386@htj.dyndns.org>
 <359604ECF8F440408B9634E6146249B4321BDEE6@mail.scl.local>
 <20110712150113.GC4347@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cal3-mh484-a.smtproutes.com ([208.70.89.247]:53860 "EHLO
	cal3-mh484-a.smtproutes.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754281Ab1GLTVd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 12 Jul 2011 15:21:33 -0400
In-Reply-To: <20110712150113.GC4347@mtj.dyndns.org>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "tj@kernel.org" <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>



> -----Original Message-----
> From: Tejun Heo [mailto:htejun@gmail.com] On Behalf Of tj@kernel.org
> Sent: Tuesday, July 12, 2011 8:01 AM
> To: Derry Bryson
> Cc: linux-ide@vger.kernel.org
> Subject: Re: Problem w/ hotplug on sata_sil24 w/ PMP (sil3726)
> 
> Sorry about the long delay.
> 
> On Thu, Jun 30, 2011 at 05:53:32PM +0000, Derry Bryson wrote:
> > I have included info from kern.log below showing turning the bay on
> and off before and
> > after I patched the kernel.
> 
> kern.log tends to be too cluttered with extra timestamps.  Can you
> please use 'dmesg -c' after each phase of testing?  printk timestamps
> included there should be enough.
>

Will do in the future.
 
> > I first applied the patch from your previous email and changed the
> > second timing value to 1000 and that makes it work.  It also works
> > if you leave the timing values alone and up the retries (i.e
> > ATA_EH_PMP_LINK_TRIES) from 3 to 5.  It seems to me the drives are
> > taking a long (relatively) time to spin up and either way all we are
> > doing is giving it more time to spin up.
> 
> That's debouncing timing.  It doesn't have much to do with spinning
> up.  Spinning up can take over ten seconds.  PHY is usually ready well
> under a sec once power is applied.  The reason why libata stops
> waiting during reset is because PHY flickers - it comes up and then
> goes out again.  libata EH already debounces to work around these
> glitches but it seems this 'flickering' is larger scale than libata
> parameters expect.
> 
> One suspicion I have is that the PSU in the enclosure isn't stable
> enough to maintain PHY state while multiples drives are powering up.
> If this is the case, PHYs may keep flickering well over a second which
> libata doesn't expect them to.  Beefing up the PSU (or using a second
> PSU to power some of the harddrives) and see whether anything changes
> would be a good way to test it.
> 

I doubt it is a PSU issue for a couple of reasons:  1) all drives (5) are
detected properly if I power the unit (external hard drive box, not computer) 
off and on, and 2) it fails the same way with only 1 drive in the unit.

I will, however, try to test with a larger power supply tomorrow.
 
> > Is there some way to know it is spinning up and wait for that rather
> > than just trying to reset the controller over and over?  Also I
> > notice from the kernel log that the 'hotplugged' flag is only set
> > the first time it does the hard reset and is then cleared.  If this
> > didn't get cleared it may work that way as well.  All of this only
> > fixes the problem until an slower drive comes out.
> 
> The hotplugged timing is supposed to kick in only once after a hotplug
> event as some PHYs tend to take longer time to lock on after hotplug
> event.
> 
> > From the SMART info on the drives for the WD 3TB that fails the spin
> > up value was 188 vs.  a Seagate 160GB that was 87.  I believe these
> > values are in milliseconds so we can see that the drive that fails
> > takes much longer to spin up.
> 
> That's more likely centisecs instead of millisecs.  8.7sec would be
> about normal for regular drives.  18.8 isn't too far off for large
> ones with more platters.  The more important thing probably is that
> the WD 3TB drive is likely to draw much more power than the smaller
> one taxing the PSU in the enclosure which could have been designed to
> have just enough power for more regular drives.
> 
> > Jun 30 10:02:26 HR-NETSWAP kernel: [   99.510350] ata1.00: XXXX
> hardreset hotplugged = false
> > Jun 30 10:02:26 HR-NETSWAP kernel: [   99.510356] ata1.00: XXX0
> hardreset debounce 5 100 2000
> > Jun 30 10:02:26 HR-NETSWAP kernel: [   99.510361] ata1.00: XXX1
> hardreset debounce 5 100 2000
> 
> So if you bump the second timing value to 1000, it works without
> retrying?  Can you please post kernel log w/ that change?
>

No, bumping the second timing value to 1000 does not cause it to
work without retrying.  Even bumping it up to 10000 does not work
without retries (only bumping to 10000 on the first hotplug reset).  
Upping the number of retries to 5 without changing
any timing works (on the 4th try) and changing the second timing 
value to 1000 without changing the number of retries works.  It 
works if we try long enough (i.e. enough times or longer each time).

Below are logs from hotplugging a Samsung 160GB and a WD 3TB drives
with a kernel with stock timing values but retries changed from 3
to 5 with only the one drive installed.

160GB Samsung:

[  363.846588] ata5.00: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0xf
[  363.856174] ata5.00: SError: { PHYRdyChg CommWake DevExch }
[  363.865884] ata5.00: hard resetting link
[  364.610400] ata5.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[  364.610506] ata5.00: failed to IDENTIFY (I/O error, err_mask=0x11)
[  364.610515] ata5.15: hard resetting link
[  366.830050] ata5.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[  369.610115] ata5.00: hard resetting link
[  369.960400] ata5.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[  369.960446] ata5.01: hard resetting link
[  370.310393] ata5.01: SATA link down (SStatus 0 SControl 320)
[  370.310468] ata5.02: hard resetting link
[  370.660390] ata5.02: SATA link down (SStatus 0 SControl 320)
[  370.660467] ata5.03: hard resetting link
[  371.010405] ata5.03: SATA link down (SStatus 0 SControl 320)
[  371.010482] ata5.04: hard resetting link
[  371.360395] ata5.04: SATA link down (SStatus 0 SControl 320)
[  371.360471] ata5.05: hard resetting link
[  371.710398] ata5.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[  371.754495] ata5.00: ATA-7: ST3160815AS, 4.AAB, max UDMA/133
[  371.754503] ata5.00: 312581808 sectors, multi 0: LBA48 NCQ (depth 31/32)
[  371.812838] ata5.00: configured for UDMA/100
[  371.812925] ata5: EH complete
[  371.813118] scsi 2:0:0:0: Direct-Access     ATA      ST3160815AS      4.AA PQ: 0 ANSI: 5
[  371.813561] sd 2:0:0:0: [sdb] 312581808 512-byte logical blocks: (160 GB/149 GiB)
[  371.813583] sd 2:0:0:0: Attached scsi generic sg1 type 0
[  371.813732] sd 2:0:0:0: [sdb] Write Protect is off
[  371.813739] sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  371.813810] sd 2:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  371.814219]  sdb: sdb1
[  371.861659] sd 2:0:0:0: [sdb] Attached SCSI disk
 
3TB WD:

[ 1359.196664] ata5.00: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0xf
[ 1359.206398] ata5.00: SError: { PHYRdyChg CommWake DevExch }
[ 1359.216282] ata5.00: hard resetting link
[ 1359.960533] ata5.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 1359.960664] ata5.00: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1359.960673] ata5.15: hard resetting link
[ 1362.180058] ata5.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[ 1364.960050] ata5.00: hard resetting link
[ 1365.320463] ata5.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 1365.320513] ata5.01: hard resetting link
[ 1365.670458] ata5.01: SATA link down (SStatus 0 SControl 320)
[ 1365.670536] ata5.02: hard resetting link
[ 1366.020447] ata5.02: SATA link down (SStatus 0 SControl 320)
[ 1366.020531] ata5.03: hard resetting link
[ 1366.370447] ata5.03: SATA link down (SStatus 0 SControl 320)
[ 1366.370529] ata5.04: hard resetting link
[ 1366.720449] ata5.04: SATA link down (SStatus 0 SControl 320)
[ 1366.720532] ata5.05: hard resetting link
[ 1367.071698] ata5.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[ 1367.071811] ata5.00: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1367.071821] ata5.15: hard resetting link
[ 1369.290060] ata5.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[ 1370.320045] ata5.00: hard resetting link
[ 1370.670447] ata5.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 1372.070031] ata5.05: hard resetting link
[ 1372.420462] ata5.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[ 1372.420576] ata5.00: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1372.420585] ata5.15: hard resetting link
[ 1374.640051] ata5.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[ 1375.670038] ata5.00: hard resetting link
[ 1376.020452] ata5.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 1376.020500] ata5.01: hard resetting link
[ 1376.370454] ata5.01: SATA link down (SStatus 0 SControl 320)
[ 1376.370535] ata5.02: hard resetting link
[ 1376.730451] ata5.02: SATA link down (SStatus 0 SControl 320)
[ 1376.730530] ata5.03: hard resetting link
[ 1377.080467] ata5.03: SATA link down (SStatus 0 SControl 320)
[ 1377.080545] ata5.04: hard resetting link
[ 1377.430455] ata5.04: SATA link down (SStatus 0 SControl 320)
[ 1377.430538] ata5.05: hard resetting link
[ 1377.780454] ata5.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[ 1377.804656] ata5.00: ATA-8: WDC WD30EZRX-00MMMB0, 80.00A80, max UDMA/133
[ 1377.804664] ata5.00: 5860533168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[ 1377.812240] ata5.00: configured for UDMA/100
[ 1377.812332] ata5: EH complete
[ 1377.812529] scsi 4:0:0:0: Direct-Access     ATA      WDC WD30EZRX-00M 80.0 PQ: 0 ANSI: 5
[ 1377.813010] sd 4:0:0:0: Attached scsi generic sg1 type 0
[ 1377.813029] sd 4:0:0:0: [sdb] 5860533168 512-byte logical blocks: (3.00 TB/2.72 TiB)
[ 1377.813047] sd 4:0:0:0: [sdb] 4096-byte physical blocks
[ 1377.813191] sd 4:0:0:0: [sdb] Write Protect is off
[ 1377.813199] sd 4:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 1377.813271] sd 4:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1377.813854]  sdb: sdb1 sdb2
[ 1377.856633] sd 4:0:0:0: [sdb] Attached SCSI disk

Here is a full power up with 5 drives installed showing all drives coming up, just for fun:

[  681.406102] ata5: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe frozen
[  681.414150] ata5: irq_stat 0x00a00080, device exchanged
[  681.422507] ata5: hard resetting link
[  683.640045] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[  683.640317] ata5.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9
[  683.640571] ata5.00: hard resetting link
[  683.990395] ata5.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[  683.990440] ata5.01: hard resetting link
[  684.340399] ata5.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  684.340444] ata5.02: hard resetting link
[  684.690366] ata5.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  684.690408] ata5.03: hard resetting link
[  685.040398] ata5.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  685.040440] ata5.04: hard resetting link
[  685.390396] ata5.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  685.390440] ata5.05: hard resetting link
[  685.740398] ata5.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[  685.740504] ata5.00: failed to IDENTIFY (I/O error, err_mask=0x11)
[  685.740514] ata5.15: hard resetting link
[  687.960045] ata5.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[  688.990039] ata5.00: hard resetting link
[  689.340400] ata5.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[  689.340447] ata5.01: hard resetting link
[  689.690371] ata5.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  689.690413] ata5.02: hard resetting link
[  690.040396] ata5.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  690.040441] ata5.03: hard resetting link
[  690.390394] ata5.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  690.390438] ata5.04: hard resetting link
[  690.740392] ata5.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  690.740436] ata5.05: hard resetting link
[  691.090370] ata5.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[  691.129944] ata5.00: ATA-7: ST3160815AS, 4.AAB, max UDMA/133
[  691.129951] ata5.00: 312581808 sectors, multi 0: LBA48 NCQ (depth 31/32)
[  691.188279] ata5.00: configured for UDMA/100
[  691.188349] ata5.01: failed to IDENTIFY (I/O error, err_mask=0x11)
[  691.188359] ata5.15: hard resetting link
[  693.400046] ata5.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[  693.400334] ata5.00: hard resetting link
[  693.750395] ata5.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[  694.690041] ata5.01: hard resetting link
[  695.040389] ata5.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  695.040432] ata5.02: hard resetting link
[  695.390390] ata5.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  695.390434] ata5.03: hard resetting link
[  695.740410] ata5.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  695.740454] ata5.04: hard resetting link
[  696.090370] ata5.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  696.090412] ata5.05: hard resetting link
[  696.440402] ata5.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[  696.528113] ata5.00: configured for UDMA/100
[  696.528182] ata5.01: failed to IDENTIFY (I/O error, err_mask=0x11)
[  696.528191] ata5.15: hard resetting link
[  698.740047] ata5.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[  698.740324] ata5.00: hard resetting link
[  699.090372] ata5.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[  700.040037] ata5.01: hard resetting link
[  700.390398] ata5.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  700.390444] ata5.02: hard resetting link
[  700.740390] ata5.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  700.740434] ata5.03: hard resetting link
[  701.090372] ata5.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  701.090413] ata5.04: hard resetting link
[  701.440397] ata5.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  701.440442] ata5.05: hard resetting link
[  701.800393] ata5.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[  701.892633] ata5.00: configured for UDMA/100
[  701.893390] ata5.01: ATA-8: ST33000651AS, CC44, max UDMA/133
[  701.893397] ata5.01: 5860533168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[  701.894287] ata5.01: configured for UDMA/100
[  701.989689] ata5.02: ATA-8: WDC WD30EZRX-00MMMB0, 80.00A80, max UDMA/133
[  701.989697] ata5.02: 5860533168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[  701.997716] ata5.02: configured for UDMA/100
[  702.003298] ata5.03: ATA-8: SAMSUNG HD502HJ, 1AJ10001, max UDMA/133
[  702.003305] ata5.03: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[  702.009010] ata5.03: configured for UDMA/100
[  702.010263] ata5.04: ATA-8: ST320005XXXX, CC34, max UDMA/133
[  702.010270] ata5.04: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[  702.011718] ata5.04: configured for UDMA/100
[  702.011801] ata5: EH complete
[  702.011991] scsi 2:0:0:0: Direct-Access     ATA      ST3160815AS      4.AA PQ: 0 ANSI: 5
[  702.012429] sd 2:0:0:0: [sdb] 312581808 512-byte logical blocks: (160 GB/149 GiB)
[  702.012445] sd 2:0:0:0: Attached scsi generic sg1 type 0
[  702.012576] sd 2:0:0:0: [sdb] Write Protect is off
[  702.012583] sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  702.012666] sd 2:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  702.013093] scsi 2:1:0:0: Direct-Access     ATA      ST33000651AS     CC44 PQ: 0 ANSI: 5
[  702.013112]  sdb:
[  702.013617] sd 2:1:0:0: Attached scsi generic sg2 type 0
[  702.013657] sd 2:1:0:0: [sdc] 5860533168 512-byte logical blocks: (3.00 TB/2.72 TiB)
[  702.013909] sd 2:1:0:0: [sdc] Write Protect is off
[  702.013920] sd 2:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  702.014006] sd 2:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  702.014593]  sdc:
[  702.015383] scsi 2:2:0:0: Direct-Access     ATA      WDC WD30EZRX-00M 80.0 PQ: 0 ANSI: 5
[  702.015994] sd 2:2:0:0: Attached scsi generic sg3 type 0
[  702.016399] scsi 2:3:0:0: Direct-Access     ATA      SAMSUNG HD502HJ  1AJ1 PQ: 0 ANSI: 5
[  702.016899] sd 2:3:0:0: Attached scsi generic sg4 type 0
[  702.017521] scsi 2:4:0:0: Direct-Access     ATA      ST320005XXXX     CC34 PQ: 0 ANSI: 5
[  702.018030] sd 2:4:0:0: Attached scsi generic sg5 type 0
[  702.019837] sd 2:2:0:0: [sdd] 5860533168 512-byte logical blocks: (3.00 TB/2.72 TiB)
[  702.019847] sd 2:2:0:0: [sdd] 4096-byte physical blocks
[  702.020042] sd 2:2:0:0: [sdd] Write Protect is off
[  702.020062] sd 2:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  702.020173] sd 2:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  702.022614]  sdd:
[  702.024184] sd 2:3:0:0: [sde] 976773168 512-byte logical blocks: (500 GB/465 GiB)
[  702.024378] sd 2:3:0:0: [sde] Write Protect is off
[  702.024388] sd 2:3:0:0: [sde] Mode Sense: 00 3a 00 00
[  702.024482] sd 2:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  702.025055]  sde:
[  702.028267] sd 2:4:0:0: [sdf] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
[  702.030132] sd 2:4:0:0: [sdf] Write Protect is off
[  702.030146] sd 2:4:0:0: [sdf] Mode Sense: 00 3a 00 00
[  702.030299] sd 2:4:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  702.030853]  sdf: sdb1
[  702.033306]  sde1
[  702.033525] sd 2:0:0:0: [sdb] Attached SCSI disk
[  702.034960] sd 2:3:0:0: [sde] Attached SCSI disk
[  702.044906]  sdf1
[  702.080787] sd 2:4:0:0: [sdf] Attached SCSI disk
[  702.081308]  sdd1 sdd2
[  702.082147]  sdc1 sdc2
[  702.083703] sd 2:1:0:0: [sdc] Attached SCSI disk
[  702.083726] sd 2:2:0:0: [sdd] Attached SCSI disk

I don't know what to try next.

Thanks,

Derry Bryson
Sr. Software Engineer 

Highly Reliable Systems
www.High-Rely.com
"Making Backup Invisible"

Phone: 775.329.5139 X129
Fax:     775.370.1001

Sales & Support: 877.384.6838

This e-mail and any files transmitted with it are the property of Highly Reliable Systems, Inc. This (email) information is confidential, and is intended solely for the use of the individual or entity to whom this e-mail is addressed. If you are not one of the named recipient(s) or otherwise have reason to believe that you have received this message in error, please notify the sender and delete this message immediately from your computer. Any other use, disclosure, retention, dissemination, forwarding, printing, distribution or copying of this e-mail is strictly prohibited.





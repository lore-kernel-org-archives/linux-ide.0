From: Thomas Drillich <th@drillich.com>
Subject: Re: ide dvd burner detected as ide-tape
Date: Thu, 9 Oct 2008 16:43:52 +0200
Message-ID: <200810091643.53702.th@drillich.com>
References: <200810010100.06299.th@drillich.com> <200810041412.44162.th@drillich.com> <200810082125.58994.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_pih7ICy6j97v2Nz"
Return-path: <linux-hotplug-owner@vger.kernel.org>
In-Reply-To: <200810082125.58994.bzolnier@gmail.com>
Sender: linux-hotplug-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-hotplug@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

--Boundary-00=_pih7ICy6j97v2Nz
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

Am Mittwoch, 8. Oktober 2008 schrieb Bartlomiej Zolnierkiewicz:
> [ added linux-ide@ to cc: ]
>
> On Saturday 04 October 2008, Thomas Drillich wrote:
> > Am Freitag, 3. Oktober 2008 schrieb Bartlomiej Zolnierkiewicz:
> > > On Wednesday 01 October 2008, Kay Sievers wrote:
> > > > On Wed, Oct 1, 2008 at 1:00 AM, Thomas Drillich <th@drillich.com> 
wrote:
> > > > > I found in the syslog:
> > > > > Sep 30 13:44:44 localhost kernel: ide-tape: hda <-> ht0:
> > > > > HH-@T)SPȴ/�����1*00 DRD)RAM
> > > > > GH22LP20P�{�����л�����HH-@T)SPȴ/�����1*00 rev 1*00
> > > > > Sep 30 13:44:44 localhost kernel: ide-tape: ht0: I/O error, pc =
> > > > > 1a, key =  5, asc = 64, ascq =  0
> > > > > Sep 30 13:44:44 localhost kernel: ide-tape: hda: invalid tape speed
> > > > > (assuming 650KB/sec)
> > > > > Sep 30 13:44:44 localhost kernel: ide-tape: hda: invalid max_speed
> > > > > (assuming 650KB/sec)
> > > > > Sep 30 13:44:44 localhost kernel: ide-tape: ht0: I/O error, pc =
> > > > > 1a, key =  5, asc = 64, ascq =  0
> > > > > Sep 30 13:47:17 localhost kernel: ide-tape: hda <-> ht0:
> > > > > HH-@T)SPȴ/�����1*00 DRD)RAM
> > > > > GH22LP20P�{�����������HH-@T)SPȴ/�����1*00 rev 1*00
> > > > > Sep 30 13:47:17 localhost kernel: ide-tape: ht0: I/O error, pc =
> > > > > 1a, key =  5, asc = 64, ascq =  0
> > > > > Sep 30 13:47:17 localhost kernel: ide-tape: hda: invalid tape speed
> > > > > (assuming 650KB/sec)
> > > > > Sep 30 13:47:17 localhost kernel: ide-tape: hda: invalid max_speed
> > > > > (assuming 650KB/sec)
> > > > > Sep 30 13:47:17 localhost kernel: ide-tape: ht0: I/O error, pc =
> > > > > 1a, key =  5, asc = 64, ascq =  0
> > > > > -- end snip
> > > > >
> > > > > but its a LG GH22LP20 DVD burner
> > > > >
> > > > > cat /sys/bus/ide/devices/0.0/model returns
> > > > >        HL)DP-ST@V@-RAI CH22HP20
> > > > >
> > > > > what can I do ?
> > > >
> > > > Bart, any idea what's going wrong here, or how to work around it?
> > >
> > > ide-tape driving DVD burner is a "CANNOT happen" case...
> > >
> > > Thomas, which kernel version is it?  Please post a full dmesg output.
> >
> > Seems that can happen Bart ;-)
> >
> > it's a 2.6.26.5 kernel running on debian/testing.
> >
> > I moved ide now to module
> >  alim15x3                7504  0 [permanent]
> >  ide_pci_generic         5252  0 [permanent]
> >  ide_core              140572  2 ide_pci_generic,alim15x3
> >
> > but it didn't changed anything .. as expected.
> >
> > >lspci
> >
> >  00:1f.0 IDE interface: ALi Corporation M5229 IDE (rev c7)
> >
> > I added /proc/config.gz to the dmesg output
>
> Linux version 2.6.26.5-3.00-st20g5 (root@mzpc) (gcc version 4.3.1 (Debian
> 4.3.1-9) ) #1 SMP PREEMPT Fri Oct 3 12:42:56 CEST 2008 ...
> ALI15X3: IDE controller (0x10b9:0x5229 rev 0xc7) at  PCI slot 0000:00:1f.0
> ACPI: PCI Interrupt 0000:00:1f.0[A] -> GSI 19 (level, low) -> IRQ 19
> ALI15X3: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0x8880-0x8887
>     ide1: BM-DMA at 0x8888-0x888f
> Probing IDE interface ide0...
> ...
> hda: HL)DP-ST@V@-RAI CH22HP20, ATAPI TAPE drive
> ...
>
> so this is a probing time device type misdectection
> (yeah, the impossible has just happened ;).
>
> Does BIOS also detect this device as "HL)DP-ST@V@-RAI"?
yes
>
> Please send the output of "hdparm --Istdout /dev/hda" so we can check
> whether the problem is a bogus (corrupted?) identify data or some issue
> with the device type detection code...
I'm not able to run hdparam on /dev/hda, udev won't create the device file and
if I create the device file manually hdparam just stop working.

I'd attached cat /proc/ide/hda/identify (hda.identify.txt.gz).

>
> Could you also try 2.6.27-rc9?
no changes in that kernel version .. I attachted output of dmesg of that 
kernel version.

-- 
mit freundlichem Gruss -- regards

Thomas Drillich

--Boundary-00=_pih7ICy6j97v2Nz
Content-Type: application/x-gzip;
  name="dmesg.out.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="dmesg.out.gz"

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

--Boundary-00=_pih7ICy6j97v2Nz
Content-Type: application/x-gzip;
  name="hda.identify.txt.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="hda.identify.txt.gz"

H4sICP4L7kgAA2hkYS5pZGVudGlmeS50eHQA7ZPLDcIwDIbvmcIj+Jmm45RC9x8Bp0KlUCeVOCFE
Dp9s+Xf8UFJoRkA/faSny8htpCjwdp8Q35Kg7CVadAYeVcGQr2BiCoqWk64uK4GOVSdaQFjYMwyr
1akbtPGY47I1xBsQczhvA8OKqhO3hnJEY39nez7khjpCWsJoJl0+qvvX/bLO38sUR6nskF7dprhb
l2Eit/wT56/fyx1HKQk1AAUAAA==

--Boundary-00=_pih7ICy6j97v2Nz--

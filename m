From: Jeremy Huddleston <jeremyhu@uclink4.berkeley.edu>
Subject: Re: Promise PDC20269 - PIO Only?
Date: Mon, 20 Oct 2003 13:15:33 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200310201315.34213.jeremyhu@uclink4.berkeley.edu>
References: <200310181819.08930.jeremyhu@uclink4.berkeley.edu> <200310191603.40227.jeremyhu@uclink4.berkeley.edu> <200310201949.39826.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 12-233-44-179.client.attbi.com ([12.233.44.179]:10179 "EHLO
	terminator.outersquare.org") by vger.kernel.org with ESMTP
	id S262747AbTJTULD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Oct 2003 16:11:03 -0400
In-Reply-To: <200310201949.39826.bzolnier@elka.pw.edu.pl>
Content-Description: clearsigned data
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

/var/log/messages doesn't contain all of the boot log because the kernel's 
buffer is too small.  When syslog-ng starts up, the earliest thing in the log 
buffer is some raid stuff... I need to know how to increase the buffer 
size...  anyone have any ideas?

Oct 20 12:58:21 eradicator syslog-ng[1736]: Changing permissions on special 
file /dev/tty12
Oct 20 12:58:21 eradicator syslog-ng[1736]: syslog-ng version 1.6.0rc3 
starting
Oct 20 12:58:21 eradicator /part6's event counter: 0000015d
Oct 20 12:58:21 eradicator md3: max total readahead window set to 744k
Oct 20 12:58:21 eradicator md3: 3 data-disks, max readahead per data-disk: 
248k
Oct 20 12:58:21 eradicator raid5: device ide/host4/bus1/target0/lun0/part6 
operational as raid disk 3
Oct 20 12:58:21 eradicator raid5: device ide/host4/bus0/target0/lun0/part6 
operational as raid disk 2

I do have the ide-ribbon debug output though since it was after the controller 
initialization output:

Oct 20 12:58:21 eradicator hdc: attached ide-cdrom driver.
Oct 20 12:58:21 eradicator hdc: ATAPI 32X CD-ROM drive, 128kB Cache, UDMA(33)
Oct 20 12:58:21 eradicator Uniform CD-ROM driver Revision: 3.12
Oct 20 12:58:21 eradicator ide2: 80-pin cable, 80-pin cable, 0
Oct 20 12:58:21 eradicator blk: queue c0349538, I/O limit 4095Mb (mask 
0xffffffff)
Oct 20 12:58:21 eradicator ide2: 80-pin cable, 80-pin cable, 0
Oct 20 12:58:21 eradicator ide3: 80-pin cable, 80-pin cable, 0
Oct 20 12:58:21 eradicator blk: queue c0349994, I/O limit 4095Mb (mask 
0xffffffff)
Oct 20 12:58:21 eradicator ide3: 80-pin cable, 80-pin cable, 0
Oct 20 12:58:21 eradicator ide3: 80-pin cable, 80-pin cable, 0
Oct 20 12:58:21 eradicator blk: queue c0349ad4, I/O limit 4095Mb (mask 
0xffffffff)
Oct 20 12:58:21 eradicator ide3: 80-pin cable, 80-pin cable, 0
Oct 20 12:58:21 eradicator ide4: 80-pin cable, 80-pin cable, 0
Oct 20 12:58:21 eradicator blk: queue c0349df0, I/O limit 4095Mb (mask 
0xffffffff)
Oct 20 12:58:21 eradicator ide4: 80-pin cable, 80-pin cable, 0
Oct 20 12:58:21 eradicator ide5: 80-pin cable, 80-pin cable, 0
Oct 20 12:58:21 eradicator blk: queue c034a24c, I/O limit 4095Mb (mask 
0xffffffff)
Oct 20 12:58:21 eradicator ide5: 80-pin cable, 80-pin cable, 0
Oct 20 12:58:21 eradicator PCI: Found IRQ 3 for device 00:0d.0


(12:49:44 Mon Oct 20 2003 root@eradicator)
/usr/src/linux $ grep CONFIG_IDEDMA_PCI_AUTO .config
CONFIG_IDEDMA_PCI_AUTO=y

(13:08:17 Mon Oct 20 2003 root@terminator)
/usr/src/linux $ grep CONFIG_IDEDMA_PCI_AUTO .config
CONFIG_IDEDMA_PCI_AUTO=y

The drives start in DMA mode by default on the other controllers, but not the 
PDC20267 or PDC20269.  The PDC20267 is in a different system than the 
PDC20269.

On Monday October 20 2003 10:49, Bartlomiej Zolnierkiewicz wrote:
> On Monday 20 of October 2003 01:03, Jeremy Huddleston wrote:
> > I have a lot of md output to the kernel logger when my system starts, so
> > the IDE initialization output doesn't appear when I do my initial
> > 'dmesg'... How do I increase the buffer size?  I tried doing 'dmesg -s
> > <really high numbers>', but I still can't get the output...
>
> /var/log/messages ?
>
> > Anyhow, I was trying the -X70 option to force udma6 on my 2.4.20 kernel
> > (which was with the old driver), but when I do the force on 2.4.22-ac4,
> > it works now, so thanks.
> >
> > What is the reason that the drive starts in pio mode when it is attatched
> > to the promise controller, but it starts in DMA mode when it is on the
> > other controller?
>
> Was the other controller on the same machine and with the same kernel?
> If not check if you have CONFIG_IDEDMA_PCI_AUTO set to Y in your .config
> file. Also please try to extract boot log...
>
> thanks,
> --bartlomiej
>
> > Thanks again,
> > Jeremy
> >
> > On Sunday October 19 2003 13:45, you wrote:
> > > Here is a hint.  UDMA2 is a max if you don't use 80-wire cable.
> > > If you can't force mode by "hdparm -X" driver might be misdetecting
> > > cable type.   Please change "#define PDC202_DEBUG_CABLE 0"
> > > to "#define PDC202_DEBUG_CABLE 1" in pdc202_new.c, recompile
> > > and retest.  It should give some useful information.
> > >
> > > thanks,
> > > --bartlomiej
> > >
> > > On Sunday 19 of October 2003 21:01, Willy Gardiol wrote:
> > > > Well, in this case, i cant help more.
> > > > Lets hope some "guru" from this list will give an hint !
> > > >
> > > > Alle Sunday 19 October 2003 21:00, Jeremy Huddleston ha scritto:
> > > > > It's still in mode2 after the explicit -X69 or -X70.  I have a
> > > > > 20267 on my other system, and it goes to mode5 with just the -d1...
> > > > >
> > > > > 11:53:45 Sun Oct 19 2003 root@eradicator)
> > > > > ~ $ hdparm -d1 -X69 /dev/hde
> > > > >
> > > > > /dev/hde:
> > > > >  setting using_dma to 1 (on)
> > > > >  setting xfermode to 69 (UltraDMA mode5)
> > > > >  using_dma    =  1 (on)
> > > > >
> > > > > (11:53:51 Sun Oct 19 2003 root@eradicator)
> > > > > ~ $ hdparm -i /dev/hde
> > > > >
> > > > > /dev/hde:
> > > > >
> > > > >  Model=Maxtor 6Y120P0, FwRev=YAR41VW0, SerialNo=Y40BMM7E
> > > > >  Config={ Fixed }
> > > > >  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
> > > > >  BuffType=DualPortCache, BuffSize=7936kB, MaxMultSect=16,
> > > > > MultSect=off CurCHS=16383/16/63, CurSects=16514064, LBA=yes,
> > > > > LBAsects=240121728 IORDY=on/off, tPIO={min:120,w/IORDY:120},
> > > > > tDMA={min:120,rec:120} PIO modes:  pio0 pio1 pio2 pio3 pio4
> > > > >  DMA modes:  mdma0 mdma1 mdma2
> > > > >  UDMA modes: udma0 udma1 *udma2 udma3 udma4 udma5 udma6
> > > > >  AdvancedPM=yes: disabled (255) WriteCache=enabled
> > > > >  Drive conforms to: (null):
> > > > >
> > > > >  * signifies the current active mode
> > > > >
> > > > > (11:55:38 Sun Oct 19 2003 root@eradicator)
> > > > > ~ $ hdparm -d1 -X70 /dev/hde
> > > > >
> > > > > /dev/hde:
> > > > >  setting using_dma to 1 (on)
> > > > >  setting xfermode to 70 (UltraDMA mode6)
> > > > >  using_dma    =  1 (on)
> > > > >
> > > > > (11:55:44 Sun Oct 19 2003 root@eradicator)
> > > > > ~ $ hdparm -i /dev/hde
> > > > >
> > > > > /dev/hde:
> > > > >
> > > > >  Model=Maxtor 6Y120P0, FwRev=YAR41VW0, SerialNo=Y40BMM7E
> > > > >  Config={ Fixed }
> > > > >  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
> > > > >  BuffType=DualPortCache, BuffSize=7936kB, MaxMultSect=16,
> > > > > MultSect=off CurCHS=16383/16/63, CurSects=16514064, LBA=yes,
> > > > > LBAsects=240121728 IORDY=on/off, tPIO={min:120,w/IORDY:120},
> > > > > tDMA={min:120,rec:120} PIO modes:  pio0 pio1 pio2 pio3 pio4
> > > > >  DMA modes:  mdma0 mdma1 mdma2
> > > > >  UDMA modes: udma0 udma1 *udma2 udma3 udma4 udma5 udma6
> > > > >  AdvancedPM=yes: disabled (255) WriteCache=enabled
> > > > >  Drive conforms to: (null):
> > > > >
> > > > >  * signifies the current active mode
> > > > >
> > > > > On Sunday October 19 2003 02:39, Willy Gardiol wrote:
> > > > > > Ok, you should also set explicitly the dma mode:
> > > > > > hdparm -d1 -X69
> > > > > > (69=udma100...)
> > > > > >
> > > > > > Alle Sunday 19 October 2003 12:11, Jeremy Huddleston ha scritto:
> > > > > > > I have done this, and the result is that it still doesn't use
> > > > > > > the drive to its full potential:
> > > > > > >
> > > > > > > (03:07:19 Sun Oct 19 2003 root@eradicator)
> > > > > > > ~ $ hdparm -d1 /dev/hde
> > > > > > >
> > > > > > > /dev/hde:
> > > > > > >  setting using_dma to 1 (on)
> > > > > > >  using_dma    =  1 (on)
> > > > > > >
> > > > > > > (03:07:25 Sun Oct 19 2003 root@eradicator)
> > > > > > > ~ $ hdparm -i /dev/hde
> > > > > > >
> > > > > > > /dev/hde:
> > > > > > >
> > > > > > >  Model=Maxtor 6Y120P0, FwRev=YAR41VW0, SerialNo=Y40BMM7E
> > > > > > >  Config={ Fixed }
> > > > > > >  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
> > > > > > >  BuffType=DualPortCache, BuffSize=7936kB, MaxMultSect=16,
> > > > > > > MultSect=off CurCHS=16383/16/63, CurSects=16514064, LBA=yes,
> > > > > > > LBAsects=240121728 IORDY=on/off, tPIO={min:120,w/IORDY:120},
> > > > > > > tDMA={min:120,rec:120} PIO modes:  pio0 pio1 pio2 pio3 pio4
> > > > > > >  DMA modes:  mdma0 mdma1 mdma2
> > > > > > >  UDMA modes: udma0 udma1 *udma2 udma3 udma4 udma5 udma6
> > > > > > >  AdvancedPM=yes: disabled (255) WriteCache=enabled
> > > > > > >  Drive conforms to: (null):
> > > > > > >
> > > > > > >  * signifies the current active mode
> > > > > > >
> > > > > > > The PDC-Specific drivers are all compiled into the kernel
> > > > > > >
> > > > > > > On Sunday October 19 2003 00:08, Willy Gardiol wrote:
> > > > > > > > Have you tried to enable uDMA using hdpard after boot?
> > > > > > > > hdparm -d1 /dev/hdX
> > > > > > > >
> > > > > > > > There are also some options in kernel configurations which
> > > > > > > > addresses when you have more than one promise comtrollers,
> > > > > > > > have you tried them? Last, also in the ide section of kernel
> > > > > > > > config you can find an option which should enable by default
> > > > > > > > UDMA, have you enabled it?
> > > > > > > >
> > > > > > > > bye!
> > > > > > > >
> > > > > > > > Alle Sunday 19 October 2003 03:19, Jeremy Huddleston ha 
scritto:
> > > > > > > > > Hi,
> > > > > > > > >
> > > > > > > > > I've been using two Promise PDC20269 cards for almost a
> > > > > > > > > year now in my system. The cards are U133, but when the
> > > > > > > > > kernel boots up, I see the message that all the drives are
> > > > > > > > > operating in pio mode. All the drives are U133 drives, and
> > > > > > > > > they are shown as operating in DMA mode when I put them on
> > > > > > > > > another controller.
> > > > > > > > >
> > > > > > > > > I've noticed this deficiency with vanilla linux-2.4.19
> > > > > > > > > through linux-2.4.21, linux-2.4.22-ac4 as well as
> > > > > > > > > 2.6.0-test6-mm4...
> > > > > > > > >
> > > > > > > > > Is there a patch to the 2.4 kernels availible to enable
> > > > > > > > > this support? Is this problem being addressed?  Is there
> > > > > > > > > any way I can help out?
> > > > > > > > >
> > > > > > > > > Thanks,
> > > > > > > > > Jeremy
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/lEJmgKpk8srJOlIRAtlgAJwJRCxe/ZcJLRo6g3vVXd467a9TswCcDPaj
ZFZ/k7aA+2P2XDbp0hUOxe0=
=Gdox
-----END PGP SIGNATURE-----

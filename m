From: Dark Sylinc <dark_sylinc@yahoo.com.ar>
Subject: SATA Shutdown issue confuses (sda)
Date: Tue, 27 Nov 2007 17:08:38 -0300 (ART)
Message-ID: <318018.27274.qm@web56310.mail.re3.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web56310.mail.re3.yahoo.com ([216.252.110.234]:31787 "HELO
	web56310.mail.re3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754888AbXK0UPS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 15:15:18 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,
I have compiled my own 2.6.23 kernel for a friend, and
worried to find out that his SATA disk reports the
shutdown warning: http://linux-ata.org/shutdown.html

I've digged into Debian's sysvinit 2.86.1 src and I
got confused:

1) Like Scott James Remnant, Ubuntu's Development
Manager
(http://www.mail-archive.com/linux-ide@vger.kernel.org/msg06595.html)
said, in Debian (actually he referred to Ubuntu, but
looking at the code they make the same thing) shutdown
iterates through all /dev/hd* files and shuts them
down. So, if I'm right, sda (the node file for my
friend's PC) is leaved untouch. Why is the warning
appearing then? It is supposed that SATA drives not
using the /dev/hd* convention shouldn't be stopped by
shutdown.

2) The kernel Flushes cache and puts in stand-by-now
since 2.6.22 This can cause (if it was already
stopped) the disk to spin up and then down. So....
anyway the disk should spun down propperly before
power down, it might be done twice, but none of them
would be an emergency shut down. I think I'm missing
something... or otherwise there is no problem at all

3) What's the proposed solution after all??? Shutdown
should flush cache AND stop the SATA? or shutdown
shouldn't do anything?
You seem to be in favor of "not doing anything" but
I'm also concerned that Kernel's prior to 2.6.22 would
be negative affected by this solution.

4) What everyone in forums is asking... are they SATA
drives being forced from long time ago, and they have
just found out by using the new kernel? That remains
unclear.

5) At least on my friend's SATA, the "clack" sounds
like 2 or 3 seconds before power downs, but it sounds
slightly (and really slightly) different to the
Window's shutdown "clack". Does this means that his
drive is safe? Or is it possible for software to power
down just the HDD without stopping the heads???

5b)I've compiled the kernel without the "Asynchronous
SCSI scanning" flag (SCSI_SCAN_ASYNC). Does it have
something to do that the kernel seems to be waiting
for the SCSI to stop before powering down?

6) If I'm not mistaken, in hdddown.c (debian's
sysvinit code
http://packages.debian.org/etch/sysvinit) in line 67
we should change
static int do_standby_idedisk(char *device)
{
#ifndef WIN_STANDBYNOW1
#define WIN_STANDBYNOW1 0xE0
#endif
#ifndef WIN_STANDBYNOW2
#define WIN_STANDBYNOW2 0x94
#endif
	unsigned char args1[4] =3D {WIN_STANDBYNOW1,0,0,0};
	unsigned char args2[4] =3D {WIN_STANDBYNOW2,0,0,0};
	int fd;

	if ((fd =3D open(device, O_RDWR)) < 0)
		return -1;

	if (ioctl(fd, HDIO_DRIVE_CMD, &args1) &&
	    ioctl(fd, HDIO_DRIVE_CMD, &args2))
		return -1;

	return 0;
}

By:

static int do_standby_idedisk(char *device)
{
#ifndef WIN_STANDBYNOW1
#define WIN_STANDBYNOW1 0xE0
#endif
#ifndef WIN_STANDBYNOW2
#define WIN_STANDBYNOW2 0x94
#endif
#ifndef WIN_FLUSHCACHE
#define WIN_FLUSHCACHE 0xE7
#endif
	unsigned char args0[4] =3D {WIN_FLUSHCACHE,0,0,0};
	unsigned char args1[4] =3D {WIN_STANDBYNOW1,0,0,0};
	unsigned char args2[4] =3D {WIN_STANDBYNOW2,0,0,0};
	int fd;

	if ((fd =3D open(device, O_RDWR)) < 0)
		return -1;

	if (ioctl(fd, HDIO_DRIVE_CMD, &args0) &&
	    ioctl(fd, HDIO_DRIVE_CMD, &args1) &&
	    ioctl(fd, HDIO_DRIVE_CMD, &args2))
		return -1;

	return 0;
}

Right?
Am I missing something?

This email is long but I take HDD potential issues
very seriously.

Thanks
Dark Sylinc

PS: I'm not a distro mantainer. But I'm concerned
about my friend's SATA, and if we can get to a
solution, I would be glad to report the patch to the
Debian Community


      Los referentes m=E1s importantes en compra/ venta de autos se jun=
taron:
Demotores y Yahoo!
Ahora comprar o vender tu auto es m=E1s f=E1cil. Vist=E1 ar.autos.yahoo=
=2Ecom/

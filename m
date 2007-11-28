From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA Shutdown issue confuses (sda)
Date: Wed, 28 Nov 2007 12:07:17 +0900
Message-ID: <474CDB65.9050700@gmail.com>
References: <318018.27274.qm@web56310.mail.re3.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hu-out-0506.google.com ([72.14.214.233]:44025 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106AbXK1DHl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 22:07:41 -0500
Received: by hu-out-0506.google.com with SMTP id 19so1447714hue
        for <linux-ide@vger.kernel.org>; Tue, 27 Nov 2007 19:07:39 -0800 (PST)
In-Reply-To: <318018.27274.qm@web56310.mail.re3.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dark Sylinc <dark_sylinc@yahoo.com.ar>
Cc: linux-ide@vger.kernel.org, hmh@debian.org

[cc'ing Henrique.]

Hello,

Dark Sylinc wrote:
> 1) Like Scott James Remnant, Ubuntu's Development
> Manager
> (http://www.mail-archive.com/linux-ide@vger.kernel.org/msg06595.html)
> said, in Debian (actually he referred to Ubuntu, but
> looking at the code they make the same thing) shutdown
> iterates through all /dev/hd* files and shuts them
> down. So, if I'm right, sda (the node file for my
> friend's PC) is leaved untouch. Why is the warning
> appearing then? It is supposed that SATA drives not
> using the /dev/hd* convention shouldn't be stopped by
> shutdown.

Don't have any debian around but apparently it's issuing spin down for
/dev/sdX's too.

> 2) The kernel Flushes cache and puts in stand-by-now
> since 2.6.22 This can cause (if it was already
> stopped) the disk to spin up and then down. So....
> anyway the disk should spun down propperly before
> power down, it might be done twice, but none of them
> would be an emergency shut down. I think I'm missing
> something... or otherwise there is no problem at all

Well, double spin-down doesn't sound too good and as introducing double
spin down would be a kernel regression kernel doesn't issue spin-down if
it's already spun down.  This is usually okay but some rare drives spin
up on FLUSH_CACHE even if the cache is empty which leads to emergency
spin down.  The warning message is for such cases.

> 3) What's the proposed solution after all??? Shutdown
> should flush cache AND stop the SATA? or shutdown
> shouldn't do anything?
> You seem to be in favor of "not doing anything" but
> I'm also concerned that Kernel's prior to 2.6.22 would
> be negative affected by this solution.

Shutdown doesn't need to do anything for later kernels.  For older ones,
it should continue to issue FLUSH_CACHE and STANDBYNOW1.  The presence
of manage_start_stop sysfs node can be used to tell which action to take.

> 4) What everyone in forums is asking... are they SATA
> drives being forced from long time ago, and they have
> just found out by using the new kernel? That remains
> unclear.

I don't really get the question here.  Can you please elaborate?

> 5) At least on my friend's SATA, the "clack" sounds
> like 2 or 3 seconds before power downs, but it sounds
> slightly (and really slightly) different to the
> Window's shutdown "clack". Does this means that his
> drive is safe? Or is it possible for software to power
> down just the HDD without stopping the heads???

Sure way to tell is to look at emergency unload count int the output of
'smartctl -a'.  Basically, it should identical to 'hdparm -y'.

> 5b)I've compiled the kernel without the "Asynchronous
> SCSI scanning" flag (SCSI_SCAN_ASYNC). Does it have
> something to do that the kernel seems to be waiting
> for the SCSI to stop before powering down?

Nope.

> 6) If I'm not mistaken, in hdddown.c (debian's
> sysvinit code
> http://packages.debian.org/etch/sysvinit) in line 67
> we should change
> static int do_standby_idedisk(char *device)
> {
> #ifndef WIN_STANDBYNOW1
> #define WIN_STANDBYNOW1 0xE0
> #endif
> #ifndef WIN_STANDBYNOW2
> #define WIN_STANDBYNOW2 0x94
> #endif
> 	unsigned char args1[4] = {WIN_STANDBYNOW1,0,0,0};
> 	unsigned char args2[4] = {WIN_STANDBYNOW2,0,0,0};
> 	int fd;
> 
> 	if ((fd = open(device, O_RDWR)) < 0)
> 		return -1;
> 
> 	if (ioctl(fd, HDIO_DRIVE_CMD, &args1) &&
> 	    ioctl(fd, HDIO_DRIVE_CMD, &args2))
> 		return -1;
> 
> 	return 0;
> }
> 
> By:
> 
> static int do_standby_idedisk(char *device)
> {
> #ifndef WIN_STANDBYNOW1
> #define WIN_STANDBYNOW1 0xE0
> #endif
> #ifndef WIN_STANDBYNOW2
> #define WIN_STANDBYNOW2 0x94
> #endif
> #ifndef WIN_FLUSHCACHE
> #define WIN_FLUSHCACHE 0xE7
> #endif
> 	unsigned char args0[4] = {WIN_FLUSHCACHE,0,0,0};
> 	unsigned char args1[4] = {WIN_STANDBYNOW1,0,0,0};
> 	unsigned char args2[4] = {WIN_STANDBYNOW2,0,0,0};
> 	int fd;
> 
> 	if ((fd = open(device, O_RDWR)) < 0)
> 		return -1;
> 
> 	if (ioctl(fd, HDIO_DRIVE_CMD, &args0) &&
> 	    ioctl(fd, HDIO_DRIVE_CMD, &args1) &&
> 	    ioctl(fd, HDIO_DRIVE_CMD, &args2))
> 		return -1;
> 
> 	return 0;
> }

Opcode 0x94 is retired now and it's probably not too good a idea to
issue it to modern disks.  0xE0 should be good enough and yes you
definitely need to issue FLUSH before spinning down the disk.

The code needs to be a tad bit more complex.  It needs to check
manage_start_stop presence and skip any action if it's there.

> PS: I'm not a distro mantainer. But I'm concerned
> about my friend's SATA, and if we can get to a
> solution, I would be glad to report the patch to the
> Debian Community

ISTR this was resolved somehow and somebody was about to write how to
deal with this for debian.  Henrique, do you recall anything?  Did I
drop the ball again?

Thanks.

-- 
tejun

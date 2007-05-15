From: Daniel Drake <dsd@gentoo.org>
Subject: Fixing halt/shutdown for libata spindown handling
Date: Mon, 14 May 2007 23:29:53 -0400
Message-ID: <46492931.4080700@gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010503040109080909050502"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp121.iad.emailsrvr.com ([207.97.245.121]:44969 "EHLO
	smtp121.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754457AbXEODlL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 May 2007 23:41:11 -0400
Received: from [192.168.1.102] (c-24-34-179-5.hsd1.ma.comcast.net [24.34.179.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: ddrake@brontes3d.com)
	by relay2.r2.iad.emailsrvr.com (SMTP Server) with ESMTP id D7B59450B83
	for <linux-ide@vger.kernel.org>; Mon, 14 May 2007 23:30:54 -0400 (EDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------010503040109080909050502
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I just took a quick look into modifying halt to work as suggested for 
the new libata spindown code.

Here's how it works in Gentoo at the moment: /sbin/halt is called 
typically with the "-d -p -i -h" arguments. After doing some 
halt-specific things (such as spinning down disks per the -h argument), 
halt calls /sbin/shutdown which presumably finishes the task. This is 
with sysvinit-2.86

So, I was expecting to jump into the halt source code, find the "-h" 
argument parsing, and see code for it spinning down all the disks.

I was surprised to find that the /sbin/halt spin down implementation is 
very limited, it only works for IDE disks (by working through 
/proc/ide). This doesn't make sense to me, the libata commits state that 
userspace shutdown is spinning down libata disks.

So, this means that other distro's do it differently? I'd appreciate 
some pointers to what happens elsewhere.

I have attached the code from sysvinit which spins down the disks. It's 
not modified by the patches below.

Gentoo uses sysvinit from here:
ftp://sunsite.unc.edu/pub/Linux/system/daemons/init/sysvinit-2.86.tar.gz

Patched with:
http://sources.gentoo.org/viewcvs.py/*checkout*/gentoo-x86/sys-apps/sysvinit/files/sysvinit-2.86-docs.patch
http://sources.gentoo.org/viewcvs.py/*checkout*/gentoo-x86/sys-apps/sysvinit/files/sysvinit-2.86-shutdown-usage.patch
http://sources.gentoo.org/viewcvs.py/*checkout*/gentoo-x86/sys-apps/sysvinit/files/sysvinit-2.86-off-by-one.patch
http://distfiles.gentoo.org/distfiles/sysvinit-2.86-kexec.patch
http://sources.gentoo.org/viewcvs.py/*checkout*/gentoo-x86/sys-apps/sysvinit/files/sysvinit-2.86-execl.patch
http://sources.gentoo.org/viewcvs.py/*checkout*/gentoo-x86/sys-apps/sysvinit/files/sysvinit-2.86-utmp-64bit.patch
http://sources.gentoo.org/viewcvs.py/*checkout*/gentoo-x86/sys-apps/sysvinit/files/sysvinit-2.86-shutdown-single.patch

If I'm right and Gentoo is currently not spinning down SCSI/libata 
disks, the only /sbin/halt modification required is to write 0 into
/sys/modules/libata/parameters/spindown_compat right?

Final question: should spindown_compat be set to 0 for both shutdown and 
reboot, or just shutdown?

Thanks,
Daniel

--------------010503040109080909050502
Content-Type: text/x-csrc;
 name="hddown.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hddown.c"

/*
 * hddown.c	Find all disks on the system and
 *		shut them down.
 *
 */
char *v_hddown = "@(#)hddown.c  1.02  22-Apr-2003  miquels@cistron.nl";

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>
#include <string.h>
#include <fcntl.h>
#include <dirent.h>

#ifdef __linux__

#include <sys/ioctl.h>
#include <linux/hdreg.h>

#define MAX_DISKS	64
#define PROC_IDE	"/proc/ide"
#define DEV_BASE	"/dev"

/*
 *	Find all IDE disks through /proc.
 */
static int find_idedisks(char **dev, int maxdev)
{
	DIR *dd;
	FILE *fp;
	struct dirent *d;
	char buf[256];
	int i = 0;

	if ((dd = opendir(PROC_IDE)) == NULL)
		return -1;

	while ((d = readdir(dd)) != NULL) {
		if (strncmp(d->d_name, "hd", 2) != 0)
			continue;
		buf[0] = 0;
		snprintf(buf, sizeof(buf), PROC_IDE "/%s/media", d->d_name);
		if ((fp = fopen(buf, "r")) == NULL)
			continue;
		if (fgets(buf, sizeof(buf), fp) == 0 ||
		    strcmp(buf, "disk\n") != 0) {
			fclose(fp);
			continue;
		}
		fclose(fp);
		snprintf(buf, sizeof(buf), DEV_BASE "/%s", d->d_name);
		dev[i++] = strdup(buf);
		if (i >= maxdev)
			break;
	}
	closedir(dd);
	if (i < maxdev) dev[i] = NULL;

	return 0;
}

/*
 *	Put an IDE disk in standby mode.
 *	Code stolen from hdparm.c
 */
static int do_standby_idedisk(char *device)
{
#ifndef WIN_STANDBYNOW1
#define WIN_STANDBYNOW1 0xE0
#endif
#ifndef WIN_STANDBYNOW2
#define WIN_STANDBYNOW2 0x94
#endif
	unsigned char args1[4] = {WIN_STANDBYNOW1,0,0,0};
	unsigned char args2[4] = {WIN_STANDBYNOW2,0,0,0};
	int fd;

	if ((fd = open(device, O_RDWR)) < 0)
		return -1;

	if (ioctl(fd, HDIO_DRIVE_CMD, &args1) &&
	    ioctl(fd, HDIO_DRIVE_CMD, &args2))
		return -1;

	return 0;
}

/*
 *	First find all IDE disks, then put them in standby mode.
 *	This has the side-effect of flushing the writecache,
 *	which is exactly what we want on poweroff.
 */
int hddown(void)
{
	char *disks[MAX_DISKS+1];
	int i;

	if (find_idedisks(disks, MAX_DISKS) < 0)
		return -1;

	for (i = 0; disks[i] && i < MAX_DISKS; i++)
		do_standby_idedisk(disks[i]);

	return 0;
}

#else /* __linux__ */

int hddown(void)
{
	return 0;
}

#endif /* __linux__ */

#ifdef STANDALONE
int main(int argc, char **argv)
{
	return (hddown() == 0);
}
#endif


--------------010503040109080909050502--

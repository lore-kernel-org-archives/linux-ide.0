From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: to /sys from /proc/ide/hd$v/identify
Date: 07 Jun 2004 15:58:57 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1086645537.3137.103.camel@patibmrh9>
References: <1086616121.3649.0.camel@patibmrh9> <40C4739C.6070508@pobox.com>
	<4D5B0986-B8BB-11D8-AE55-00039398BB5E@ieee.org><200406072154.33609.bzolnier
	@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out2.iomega.com ([147.178.1.83]:35742 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S265083AbUFGV7I
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 7 Jun 2004 17:59:08 -0400
In-Reply-To: <200406072154.33609.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

> > > - /proc/ide/ interfaces are obsolete
> > ...
> > Where do I now find the ATA op xEC/A1 "IDENTIFY" data that was
> > /proc/ide/hd$v/identify ?
> ...
> Since IDE supports taskfile ioctl,
> you shouldn't need this in sysfs...
> ...
> > Forget about the ! CONFIG_IDE_TASK_IOCTL
> > kernels, and then for the remaining kernels
> > persuade Google to teach you ioctl  
> > HDIO_DRIVE_TASKFILE.
> > ...
> > > There is also HDIO_GET_IDENTITY

Thanks for that ATA pass thru hint, I pursued it as follows.

ioctl HDIO_GET_IDENTITY maybe works here for my PATA /dev/hda and PATAPI
/dev/hdc, though not yet for my SATAPI /dev/scd0.

The bits of HDIO_GET_IDENTITY differ from those of
/proc/ide/hd$v/identify.  /proc was byte-swapping text and substituting
x20 SPACE for x00 NUL, or vice versa.

$ sudo cat /proc/ide/hdc/identify | x2c | hexdump -C >1
$ sudo ~/bin/ataid /dev/hdc | hexdump -C >2
$ diff 1 2
2,6c2,6
< 00000010  00 00 00 00 20 20 20 20  20 20 20 20 20 20 20 20  |....            |
< 00000020  20 20 20 20 20 20 20 20  00 00 00 00 00 00 4b 48  |        ......KH|
< 00000030  30 4b 20 20 20 20 4c 49  54 45 2d 4f 4e 20 43 4f  |0K    LITE-ON CO|
< 00000040  4d 42 4f 20 4c 54 43 2d  34 38 31 36 31 48 20 20  |MBO LTC-48161H  |
< 00000050  20 20 20 20 20 20 20 20  20 20 20 20 20 20 00 00  |              ..|
---
> 00000010  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> 00000020  00 00 00 00 00 00 00 00  00 00 00 00 00 00 48 4b  |..............HK|
> 00000030  4b 30 00 00 00 00 49 4c  45 54 4f 2d 20 4e 4f 43  |K0....ILETO- NOC|
> 00000040  42 4d 20 4f 54 4c 2d 43  38 34 36 31 48 31 00 00  |BM OTL-C8461H1..|
> 00000050  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
$

Pat LaVarre

-----

There is no
http://marc.theaimsgroup.com/?l=linux-ide&s=HDIO_GET_IDENTITY

man -K HDIO_GET_IDENTITY
here yields only: man 2 ioctl_list

http://www.google.com/search?q=man+HDIO_GET_IDENTITY
suggests:
ioctl(int d, HDIO_GET_IDENTITY, struct hd_driveid *hd) 

http://groups.google.com/groups?q=ioctl+HDIO_GET_IDENTITY
suggests essentially the following code, root privilege required.

------ ataid.c

#include <fcntl.h>
#include <linux/hdreg.h>
#include <stdio.h>
#include <sys/ioctl.h>

static struct hd_driveid hddi;

int main(int argc, char* argv[])
{
	--argc; ++argv;
	if (0 < argc) {
		int fd = open(argv[0], O_NONBLOCK);
		if (0 <= fd) {
			int ii = ioctl(fd,HDIO_GET_IDENTITY, &hddi);
			if (ii == 0) {
				FILE * fi = stdout;
#if 0
				if (fwrite(&hddi, sizeof hddi, 1, fi) == 1) {
					return 0;
				}
#else
				unsigned char * uchars = (char *) &hddi;
				int ix = 0;
				for (ix = 0; ix < (int) sizeof hddi; ix += 2) {
					fputc(uchars[ix + 1], fi);
					fputc(uchars[ix + 0], fi);
				}
				return 0;
#endif
			}
		}
	}
	fprintf(stderr, "not\n");
	return -1;
}



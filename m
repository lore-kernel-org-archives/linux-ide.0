From: Matthew Stapleton <matthew4196@gmail.com>
Subject: Re: ICH7m problem using libata
Date: Thu, 18 Jan 2007 12:13:52 +1000
Message-ID: <200701181213.52934.matthew4196@gmail.com>
References: <1165253799.16504.37.camel@laundromat.jangutter.com> <1169040316.16103.18.camel@laundromat.jangutter.com> <45AE278F.5060004@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_gftrF4R/Li+we0/"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.250]:24384 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901AbXARCOA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Jan 2007 21:14:00 -0500
Received: by an-out-0708.google.com with SMTP id b33so34397ana
        for <linux-ide@vger.kernel.org>; Wed, 17 Jan 2007 18:14:00 -0800 (PST)
In-Reply-To: <45AE278F.5060004@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jan Gutter <jangutter@gmail.com>, linux-ide@vger.kernel.org

--Boundary-00=_gftrF4R/Li+we0/
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Tejun Heo wrote:
> Quite some number of ODDs don't seem to like the way hald polls them.  I
> don't think other apps will be affected by this.  I dunno much about
> hald and don't have enough time to chase it down myself but feel free to
> cc me when reporting this to hald people.  I'll try to help as much as I
> can.
> 
> Thanks.
> 
> -- 
> tejun
> 

I've attached the test programs that I wrote about earlier.  cdstatus.c causes 
a timeout after a few hours but cdstatus_working.c doesn't seem to get a 
timeout.  The timeout always occurs during open.

-- 
Matthew Stapleton

--Boundary-00=_gftrF4R/Li+we0/
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="cdstatus.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cdstatus.c"

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <stdio.h>
#include <unistd.h>
#include <linux/cdrom.h>

int main(void) {
	int fd, capabilities, drive;
	char *cddrive = "/dev/cdrom";

	while (1) {
		printf("Opening %s\n", cddrive);
		fd = open (cddrive, O_RDONLY | O_NONBLOCK);
		if (fd < 0) {
			printf("Error\n");
			return 1;
		}
		printf("Sleeping\n");
		sleep(1);
		printf("Closing %s\n", cddrive);
		close(fd);
		printf("Sleeping\n");
		sleep(1);
	}
	return 0;
}


--Boundary-00=_gftrF4R/Li+we0/
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="cdstatus_working.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cdstatus_working.c"

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <stdio.h>
#include <unistd.h>
#include <linux/cdrom.h>

int main(void) {
	int fd, capabilities, drive;
	char *cddrive = "/dev/cdrom";

	printf("Opening %s\n", cddrive);
	fd = open (cddrive, O_RDONLY | O_NONBLOCK);
	if (fd < 0) {
		printf("Error\n");
		return 1;
	}
	while (1) {
		ioctl (fd, CDROM_SET_OPTIONS, CDO_USE_FFLAGS);
		capabilities = ioctl (fd, CDROM_GET_CAPABILITY, 0);
		drive = ioctl (fd, CDROM_DRIVE_STATUS, CDSL_CURRENT);
		printf("capabilities=0x%08X, drive=0x%08X\n", capabilities, drive);
		sleep(1);
	}
	close(fd);
	return 0;
}


--Boundary-00=_gftrF4R/Li+we0/--

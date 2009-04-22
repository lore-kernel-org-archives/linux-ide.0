From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/2] ide: Stop disks on reboot for laptop which cuts power
Date: Wed, 22 Apr 2009 20:28:33 +0200
Message-ID: <200904222028.33337.bzolnier@gmail.com>
References: <20090418124415.1dc82273@neptune.home> <20090418124558.0426f74c@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <20090418124558.0426f74c@neptune.home>
Content-Disposition: inline
Sender: linux-scsi-owner@vger.kernel.org
To: Bruno =?utf-8?q?Pr=C3=A9mont?= <bonbons@linux-vserver.org>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux SCSI <linux-scsi@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Saturday 18 April 2009 12:45:58 Bruno Pr=C3=A9mont wrote:
> My laptop (Acer Travelmate 660) always cuts the power when rebooting
> which causes the disk to emergency-park it's head.
>=20
> Add a dmi check to stop disk as for shutdown on this laptop.
>=20
> Signed-off-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>

applied
--
To unsubscribe from this list: send the line "unsubscribe linux-scsi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

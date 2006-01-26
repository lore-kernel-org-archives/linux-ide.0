From: David Greaves <david@dgreaves.com>
Subject: Re: regarding bug #5914 - fs corruption on SATA
Date: Thu, 26 Jan 2006 16:41:33 +0000
Message-ID: <43D8FBBD.6070205@dgreaves.com>
References: <20060126055050.GA4737@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from s2.ukfsn.org ([217.158.120.143]:49577 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S964810AbWAZQle (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jan 2006 11:41:34 -0500
In-Reply-To: <20060126055050.GA4737@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Nicolas.Mailhot@LaPoste.net, Jeff Garzik <jgarzik@pobox.com>, Jens Axboe <axboe@suse.de>, Linux-ide <linux-ide@vger.kernel.org>, Christopher Smith <csmith@nighthawkrad.net>, Erik Slagter <erik@slagter.name>, hahn@physics.mcmaster.ca, mlaks@verizon.net, Soeren Sonnenburg <kernel@nn7.de>, mlaks@verizononline.net

Have  you guys seen the parallel threads (in linux-ide and linux-raid)
that have been reporting very similar problems for a few days now.

Have a look for subjects such as
  Problems with multiple Promise SATA150 TX4 cards
  Possible libata/sata/Asus problem (was Re: Need to upgrade to latest
stable mdadm version?)

=46or me, please see:

http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D113769509617034&w=3D=
2


David
PS I'm using XFS on md5 and md1
PPS Buying a new =A360+ PSU didn't fix my problem - <sigh>


Tejun Heo wrote:

>Hello, Nicolas.  Hello, all.
>
>Nicolas, I'm probably the guy who broke your filesystem.  :-p This FUA
>(forced-unit-access)thing made into the mainline lately, and it seems
>that your drive is reporting FUA support but doesn't really do it
>properly when it's asked to.
>
>Can you try the followings to verify the problem?
>
>1. make a small partition on the affected drive and do mkfs.ext3 on it=
=2E
>2. mount -o barrier new_partition /mnt/tmp
>3. cd /mnt/tmp; touch asdf; sync
>
>This should give something like the following.
>
>=3D=3D=3D=3D=3D=3D
>ata2: port reset, p_is 40000001 is 2 pis 0 cmd 44017 tf 451 ss 123 se =
0
>ata2: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
>ata2: status=3D0x51 { DriveReady SeekComplete Error }
>ata2: error=3D0x04 { DriveStatusError }
>ata2: port reset, p_is 40000001 is 2 pis 0 cmd 44017 tf 451 ss 123 se =
0
>ata2: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
>ata2: status=3D0x51 { DriveReady SeekComplete Error }
>ata2: error=3D0x04 { DriveStatusError }
>ata2: port reset, p_is 40000001 is 2 pis 0 cmd 44017 tf 451 ss 123 se =
0
>ata2: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
>ata2: status=3D0x51 { DriveReady SeekComplete Error }
>ata2: error=3D0x04 { DriveStatusError }
>ata2: port reset, p_is 40000001 is 2 pis 0 cmd 44017 tf 451 ss 123 se =
0
>ata2: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
>ata2: status=3D0x51 { DriveReady SeekComplete Error }
>ata2: error=3D0x04 { DriveStatusError }
>ata2: port reset, p_is 40000001 is 2 pis 0 cmd 44017 tf 451 ss 123 se =
0
>ata2: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
>ata2: status=3D0x51 { DriveReady SeekComplete Error }
>ata2: error=3D0x04 { DriveStatusError }
>sd 2:0:0:0: SCSI error: return code =3D 0x8000002
>sdc: Current: sense key: Aborted Command
>    Additional sense: No additional sense information
>end_request: I/O error, dev sdc, sector 4359
>Buffer I/O error on device sdc1, logical block 537
>lost page write due to I/O error on sdc1
>Aborting journal on device sdc1.
>journal commit I/O error
>=3D=3D=3D=3D=3D=3D
>
>The ext3 fs will back off and won't use any barrier from this point.
>
>If this is what you see, please apply the patch at the end of this
>mail, which makes libata issue non-FUA commmands even if FUA commands
>are asked for.  After recompiling repeat above, create some files,
>unmount, mount, verify stuff, unmount and fsck...  All should succeed
>without any complaint from the kernel.
>
>If my guess turns out to be true, we'll need a blacklist for those
>lying drives.  Damn it.
>
>diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
>index 46c4cdb..6ba6ad2 100644
>--- a/drivers/scsi/libata-core.c
>+++ b/drivers/scsi/libata-core.c
>@@ -565,7 +565,7 @@ static const u8 ata_rw_cmds[] =3D {
> 	0,
> 	0,
> 	0,
>-	ATA_CMD_WRITE_MULTI_FUA_EXT,
>+	ATA_CMD_WRITE_MULTI_EXT,
> 	/* pio */
> 	ATA_CMD_PIO_READ,
> 	ATA_CMD_PIO_WRITE,
>@@ -583,7 +583,7 @@ static const u8 ata_rw_cmds[] =3D {
> 	0,
> 	0,
> 	0,
>-	ATA_CMD_WRITE_FUA_EXT
>+	ATA_CMD_WRITE_EXT
> };
>=20
> /**
>-
>To unsubscribe from this list: send the line "unsubscribe linux-ide" i=
n
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> =20
>


--=20


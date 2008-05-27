From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 14/40] ide-floppy: merge idefloppy_transfer_pc() and
	idefloppy_transfer_pc1()
Date: Tue, 27 May 2008 07:37:37 +0200
Message-ID: <20080527053737.GA19760@gollum.tnic>
References: <20080518185428.5636.77234.sendpatchset@localhost.localdomain> <20080518185633.5636.61364.sendpatchset@localhost.localdomain> <20080521052429.GA2414@gollum.tnic> <200805272057.42444.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:11638 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752992AbYE0Fhm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 May 2008 01:37:42 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1448428fgg.17
        for <linux-ide@vger.kernel.org>; Mon, 26 May 2008 22:37:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200805272057.42444.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, May 27, 2008 at 08:57:42PM +0200, Bartlomiej Zolnierkiewicz wro=
te:
> On Wednesday 21 May 2008, Borislav Petkov wrote:
> > On Sun, May 18, 2008 at 08:56:33PM +0200, Bartlomiej Zolnierkiewicz=
 wrote:
> > > * Check IDEFLOPPY_FLAG_ZIP_DRIVE flag in idefloppy_transfer_pc1()
> > >   and skip idefloppy_transfer_pc2()-phase if the flag is not set.
> > >=20
> > > * Always use idefloppy_transfer_pc1() in idefloppy_issue_pc()
> > >   and remove no longer needed idefloppy_transfer_pc().
> >=20
> > ... and also probably mv idefloppy_transfer_pc1() to something like
> > idefloppy_start_transfer_pc() and rename idefloppy_transfer_pc2() t=
o something
> > more appropriate like e.g. idefloppy_do_transfer_pc() or similar an=
d do away
> > with those misleading names and probably even the comments are supe=
rfluous then.
>=20
> Probably the most intuitive would be to do:
>=20
> 	idefloppy_transfer_pc1() -> idefloppy_transfer_pc()
>=20
> and
>=20
> 	idefloppy_transfer_pc2() -> idefloppy_do_transfer_pc()
>=20
> but I don't feel too strong about it and welcome other ideas
> (preferably in form of patches :).

^Hint^! :) Sure, what about the following:
--

=46rom: Borislav Petkov <petkovbb@gmail.com>
Date: Tue, 27 May 2008 07:31:37 +0200
Subject: [PATCH] ide-floppy: fix unfortunate function naming

mv idefloppy_transfer_pc1 idefloppy_start_pc_transfer
mv idefloppy_transfer_pc2 idefloppy_transfer_pc

which describes their functionality and disambiguates them. There shoul=
d be no
functionality change introduced by this patch.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-floppy.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index 0f3602a..b368943 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -399,12 +399,8 @@ static ide_startstop_t idefloppy_pc_intr(ide_drive=
_t *drive)
  * service routine. In interrupt mode, the device sends an interrupt t=
o signal
  * that it is ready to receive a packet. However, we need to delay abo=
ut 2-3
  * ticks before issuing the packet or we gets in trouble.
- *
- * So, follow carefully. transfer_pc1 is called as an interrupt (or di=
rectly).
- * In either case, when the device says it's ready for a packet, we sc=
hedule
- * the packet transfer to occur about 2-3 ticks later in transfer_pc2.
  */
-static int idefloppy_transfer_pc2(ide_drive_t *drive)
+static int idefloppy_transfer_pc(ide_drive_t *drive)
 {
 	idefloppy_floppy_t *floppy =3D drive->driver_data;
=20
@@ -415,7 +411,13 @@ static int idefloppy_transfer_pc2(ide_drive_t *dri=
ve)
 	return IDEFLOPPY_WAIT_CMD;
 }
=20
-static ide_startstop_t idefloppy_transfer_pc1(ide_drive_t *drive)
+
+/*
+ * Called as an interrupt (or directly). When the device says it's rea=
dy for a
+ * packet, we schedule the packet transfer to occur about 2-3 ticks la=
ter in
+ * transfer_pc.
+ */
+static ide_startstop_t idefloppy_start_pc_transfer(ide_drive_t *drive)
 {
 	idefloppy_floppy_t *floppy =3D drive->driver_data;
 	struct ide_atapi_pc *pc =3D floppy->pc;
@@ -432,7 +434,7 @@ static ide_startstop_t idefloppy_transfer_pc1(ide_d=
rive_t *drive)
 	 */
 	if (pc->flags & PC_FLAG_ZIP_DRIVE) {
 		timeout =3D floppy->ticks;
-		expiry =3D &idefloppy_transfer_pc2;
+		expiry =3D &idefloppy_transfer_pc;
 	} else {
 		timeout =3D IDEFLOPPY_WAIT_CMD;
 		expiry =3D NULL;
@@ -483,7 +485,7 @@ static ide_startstop_t idefloppy_issue_pc(ide_drive=
_t *drive,
=20
 	pc->retries++;
=20
-	return ide_issue_pc(drive, pc, idefloppy_transfer_pc1,
+	return ide_issue_pc(drive, pc, idefloppy_start_pc_transfer,
 			    IDEFLOPPY_WAIT_CMD, NULL);
 }
=20
--=20
1.5.5.1

--=20
Regards/Gru=DF,
    Boris.

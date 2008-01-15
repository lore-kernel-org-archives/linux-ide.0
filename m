From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: Re: [PATCH 10/12] ide-floppy: remove atomic test_*bit macros
Date: Tue, 15 Jan 2008 21:09:21 +0100
Message-ID: <20080115200921.GA5699@gollum.tnic>
References: <1200255505-31418-1-git-send-email-bbpetkov@yahoo.de> <1200255505-31418-11-git-send-email-bbpetkov@yahoo.de> <200801142250.58201.bzolnier@gmail.com> <200801142332.58341.bzolnier@gmail.com>
Reply-To: bbpetkov@yahoo.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp111.plus.mail.re1.yahoo.com ([69.147.102.74]:45229 "HELO
	smtp111.plus.mail.re1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751839AbYAOUND (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Jan 2008 15:13:03 -0500
Content-Disposition: inline
In-Reply-To: <200801142332.58341.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Mon, Jan 14, 2008 at 11:32:58PM +0100, Bartlomiej Zolnierkiewicz wro=
te:
> On Monday 14 January 2008, Bartlomiej Zolnierkiewicz wrote:
> > On Sunday 13 January 2008, Borislav Petkov wrote:
> > > ..and replace them with flag enums.
> > >=20
> > > Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>
>=20
> small update:
>=20
> PC_ABORT is never set and may as well be removed in a pre-patch

Here you go, the one below should be pushed first...

--
=46rom: Borislav Petkov <bbpetkov@yahoo.de>
Date: Tue, 15 Jan 2008 20:34:50 +0100
Subject: ide-floppy: remove unused flag PC_ABORT

This flag was never being set in the code so remove it. By the way, the
code in the second patch was being executed unconditionally, i.e. in ca=
se
pc->retries > IDEFLOPPY_MAX_PC_RETRIES is true (actually that is the on=
ly case
when the outer if-test passed), !test_bit(PC_ABORT, &pc->flags)
was always true so the comment is now incorrect and has to go.

Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>

diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index 790e33f..8e9063f 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -110,7 +110,6 @@ typedef struct idefloppy_packet_command_s {
 /*
  *	Packet command flag bits.
  */
-#define	PC_ABORT			0	/* Set when an error is considered normal - We wo=
n't retry */
 #define PC_DMA_RECOMMENDED		2	/* 1 when we prefer to use DMA if possib=
le */
 #define	PC_DMA_IN_PROGRESS		3	/* 1 while DMA in progress */
 #define	PC_DMA_ERROR			4	/* 1 when encountered problem during DMA */
@@ -737,18 +736,12 @@ static ide_startstop_t idefloppy_issue_pc (ide_dr=
ive_t *drive, idefloppy_pc_t *p
 	/* Set the current packet command */
 	floppy->pc =3D pc;
=20
-	if (pc->retries > IDEFLOPPY_MAX_PC_RETRIES ||
-	    test_bit(PC_ABORT, &pc->flags)) {
-		/*
-		 *	We will "abort" retrying a packet command in case
-		 *	a legitimate error code was received.
-		 */
-		if (!test_bit(PC_ABORT, &pc->flags)) {
-			if (!test_bit(PC_SUPPRESS_ERROR, &pc->flags))
-				ide_floppy_report_error(floppy, pc);
-			/* Giving up */
-			pc->error =3D IDEFLOPPY_ERROR_GENERAL;
-		}
+	if (pc->retries > IDEFLOPPY_MAX_PC_RETRIES) {
+		if (!test_bit(PC_SUPPRESS_ERROR, &pc->flags))
+			ide_floppy_report_error(floppy, pc);
+		/* Giving up */
+		pc->error =3D IDEFLOPPY_ERROR_GENERAL;
+
 		floppy->failed_pc =3D NULL;
 		pc->callback(drive);
 		return ide_stopped;
--=20
1.5.3.7


--=20
Regards/Gru=DF,
    Boris.

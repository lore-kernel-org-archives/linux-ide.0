From: Stuart Hayes <Stuart_Hayes@dell.com>
Subject: Re: [PATCH] (for ide-tape.c in 2.4.22-ac4) ide-tape.c doesn't work
 with Seagate Trav
Date: Thu, 23 Oct 2003 13:59:12 -0500 (CDT)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0310231347310.4639-100000@humbolt.us.dell.com>
References: <200310230015.56791.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp3.us.dell.com ([143.166.148.134]:6669 "EHLO
	smtp3.us.dell.com") by vger.kernel.org with ESMTP id S261664AbTJWS7b
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Oct 2003 14:59:31 -0400
In-Reply-To: <200310230015.56791.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org

On Wed, 22 Oct 2003, Bartlomiej Zolnierkiewicz wrote:

>=20
> Patch looks really good, only some minor issues.
>=20
> > @@ -316,6 +316,27 @@
> >=A0=A0 * Ver 1.17c Sep 2003=A0=A0=A0=A0=A0=A0=A0 Stuart Hayes <stuar=
t_hayes@dell.com>
> >=A0=A0 *=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 Initializ=
ed "feature" in
> idetape_issue_packet_command
> >=A0=A0 *=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0 (this =
was causing lockups on certain systems)
> > + * Ver 1.18=A0 Sep 2003=A0=A0=A0=A0=A0=A0=A0 Stuart Hayes <stuart_=
hayes@dell.com>
> > + *=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 Check drive's=
 write protect bit, try to return
> appropriate
> > + *=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0 errors wh=
en attempting to write a
> write-protected tape
> > + *=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 Moved "idetap=
e_read_position" call in
> idetape_chrdev_open
> > + *=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0 after the=
 "wait_ready" call
> > + *=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 Added IDETAPE=
_MEDIUM_PRESENT flag so driver would
> know
> > + *=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0 not to re=
wind tape after ejecting it
> > + *=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 Fixed bug wit=
h ide_abort_pipeline (it was
> deleting stages
> > + *=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0 from tape=
->next_stage to end, instead of from
> > + *=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0 new_last_=
stage->next (tape->next_stage was set
> to NULL
> > + *=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0 by idetap=
e_discard_read_pipeline before
> calling!)
> > + *=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 Deleted "idet=
ape_do_end_request"--this was just a
> copy of
> > + *=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0 ide_end_r=
equest
> > + *=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 Made improvem=
ents to idetape_wait_ready
> > + *=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 Added a few c=
omments here and there
> > + *=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 Made MTOFFL u=
nlock tape drive door before
> attempting to eject
> > + *=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 Added fixes t=
o get Seagate STT3401A Travan
> working:
> > + *=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0 handle dr=
ives that don't support 0-length
> reads/writes
> > + *=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0 increased=
 timeout (retension takes ~10 minutes
> before
> > + *=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0 irq=
 is returned)
> > + *=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0 fixed req=
uest mode page packet command byte 3
> >=A0=A0 *
> >=A0=A0 * Here are some words from the first releases of hd.c, which =
are
> quoted
> >=A0=A0 * in ide.c and apply here as well:
>=20
> Please make this a patch comment,
> so when it is merged into -bk we have patch+changelog.
>=20
> > @@ -4230,7 +4267,7 @@
> >=A0 =A0=A0=A0=A0 idetape_tape_t *tape =3D drive->driver_data;
> >=A0 =A0=A0=A0=A0 unsigned long flags;
> >=A0 =A0=A0=A0=A0 int cnt =3D 0, x, position;
> > -
> > +
> >=A0 =A0=A0=A0=A0 /*
> >=A0 =A0=A0=A0=A0=A0 * Search and wait for the next logical tape bloc=
k
> >=A0 =A0=A0=A0=A0=A0 */
>=20
> no need for extra tab
>=20
> > @@ -5388,6 +5434,8 @@
> >=A0 =A0=A0=A0=A0 }
> >=A0 =A0=A0=A0=A0 switch (mt_op) {
> >=A0 =A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 case MTWEOF:
> > +=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 if (tape-=
>drv_write_prot)
> > +=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=
=A0=A0=A0=A0 return (-EACCES);
> >=A0 =A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 idetape=
_discard_read_pipeline(drive, 1);
> >=A0 =A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 for (i =
=3D 0; i < mt_count; i++) {
> >=A0 =A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=
=A0=A0=A0=A0 retval =3D idetape_write_filemark(drive);
>=20
> return -EACCES;
>=20
> > @@ -6322,6 +6408,9 @@
> >=A0 =A0=A0=A0=A0 tape->max_insert_speed =3D 10000;
> >=A0 =A0=A0=A0=A0 tape->speed_control =3D 1;
> >=A0 =A0=A0=A0=A0 *((unsigned short *) &gcw) =3D drive->id->config;
> > +=A0=A0=A0=A0 /* For now, assume drive supports read/writes of 0 le=
ngth */
> > +=A0=A0=A0=A0 set_bit(IDETAPE_READ_0_SUPPORTED,&tape->flags);
> > +=A0=A0=A0=A0 set_bit(IDETAPE_WRITE_0_SUPPORTED,&tape->flags);
> >=A0 =A0=A0=A0=A0 if (gcw.drq_type =3D=3D 1)
> >=A0 =A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 set_bit(IDETAPE_DRQ_INTERRUPT=
, &tape->flags);
>=20
> If my analysis is correct the only possibility of issuing READ or WRI=
TE
> with
> length 0 is when switching from DSC handshake from completion mode to
> buffer
> available mode and these cases are now covered by drive->dsc_overlap
> check.
>=20
> I guess Travan doesn't support DSC, so IDETAPE_{READ, WRITE}_0_SUPPOR=
TED
> flags
> can be removed unless you know about another tape drive which errors =
on
> zero
> length READ/WRITE commands (we should leave comments about Travan of
> course).
>=20
>=20
> Stuart, could you also forward-port these chances to 2.6.x and test t=
hem?
> I don't have any ide-tape drive.
>=20
> thanks,
> --bartlomiej
>=20
>=20
>=20

Right now the dsc_overlap flag isn't set for this (or any) drive--it's=20
only set for a couple of controllers that don't support DSC at all.  I=20
thought it would be better to fail gracefully (and not try 0-length rea=
ds=20
or writes anymore) if the drive can't handle them, rather than to just =
clear=20
dsc_overlap for a particular drive.  If you don't agree I can change=20
that to get rid of the flags.

I can do this for 2.6, too, but it may be a few days before I get a cha=
nce=20
to do so.



From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] (for ide-tape.c in 2.4.22-ac4) ide-tape.c doesn't work with Seagate Trav
Date: Thu, 23 Oct 2003 22:43:30 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200310232243.30564.bzolnier@elka.pw.edu.pl>
References: <Pine.LNX.4.44.0310231347310.4639-100000@humbolt.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:1723 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261784AbTJWUj5
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Oct 2003 16:39:57 -0400
In-Reply-To: <Pine.LNX.4.44.0310231347310.4639-100000@humbolt.us.dell.com>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Stuart Hayes <Stuart_Hayes@dell.com>
Cc: linux-ide@vger.kernel.org

On Thursday 23 of October 2003 20:59, Stuart Hayes wrote:
> On Wed, 22 Oct 2003, Bartlomiej Zolnierkiewicz wrote:
> > Patch looks really good, only some minor issues.
> >
> > > @@ -316,6 +316,27 @@
> > >   * Ver 1.17c Sep 2003        Stuart Hayes <stuart_hayes@dell.com>
> > >   *                   Initialized "feature" in
> >
> > idetape_issue_packet_command
> >
> > >   *                    (this was causing lockups on certain systems)
> > > + * Ver 1.18  Sep 2003        Stuart Hayes <stuart_hayes@dell.com>
> > > + *                   Check drive's write protect bit, try to return
> >
> > appropriate
> >
> > > + *                     errors when attempting to write a
> >
> > write-protected tape
> >
> > > + *                   Moved "idetape_read_position" call in
> >
> > idetape_chrdev_open
> >
> > > + *                     after the "wait_ready" call
> > > + *                   Added IDETAPE_MEDIUM_PRESENT flag so driver would
> >
> > know
> >
> > > + *                     not to rewind tape after ejecting it
> > > + *                   Fixed bug with ide_abort_pipeline (it was
> >
> > deleting stages
> >
> > > + *                     from tape->next_stage to end, instead of from
> > > + *                     new_last_stage->next (tape->next_stage was set
> >
> > to NULL
> >
> > > + *                     by idetape_discard_read_pipeline before
> >
> > calling!)
> >
> > > + *                   Deleted "idetape_do_end_request"--this was just a
> >
> > copy of
> >
> > > + *                     ide_end_request
> > > + *                   Made improvements to idetape_wait_ready
> > > + *                   Added a few comments here and there
> > > + *                   Made MTOFFL unlock tape drive door before
> >
> > attempting to eject
> >
> > > + *                   Added fixes to get Seagate STT3401A Travan
> >
> > working:
> > > + *                     handle drives that don't support 0-length
> >
> > reads/writes
> >
> > > + *                     increased timeout (retension takes ~10 minutes
> >
> > before
> >
> > > + *                       irq is returned)
> > > + *                     fixed request mode page packet command byte 3
> > >   *
> > >   * Here are some words from the first releases of hd.c, which are
> >
> > quoted
> >
> > >   * in ide.c and apply here as well:
> >
> > Please make this a patch comment,
> > so when it is merged into -bk we have patch+changelog.
> >
> > > @@ -4230,7 +4267,7 @@
> > >       idetape_tape_t *tape = drive->driver_data;
> > >       unsigned long flags;
> > >       int cnt = 0, x, position;
> > > -
> > > +
> > >       /*
> > >        * Search and wait for the next logical tape block
> > >        */
> >
> > no need for extra tab
> >
> > > @@ -5388,6 +5434,8 @@
> > >       }
> > >       switch (mt_op) {
> > >               case MTWEOF:
> > > +                     if (tape->drv_write_prot)
> > > +                             return (-EACCES);
> > >                       idetape_discard_read_pipeline(drive, 1);
> > >                       for (i = 0; i < mt_count; i++) {
> > >                               retval = idetape_write_filemark(drive);
> >
> > return -EACCES;
> >
> > > @@ -6322,6 +6408,9 @@
> > >       tape->max_insert_speed = 10000;
> > >       tape->speed_control = 1;
> > >       *((unsigned short *) &gcw) = drive->id->config;
> > > +     /* For now, assume drive supports read/writes of 0 length */
> > > +     set_bit(IDETAPE_READ_0_SUPPORTED,&tape->flags);
> > > +     set_bit(IDETAPE_WRITE_0_SUPPORTED,&tape->flags);
> > >       if (gcw.drq_type == 1)
> > >               set_bit(IDETAPE_DRQ_INTERRUPT, &tape->flags);
> >
> > If my analysis is correct the only possibility of issuing READ or WRITE
> > with
> > length 0 is when switching from DSC handshake from completion mode to
> > buffer
> > available mode and these cases are now covered by drive->dsc_overlap
> > check.
> >
> > I guess Travan doesn't support DSC, so IDETAPE_{READ, WRITE}_0_SUPPORTED
> > flags
> > can be removed unless you know about another tape drive which errors on
> > zero
> > length READ/WRITE commands (we should leave comments about Travan of
> > course).
> >
> >
> > Stuart, could you also forward-port these chances to 2.6.x and test them?
> > I don't have any ide-tape drive.
> >
> > thanks,
> > --bartlomiej
>
> Right now the dsc_overlap flag isn't set for this (or any) drive--it's
> only set for a couple of controllers that don't support DSC at all.  I

I've just checked idetape_setup() and it's quite opposite,
drive->dsc_overlap is set for every drive, except if drive is on
controller which is known not to support DSC.

> thought it would be better to fail gracefully (and not try 0-length reads
> or writes anymore) if the drive can't handle them, rather than to just
> clear dsc_overlap for a particular drive.  If you don't agree I can change
> that to get rid of the flags.

If drive->dsc_overlap flag is not set there is no possibility of issuing
0-length read/write.  I think that sufficient fix for now is not to set
drive->dsc_overlap for this particular drive.  However we should leave
comment in a driver about this problem (0-length reads/writes) and solution,
so if in future somebody decides to change driver interworkings, she/he won't
break support for Travan.

> I can do this for 2.6, too, but it may be a few days before I get a chance
> to do so.

Great.

thanks,
--bartlomiej


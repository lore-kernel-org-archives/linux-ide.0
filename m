From: Shawn Starr <shawn.starr@rogers.com>
Subject: Re: [PATCH][2.6.12-rc4][SATA] sil driver - Blacklist Maxtor disk
Date: Fri, 27 May 2005 00:09:33 -0400
Message-ID: <200505270009.33853.shawn.starr@rogers.com>
References: <20050524162710.55401.qmail@web88008.mail.re2.yahoo.com> <311601c9050526210119abb8d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp104.rog.mail.re2.yahoo.com ([206.190.36.82]:10078 "HELO
	smtp104.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261847AbVE0EJo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 27 May 2005 00:09:44 -0400
In-Reply-To: <311601c9050526210119abb8d8@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Eric D. Mudama" <edmudama@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jgarzik@pobox.com

Any way i can get you the bus trace? the box Im using is 
'disposable' (reinstallable)

On May 27, 2005 00:01, Eric D. Mudama wrote:

> I don't believe that drive is vulnerable to the traditionally
> described SI issue, as it's based on  Marvell bridge IP.  If that
> drive was vulnerable, so would be the drives of more than one other
> large vendor.  I would bet something else is actually the root cause,
> and by using smaller transfers or something you're just hiding the
> race condition, not fixing a root cause.
>
> (obviously i'd love to see a bus trace of the hang in action, but not
> everyone can swap their cars for bus analyzers...)
>
> --eric
>
> On 5/24/05, Shawn Starr <shawn.starr@rogers.com> wrote:
> > Yes, I know we shouldn't do this, but at the current
> > time, this seems to fix DMA READ/WRITE timeout
> > problems. This also may fix the sata_nv driver as
> > well, but this seems indicate that there is a lowlevel
> > problem with the SATA subsystem.
> >
> > Signed-off-by: Shawn Starr <shawn.starr@rogers.com>
> >
> > --- sata_sil.c.old      2005-05-24 12:19:20.312197269
> > -0400
> > +++ sata_sil.c  2005-05-11 14:05:26.000000000 -0400
> > @@ -93,6 +93,7 @@ struct sil_drivelist {
> >         { "ST380011ASL",        SIL_QUIRK_MOD15WRITE
> > },
> >         { "ST3120022ASL",       SIL_QUIRK_MOD15WRITE
> > },
> >         { "ST3160021ASL",       SIL_QUIRK_MOD15WRITE
> > },
> > +       { "Maxtor 6Y080M0",     SIL_QUIRK_MOD15WRITE
> > },
> >         { "Maxtor 4D060H3",     SIL_QUIRK_UDMA5MAX },
> >         { }
> >  };
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

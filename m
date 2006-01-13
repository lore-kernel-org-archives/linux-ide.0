From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: ide-cd turning off DMA when verifying DVD-R
Date: Fri, 13 Jan 2006 15:16:51 +0100
Message-ID: <58cb370e0601130616l25e0e25ai6b7d2025d9774eff@mail.gmail.com>
References: <5ujmU-1UQ-665@gated-at.bofh.it> <5uoqr-Qq-7@gated-at.bofh.it>
	 <43C72F41.5060207@shaw.ca> <20060113083009.GE12338@paradise.net.nz>
	 <58cb370e0601130119g5c62b749r1bc5da59a0d4a56c@mail.gmail.com>
	 <20060113140618.GB12360@tigershaunt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1422695AbWAMOX7@vger.kernel.org>
In-Reply-To: <20060113140618.GB12360@tigershaunt.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Rashkae <rashkae@tigershaunt.com>
Cc: =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>, Ondrej Zary <linux@rainbow-software.org>, Robert Hancock <hancockr@shaw.ca>, Volker Kuhlmann <list0570@paradise.net.nz>, Jens Axboe <axboe@suse.de>, linux-ide <linux-ide@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On 1/13/06, Rashkae <rashkae@tigershaunt.com> wrote:
> On Fri, Jan 13, 2006 at 10:19:17AM +0100, Bartlomiej Zolnierkiewicz w=
rote:
>
>
> > On 1/13/06, Volker Kuhlmann <list0570@paradise.net.nz> wrote:
> > > On Fri 13 Jan 2006 17:40:33 NZDT +1300, Robert Hancock wrote:
> > >
> > > > I'm thinking the IDE code is too aggressive in assuming that th=
e failure
> > > >  is because of a DMA problem and disabling it.. Most likely all=
 that's
> > > > happening is the drive is taking a long time to complete the cu=
rrent
> > > > command.
> >
> > What actually happened is that normal command timed out
> > and because of that driver reset the device which caused
> > it to loose DMA:
> >
> > ->ide_atapi_error()
> >     ->ide_do_reset()
> >       ->pre_reset()
> >         ->check_dma_crc()
> >           ->__ide_dma_off()
> >
> > Somebody needs to investigate why __ide_dma_off() is called
> > et all and if we need to restore DMA after reset (don't count ATM
> > on me, I'm buried by bugreports).  Ondrej, could you fill the bug a=
t
> > http://bugzilla.kernel.org so we don't lose it?
>
> Shouldn't whether DMA is restored after reset be governed by keepsett=
ings flag?

settings should always be preserved and keepsettings flag should die

> From the hdparm man page:
>
>       -k     Get/set  the  keep_settings_over_reset flag for the
>               drive.  When this flag is set, the driver will pre=AD
>               serve  the -dmu options over a soft reset, (as done
>               during the error  recovery  sequence).
>
> I was a little disapointed that this didn't work as advertised.

AFAIR (2.5/2.6 and probably 2.4 also) it never worked w.r.t. to DMA
as documented in hdparm manual.

Bartlomiej

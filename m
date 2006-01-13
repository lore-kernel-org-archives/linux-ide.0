From: Rashkae <rashkae@tigershaunt.com>
Subject: Re: ide-cd turning off DMA when verifying DVD-R
Date: Fri, 13 Jan 2006 09:06:18 -0500
Message-ID: <20060113140618.GB12360@tigershaunt.com>
References: <5ujmU-1UQ-665@gated-at.bofh.it> <5uoqr-Qq-7@gated-at.bofh.it> <43C72F41.5060207@shaw.ca> <20060113083009.GE12338@paradise.net.nz> <58cb370e0601130119g5c62b749r1bc5da59a0d4a56c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from CPE0050fc332afc-CM00407b861c34.cpe.net.cable.rogers.com ([69.197.25.155]:26259
	"EHLO nuku.localdomain") by vger.kernel.org with ESMTP
	id S1422679AbWAMOGM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Jan 2006 09:06:12 -0500
Received: from rashkae by nuku.localdomain with local (Exim 4.24)
	id 1ExPZK-0003NQ-Bz
	for linux-ide@vger.kernel.org; Fri, 13 Jan 2006 09:06:18 -0500
Content-Disposition: inline
In-Reply-To: <58cb370e0601130119g5c62b749r1bc5da59a0d4a56c@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Fri, Jan 13, 2006 at 10:19:17AM +0100, Bartlomiej Zolnierkiewicz wro=
te:


> On 1/13/06, Volker Kuhlmann <list0570@paradise.net.nz> wrote:
> > On Fri 13 Jan 2006 17:40:33 NZDT +1300, Robert Hancock wrote:
> >
> > > I'm thinking the IDE code is too aggressive in assuming that the =
failure
> > >  is because of a DMA problem and disabling it.. Most likely all t=
hat's
> > > happening is the drive is taking a long time to complete the curr=
ent
> > > command.
>=20
> What actually happened is that normal command timed out
> and because of that driver reset the device which caused
> it to loose DMA:
>=20
> ->ide_atapi_error()
>     ->ide_do_reset()
>       ->pre_reset()
>         ->check_dma_crc()
>           ->__ide_dma_off()
>=20
> Somebody needs to investigate why __ide_dma_off() is called
> et all and if we need to restore DMA after reset (don't count ATM
> on me, I'm buried by bugreports).  Ondrej, could you fill the bug at
> http://bugzilla.kernel.org so we don't lose it?

Shouldn't whether DMA is restored after reset be governed by keepsettin=
gs flag?

=46rom the hdparm man page:

      -k     Get/set  the  keep_settings_over_reset flag for the
              drive.  When this flag is set, the driver will pre=AD
              serve  the -dmu options over a soft reset, (as done
              during the error  recovery  sequence).

I was a little disapointed that this didn't work as advertised.

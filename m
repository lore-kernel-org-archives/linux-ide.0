From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 00/86] PATA fixes
Date: Thu, 3 Dec 2009 22:42:05 +0100
Message-ID: <200912032242.05785.bzolnier@gmail.com>
References: <20091125170218.5446.13513.sendpatchset@localhost> <200912032045.48728.bzolnier@gmail.com> <4B182A9F.5090708@garzik.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754824AbZLCVnY@vger.kernel.org>
In-Reply-To: <4B182A9F.5090708@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thursday 03 December 2009 10:16:15 pm Jeff Garzik wrote:

> >        pata_efar: MWDMA0 is unsupported
> 
> skipped, pending discussion (just sent email)

The discussion was there, you were not especially interested
(http://lkml.org/lkml/2009/11/26/343).

> >        pata_hpt3x2n: fix overclocked MWDMA0 timing
> 
> skipped, pending discussion (just sent email)

ditto (http://lkml.org/lkml/2009/11/27/257).

There were no complains so I'm pretty sure Sergei was fine with it.

> >        pata_hpt3x3: Power Management fix
> 
> applied, on a hope and a prayer (did not see this posted to mailing 
> list?).  It looks correct to me.

I prefer sticking to technical facts. ;)

Patch was posted to both mailing lists: http://lkml.org/lkml/2009/11/25/321

> >        pata_via: clear UDMA transfer mode bit for PIO and MWDMA
> 
> applied -- even though Alan's comment was correct.  It is standard 
> kernel practice to place cosmetic changes into their own patches, 
> because it is standard kernel practice to break up logically distinct 
> changes.

We are talking about:

 pata_via.c |   19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

patch here (http://lkml.org/lkml/2009/11/25/380) and cosmetic change
is clearly documented in the patch description.


Do people really wonder why I find upstream to be too much hassle to
deal with?

--
Bartlomiej Zolnierkiewicz

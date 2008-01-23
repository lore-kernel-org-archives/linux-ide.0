From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ppc: fix #ifdef-s in mediabay driver
Date: Wed, 23 Jan 2008 01:58:41 +0100
Message-ID: <200801230158.42017.bzolnier@gmail.com>
References: <200801230012.38516.bzolnier@gmail.com>
	<1201046394.6807.49.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <1201046394.6807.49.camel@pasglop>
Content-Disposition: inline
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: benh@kernel.crashing.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: linux-ide@vger.kernel.org


Hi,

On Wednesday 23 January 2008, Benjamin Herrenschmidt wrote:
> 
> On Wed, 2008-01-23 at 00:12 +0100, Bartlomiej Zolnierkiewicz wrote:
> > * Replace incorrect CONFIG_BLK_DEV_IDE #ifdef in
> >   check_media_bay() by CONFIG_MAC_FLOPPY one.
> > 
> > * Replace incorrect CONFIG_BLK_DEV_IDE #ifdef-s by
> >   CONFIG_BLK_DEV_IDE_PMAC ones.
> > 
> > * check_media_bay() is used only by drivers/block/swim3.c
> >   so make this function available only if CONFIG_MAC_FLOPPY
> >   is defined.
> > 
> > * check_media_bay_by_base() and media_bay_set_ide_infos()
> >   are used only by drivers/ide/ppc/pmac.c so so make these
> >   functions available only if CONFIG_MAC_FLOPPY is defined.
> > 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > ---
> > Ben, IMO this patch is safe for 2.6.24 (assuming that it builds fine :),
> > otherwise I would like to ask for permission to merge it through IDE
> > tree since I have other pending IDE patches depending on this one.
> 
> I'd rather avoid touching 2.6.24 unless it actually fixes a bug or
> regression...

Well, it is a bugfix for PMAC_MEDIABAY=y && BLK_DEV_IDE=n && MAC_FLOPPY=y. :)

> I'm tempted to actually remove all ifdef's ... if you have a media-bay,
> then there are about 99% chances it contains an IDE device, with the
> remaining percent being split with putting a floppy or a battery in. I
> doubt anybody will care building a kernel without the support for these
> and with the mediabay support, and still want to save a handful of bytes
> in that driver.

I'm more worried about breaking automatic build checking (make randconfig)
than a few extra bytes so if you remove all #ifdefs you'll have to either
make BLK_DEV_IDE_PMAC select PMAC_MEDIABAY or make PMAC_MEDIABAY depend
on BLK_DEV_IDE_PMAC (otherwise BLK_DEV_IDE=n && PMAC_MEDIABAY=y will fail
since mediabay.c is referencing IDE code).

Thanks,
Bart

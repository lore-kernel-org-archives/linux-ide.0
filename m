From: "Tobias Oed" <tobiasoed@hotmail.com>
Subject: Re: [2.6 patch] always enable CONFIG_PDC202XX_FORCE
Date: Mon, 03 Apr 2006 20:10:46 -0400
Message-ID: <BAY105-F31FF2F6DBC43E2A09B7EBEA3CA0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bay105-f31.bay105.hotmail.com ([65.54.224.41]:61711 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S964898AbWDDAKw
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Apr 2006 20:10:52 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: tobiasoed@hotmail.com, bzolnier@gmail.com

> > On 3/27/06, Sergei Shtylylov <sshtylyov@ru.mvista.com> wrote:
> > Hello.
> >
> > Adrian Bunk wrote:
> >
> > > This patch removes the CONFIG_PDC202XX_FORCE=n case.
> >
> > > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> >
> > > ---
> > >
> > > This patch was already sent on:
> > > - 14 Jan 2006
> > >
> > >  drivers/ide/Kconfig            |    7 -------
> > >  drivers/ide/pci/pdc202xx_new.c |    6 ------
> > >  drivers/ide/pci/pdc202xx_old.c |   15 ---------------
> > >  3 files changed, 28 deletions(-)
> >
> > [skipped]
> >
> > > --- linux-2.6.15-mm4-full/drivers/ide/pci/pdc202xx_old.c.old  
>2006-01-14 20:44:01.000000000 +0100
> > > +++ linux-2.6.15-mm4-full/drivers/ide/pci/pdc202xx_old.c      
>2006-01-14 20:44:21.000000000 +0100
> > > @@ -786,9 +786,6 @@
> > >               .init_dma       = init_dma_pdc202xx,
> > >               .channels       = 2,
> > >               .autodma        = AUTODMA,
> > > -#ifndef CONFIG_PDC202XX_FORCE
> > > -             .enablebits     = {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
> > > -#endif
> > >               .bootable       = OFF_BOARD,
> > >               .extra          = 16,
> > >       },{     /* 1 */
> > > @@ -799,9 +796,6 @@
> > >               .init_dma       = init_dma_pdc202xx,
> > >               .channels       = 2,
> > >               .autodma        = AUTODMA,
> > > -#ifndef CONFIG_PDC202XX_FORCE
> > > -             .enablebits     = {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
> > > -#endif
> > >               .bootable       = OFF_BOARD,
> > >               .extra          = 48,
> > >               .flags          = IDEPCI_FLAG_FORCE_PDC,
> >
> >     A late question: wasn't that IDEPCI_FLAG_FORCE_PDC flag there for 
>the same
> > purpose -- to bypass enablebits check? Wasn't it enough?
>
>It was for the same purpose but it wasn't enough,
>now this flag can die...
>
>Bartlomiej

Here is a patch to remove the IDEPCI_FLAG_FORCE_PDC flag. Lightly tested 
with
my onboard pdc20265.
Tobias.

Signed-off-by: Tobias Oed <tobiasoed@hotmail.com>

diff -r -u linux-2.6.16.orig/drivers/ide/pci/pdc202xx_old.c 
linux-2.6.16.clean/drivers/ide/pci/pdc202xx_old.c
--- linux-2.6.16.orig/drivers/ide/pci/pdc202xx_old.c    2006-03-20 
06:53:29.000000000 +0100
+++ linux-2.6.16.clean/drivers/ide/pci/pdc202xx_old.c   2006-04-04 
01:29:19.000000000 +0200
@@ -798,7 +798,6 @@
                .autodma        = AUTODMA,
                .bootable       = OFF_BOARD,
                .extra          = 48,
-               .flags          = IDEPCI_FLAG_FORCE_PDC,
        },{     /* 2 */
                .name           = "PDC20263",
                .init_setup     = init_setup_pdc202ata4,
@@ -819,7 +818,6 @@
                .autodma        = AUTODMA,
                .bootable       = OFF_BOARD,
                .extra          = 48,
-               .flags          = IDEPCI_FLAG_FORCE_PDC,
        },{     /* 4 */
                .name           = "PDC20267",
                .init_setup     = init_setup_pdc202xx,
diff -r -u linux-2.6.16.orig/drivers/ide/setup-pci.c 
linux-2.6.16.clean/drivers/ide/setup-pci.c
--- linux-2.6.16.orig/drivers/ide/setup-pci.c   2006-03-20 
06:53:29.000000000 +0100
+++ linux-2.6.16.clean/drivers/ide/setup-pci.c  2006-04-04 
01:33:11.000000000 +0200
@@ -580,7 +580,6 @@
        int port;
        int at_least_one_hwif_enabled = 0;
        ide_hwif_t *hwif, *mate = NULL;
-       static int secondpdc = 0;
        u8 tmp;

        index->all = 0xf0f0;
@@ -591,22 +590,10 @@

        for (port = 0; port <= 1; ++port) {
                ide_pci_enablebit_t *e = &(d->enablebits[port]);
-
-               /*
-                * If this is a Promise FakeRaid controller,
-                * the 2nd controller will be marked as
-                * disabled while it is actually there and enabled
-                * by the bios for raid purposes.
-                * Skip the normal "is it enabled" test for those.
-                */
-               if ((d->flags & IDEPCI_FLAG_FORCE_PDC) &&
-                   (secondpdc++==1) && (port==1))
-                       goto controller_ok;

                if (e->reg && (pci_read_config_byte(dev, e->reg, &tmp) ||
                    (tmp & e->mask) != e->val))
                        continue;       /* port not enabled */
-controller_ok:

                if (d->channels <= port)
                        break;
diff -r -u linux-2.6.16.orig/include/linux/ide.h 
linux-2.6.16.clean/include/linux/ide.h
--- linux-2.6.16.orig/include/linux/ide.h       2006-03-20 
06:53:29.000000000 +0100
+++ linux-2.6.16.clean/include/linux/ide.h      2006-04-04 
01:29:31.000000000 +0200
@@ -1219,7 +1219,6 @@
enum {
        /* Uses ISA control ports not PCI ones. */
        IDEPCI_FLAG_ISA_PORTS           = (1 << 0),
-       IDEPCI_FLAG_FORCE_PDC           = (1 << 1),
};

typedef struct ide_pci_device_s {

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today - it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/


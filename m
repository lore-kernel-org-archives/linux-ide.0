From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] via82cxxx IDE: Support multiple controllers
Date: Tue, 27 Sep 2005 15:20:53 +0200
Message-ID: <58cb370e050927062049be32f8@mail.gmail.com>
References: <43146CC3.4010005@gentoo.org>
	 <58cb370e05083008121f2eb783@mail.gmail.com>
	 <43179CC9.8090608@gentoo.org>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.204]:24019 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964927AbVI0NUy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Sep 2005 09:20:54 -0400
Received: by nproxy.gmail.com with SMTP id x37so421335nfc
        for <linux-ide@vger.kernel.org>; Tue, 27 Sep 2005 06:20:53 -0700 (PDT)
In-Reply-To: <43179CC9.8090608@gentoo.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Drake <dsd@gentoo.org>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, posting@blx4.net, vsu@altlinux.ru

On 9/2/05, Daniel Drake <dsd@gentoo.org> wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > Same thing as with VT6420 support:
> >
> > I'm still concerned about VIA IDE chipset + VT6410 combo
> > (AFAIR I've also seen VT6410 on PCI add-on card but I can be wrong).
> >
> > via82cxxx.c needs to be fixed to support multiple controllers first.
>
> Hows this? I don't have any hardware with two VIA controllers, however I have
> tested this on a pc which has a single vt8233a controller.
>
> ---
>
> Support multiple controllers in the via82cxxx IDE driver
>
> Signed-off-by: Daniel Drake <dsd@gentoo.org>

--- linux/drivers/ide/pci/via82cxxx.c.orig	2005-08-31 01:32:05.000000000 +0100
+++ linux/drivers/ide/pci/via82cxxx.c	2005-09-02 01:16:59.000000000 +0100
@@ -101,11 +101,19 @@ static struct via_isa_bridge {
 	{ NULL }
 };

-static struct via_isa_bridge *via_config;
-static unsigned int via_80w;
-static unsigned int via_clock;
 static char *via_dma[] = { "MWDMA16", "UDMA33", "UDMA66", "UDMA100",
"UDMA133" };

I would really prefer not to add per host struct via82xxx_dev,
(making it per hwif and doing extra match in ->init_hwif() is acceptable).

+struct via82cxxx_dev
+{
+	struct pci_dev *pci_dev, *isa_dev;

pci_dev is needed only for /proc/via and I would prefer /proc/via
to vanish because it complicates driver needlessly (could you do
this in separate patch?).

isa_dev has no relevance for vt6410 and won't be needed if
/proc/via goes away

+	struct via_isa_bridge *via_config;

Please instead add via_config_find() which would
find proper via_config given PCI ID.

+	unsigned int via_clock;

Global via_clock is OK as IDE core doesn't
support per bus PCI clocks anyway.

+	unsigned int via_80w;

Cable detection code should be moved to separate function
and be called from ->init_hwif() (required for future hotplug support).

Otherwise patch looks fine.

Thanks and sorry for the delay,
Bartlomiej

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: More IDE hackery
Date: Wed, 3 Nov 2004 18:14:53 +0100
Message-ID: <58cb370e04110309146ad102fc@mail.gmail.com>
References: <1099487809.29560.28.camel@localhost.localdomain>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.206]:48786 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261727AbUKCRPC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Nov 2004 12:15:02 -0500
Received: by rproxy.gmail.com with SMTP id a36so118713rnf
        for <linux-ide@vger.kernel.org>; Wed, 03 Nov 2004 09:14:54 -0800 (PST)
In-Reply-To: <1099487809.29560.28.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Hi!

On Wed, 03 Nov 2004 13:16:50 +0000, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Our SI3112 driver fixups don't work in some cases. I found this while

brown paper bug of mine

> trying to work out what was going on in IT8212. At the point we check
> for the mod15 bug we may not have drive data. So we need a "fixups"
> callback.
> 
> I've also played with a pile of flash adapters - it seems the slave
> decode bug is PCMCIA specific - so we need a fixup hook for
> pcmcia/delkin/..

Cool.

> I ended up with the following which solves all three in one go and
> allows us to fix anything else that turns up
> 
> 1. Turned ide_undecoded_slave into a routine of its own

fine

> 2. Changed probe_hwif_init to take a third argument a "fixup" callback
> which is run after hwif_init but before ata_attach

What about ide_hwif_t->fixup instead?

> 3. Modify ide-cs, delkin to pass ide_undecoded_slave as their fixup

It won't work unless you modify ide_register_hw().
See ide_register_hw() vs "initializing == 1".

> 4. Added "fixup" as a method in the ide_pci_device_t and made the
> pci-setup code pass this as the fixup argument to probe_hwif_init
> 5. Made si3112 pass the mod15 check this way, made it8212 pass the
> geometry demnagler this way
> 6. Fix up the other callers to pass NULL

I prefer minimal changes to existing code...

> I've attached the code change, if you think its sane I'll split you out
> a set of patches versus the base Linus tree which do this

Only patch for 1. is attached.

It is hard to speak about changes without seeing actual code.

+	/* Has a serial number but is warped */
+	if (!strstr(drive0->id->model, "Integrated Technology Express"))
+		return;

This shouldn't be needed now, no?

Bartlomiej

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] add pci_get_legacy_ide_irq()
Date: Tue, 26 Oct 2004 19:21:43 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <58cb370e041026102135bedcdc@mail.gmail.com>
References: <1098757431.17904.27.camel@gaston>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.194]:4624 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261353AbUJZRVo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Oct 2004 13:21:44 -0400
Received: by wproxy.gmail.com with SMTP id 64so201750wri
        for <linux-ide@vger.kernel.org>; Tue, 26 Oct 2004 10:21:43 -0700 (PDT)
In-Reply-To: <1098757431.17904.27.camel@gaston>
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: list linux-ide <linux-ide@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

Hi!

On Tue, 26 Oct 2004 12:23:51 +1000, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> Hi Bart !
> 
> This patch, as discussed earlier, adds pci_get_legacy_ide_irq() with a generic
> implementation and a ppc64 specific one. I only fixed the amd7xxx.c driver for now,
> I expect people using this interface will slowly fix their drivers (I will fix via
> soon as I'll need it too, and maybe a few others).
> 
> This version uses "0" as no-irq to be compatible with the rest of IDE. A patch
> teaching IDE about NO_IRQ is on the work, I'll post a version for comment soon,
> but it's not simple, so let's do things separately for now, this is more urgent.
>
> If you are happy with this one, can you please fwd to Linus & Andrew for meging ?

Sure, patch looks fine.

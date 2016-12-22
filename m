From: tedheadster <tedheadster@gmail.com>
Subject: Re: [PATCH] pata_legacy: Allow disabling of legacy PATA device probes
 on non-PCI systems
Date: Thu, 22 Dec 2016 12:14:43 -0500
Message-ID: <CAP8WD_ay1uKc0JLPr8MWQKT2N=rdqeH+hKkOCVMt76NcmK4hAA@mail.gmail.com>
References: <CAP8WD_boGwPZCEPE8hA-AhQnHChrbaM+74LTUy-9__s6ex56Sg@mail.gmail.com>
 <20161130202201.GA15989@htj.duckdns.org> <CAP8WD_bZWeLBhLXqJG5uDwBe+zBubw+A+ecSuaihOuwvw9QoCQ@mail.gmail.com>
 <20161202170705.GB6033@htj.duckdns.org> <CAP8WD_bUW9cAAQpvenL73sxvpoxNYwZdRqpj92YWEyanK51+0g@mail.gmail.com>
 <20161205192310.GA30331@mtj.duckdns.org> <CAP8WD_becq+h2=-g7t-6Pp1psmkCCvdB0YUcg+wYPocUP4dYdw@mail.gmail.com>
 <20161212170154.GA13864@htj.duckdns.org> <CAP8WD_YMtnsuYmJHGz1eLmrQNemsB1Z6Soyb6f72brAfMNUNeg@mail.gmail.com>
 <CAP8WD_ZoJgrdsDZNR4uN8HWESO5MyuNc1xN_F2an8GfP8nKcLA@mail.gmail.com> <20161222163711.GB29161@htj.duckdns.org>
Reply-To: whiteheadm@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:35553 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941604AbcLVRPG (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 22 Dec 2016 12:15:06 -0500
Received: by mail-yw0-f193.google.com with SMTP id b66so15168504ywh.2
        for <linux-ide@vger.kernel.org>; Thu, 22 Dec 2016 09:15:05 -0800 (PST)
In-Reply-To: <20161222163711.GB29161@htj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-ide@vger.kernel.org

Tejun,
>
> The thing I'm puzzled about and can't reproduce here is that the
> platform_device_unregister() call on the fail path should release the
> irq resources without the explicit devres group operations.  I can
> write up tracking each step but it'd probably be easier on your side
> to track down why it's not getting called.
>
> So, pata_legacy doesn't need anything changed, but in the probe fail
> path, platform_device_unregister() should trigger
> driver/base/core.c::device_release() which calls devres_release_all()
> and release the irqs.
>

It looks to me that when something is 'platform' it is not expected to
ever go away, and that generally includes irqs. There are calls to
platform_get_irq() but there isn't even a function called
platform_put_irq() or platform_free_irq().

I do see some driver calls to failure conditions or 'remove' functions
where it calls:

free_irq(platform_get_irq(pdev, 0), var)

See:

drivers/mmc/host/atmel-mci.c
drivers/usb/gadget/udc/fotg210-udc.c
drivers/usb/gadget/udc/fusb300_udc.c
drivers/usb/gadget/udc/m66592-udc.c
drivers/video/fbdev/au1200fb.c
drivers/virtio/virtio_mmio.c
drivers/dma/at_hdmac.c
 drivers/input/keyboard/pxa930_rotary.c
drivers/input/keyboard/sh_keysc.c

I think this driver should either not be considered 'platform' or it
should make a call to free_irq() on failures.

- Matthew

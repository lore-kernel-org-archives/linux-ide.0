From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: SATA_DWC COMPILE_TEST is nasty horrid stuff (was "GIT PULL] libata
 changes for v3.20-rc1")
Date: Tue, 10 Feb 2015 17:44:38 -0800
Message-ID: <CA+55aFwwp3xEgjk3Qo_CHLKLXA6hOtqSaLwCPJzj34f5AHKRhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:35590 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075AbbBKBol (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Feb 2015 20:44:41 -0500
Received: by iebtr6 with SMTP id tr6so816115ieb.2
        for <linux-ide@vger.kernel.org>; Tue, 10 Feb 2015 17:44:41 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tejun Heo <tj@kernel.org>
Cc: IDE-ML <linux-ide@vger.kernel.org>

This COMPILE_TEST thing is beyond annoying.

It was already disabled for ARM and ARM64. And I'm going to disable it
entirely, because the driver noisy as hell, and I don't want to see
the insane warnings from it in my allmodconfig build.

I'm talking about these things:

  drivers/ata/sata_dwc_460ex.c:652:32: warning: cast from pointer to
integer of different size [-Wpointer-to-int-cast]
     lli[idx].sar = cpu_to_le32((u32)dmadr_addr);
                                ^

and as far as I can tell (but maybe I didn't trace things right) that
"dmadr_addr" really is a pointer, and doesn't necessarily fit in 32
bits. It's somewhat obscure with the random casting to "void __iomem
*") etc, but the source of it seems to be

 &hsdev->sata_dwc_regs->dmadr

which looks to come from this:

  hsdev->sata_dwc_regs = (void *__iomem)(base + SATA_DWC_REG_OFFSET);

so that whole thing is basically

    base + SATA_DWC_REG_OFFSET + offsetof(dmadr)

Fine. But it also does

    base = of_iomap(np, 0);

so the whole driver seems to basically depend on the low 32 bits of
the "of_iomap()" thing being meaningful. And I'm not at all sure it
is.

So I'm not at all sure that can possibly make sense, but I *am* sure
that it causes very noisy warnings. And the warnings are just hiding
other warnings that might be more relevant, so right now enabling that
driver on other architectures is not an improvement, it just sucks.

You guys can try again when the driver has actually been cleaned up
and might compile cleanly. Right now it's just nasty, and looking at
the code I think that the thing is fundamentally wrong and cannot work
outside of its original environment (ppc 460ex, apparently) anyway.

                           Linus

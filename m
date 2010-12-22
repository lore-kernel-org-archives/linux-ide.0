From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH 1/1] ARM: cns3xxx: ahci: Fixup for softwreset failures
 with direct connected disks with CONFIG_SATA_PMP enabled.
Date: Wed, 22 Dec 2010 14:58:08 +0300
Message-ID: <20101222115808.GA458@oksana.dev.rtsoft.ru>
References: <1291481021-23317-1-git-send-email-mkl0301@gmail.com>
 <20101220170217.GA1333@oksana.dev.rtsoft.ru>
 <AANLkTi=Lk1vAxxTJQpXNvtbLCFs0Gy+ZAJadxv_mLQ6C@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f45.google.com ([209.85.215.45]:36549 "EHLO
	mail-ew0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752233Ab0LVL6M (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Dec 2010 06:58:12 -0500
Received: by ewy10 with SMTP id 10so2535859ewy.4
        for <linux-ide@vger.kernel.org>; Wed, 22 Dec 2010 03:58:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=Lk1vAxxTJQpXNvtbLCFs0Gy+ZAJadxv_mLQ6C@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lin Mac <mkl0301@gmail.com>
Cc: htejun@gmail.com, linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

On Wed, Dec 22, 2010 at 05:27:20PM +0800, Lin Mac wrote:
[...]
> > This is not good because cns3xxx_pwr_*() calls aren't thread-safe.
> > We must use them only from the "single-threaded" platform code,
> > i.e. very early.
> > Once we add proper clocks (clkapi) and power management (regulators)
> > support for CNS3xxx, we may move this into ahci->init() callback.
> Almost every device driver needs to change those power/clk/reset bits,
> and it's strange to enable everything on init phase. BTW, the  EHCI
> and OHCI that I sent previously also used these cns3xxx_pwr_*() calls.
> 
> Would they be supported in near future? If not, I would like look into those.

Currently I do not work on adding these features, so feel free
look into it.

> > Plus, unfortunately this patch breaks build when AHCI_PLATFORM is
> > set to =m.
> > arch/arm/mach-cns3xxx/built-in.o: In function 'cns3xxx_ahci_softreset':
> > cns3420vb.c:(.text+0x36c): undefined reference to 'ahci_do_softreset'
> > cns3420vb.c:(.text+0x390): undefined reference to 'ahci_do_softreset'
> > cns3420vb.c:(.text+0x3a0): undefined reference to 'ahci_check_ready'
> > arch/arm/mach-cns3xxx/built-in.o:(.data+0x35c): undefined reference to 'ahci_ops'
> > make: *** [.tmp_vmlinux1] Error 1
> Sorry that I didn't notice this. I was trying to reuse ahci-platform
> as possible.
> Building platform device as module seems strange to me, therefore I
> would add a new ahci-platform alike platform driver.

Yep. But please make it similar to the SDHCI platform driver
approach. I.e., see these commits:

commit 20b1597bcf4a76ccab232fa032f5f9ad30069167
Author: Anton Vorontsov <avorontsov@mvista.com>
Date:   Tue Aug 10 18:01:49 2010 -0700

    sdhci-pltfm: add support for CNS3xxx SoC devices

commit 845e3f4f06f9b1d34f39601cb6b7abfb8f40653c
Author: Anton Vorontsov <avorontsov@mvista.com>
Date:   Tue Aug 10 18:01:49 2010 -0700

    sdhci-pltfm: reorganize Makefile entries to support SoC devices

commit 515033f97c0b5a1bce13fa93e09704d95b44f376
Author: Anton Vorontsov <avorontsov@mvista.com>
Date:   Tue Aug 10 18:01:47 2010 -0700

    sdhci-pltfm: switch to module device table matching

Thanks,

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com

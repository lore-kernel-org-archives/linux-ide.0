From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: linux-next: Tree for October 24 - powerpc - build failure with
 !CONFIG_BLK_DEV_IDEDMA_PMAC
Date: Fri, 24 Oct 2008 16:15:26 +0400
Message-ID: <4901BC5E.7040607@ru.mvista.com>
References: <20081024171932.1e8131d0.sfr@canb.auug.org.au> <20081024113856.GA4252@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:38298 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753243AbYJXMPe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 24 Oct 2008 08:15:34 -0400
In-Reply-To: <20081024113856.GA4252@linux.vnet.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, bzolnier@gmail.com

Hello.

Kamalesh Babulal wrote:

>  next-20081024 randconfig build fails on the powerpc, with
>
> drivers/ide/pmac.c: In function 'pmac_ide_set_pio_mode':
> drivers/ide/pmac.c:527: error: implicit declaration of function 'kauai_lookup_timing'
> drivers/ide/pmac.c:527: error: 'shasta_pio_timings' undeclared (first use in this function)
> drivers/ide/pmac.c:527: error: (Each undeclared identifier is reported only once
> drivers/ide/pmac.c:527: error: for each function it appears in.)
> drivers/ide/pmac.c:534: error: 'kauai_pio_timings' undeclared (first use in this function)
> drivers/ide/pmac.c: In function 'pmac_ide_do_resume':
> drivers/ide/pmac.c:914: error: 'IDE_WAKEUP_DELAY' undeclared (first use in this function)
> drivers/ide/pmac.c: At top level:
> drivers/ide/pmac.c:1007: error: 'pmac_ide_init_dma' undeclared here (not in a function)
> drivers/ide/pmac.c: In function 'pmac_ide_setup_device':
> drivers/ide/pmac.c:1107: error: 'IDE_WAKEUP_DELAY' undeclared (first use in this function)
> drivers/ide/pmac.c: In function 'pmac_ide_macio_attach':
> drivers/ide/pmac.c:1209: error: 'pmac_ide_hwif_t' has no member named 'dma_regs'
> drivers/ide/pmac.c:1210: error: 'pmac_ide_hwif_t' has no member named 'dma_regs'
> make[2]: *** [drivers/ide/pmac.o] Error 1
>   

   Hm, looks like this configuration was never buildable -- #ifdef's are 
missing and wrongly placed. CCing Ben Herrenschmidt...

MBR, Sergei



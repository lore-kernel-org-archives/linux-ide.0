From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 8/21] ide: don't try to unregister interfaces if 'initializing'
 in ide_register_hw()
Date: Fri, 07 Dec 2007 19:49:50 +0300
Message-ID: <475979AE.6000102@ru.mvista.com>
References: <200711182319.59382.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:26316 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751736AbXLGQtd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 7 Dec 2007 11:49:33 -0500
In-Reply-To: <200711182319.59382.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Host drivers using ide_register_hw() and 'initializing == 1':

> * ide-pnp
>   - depends on ISA

> * ide_arm 
>   - ARM arch specific
>   - initialized before all other host drivers

> * ide-cris
>   - CRIS arch specific => IDE_ARCH_OBSOLETE_INIT is not defined
>   - broken

> * ide-h8300
>   - H8300 arch specific => IDE_ARCH_OBSOLETE_INIT is not defined, no PCI

> * buddha/q40/gayle/macide/falconide
>   - M68K arch specific => IDE_ARCH_OBSOLETE_INIT is not defined, no PCI

> Since the only host drivers which probe interfaces before the above ones are:

> * ali14xx/dtc2278/ht6560b/qd65xx/umc8672
>   - depend on ISA
>   - require IDE_ARCH_OBSOLETE_INIT=y to work

> * PCI ones
>   - depend on PCI

> don't try to unregister interfaces if 'initializing == 1' in ide_register_hw()
> (it is possible that built-in host drivers will claim all IDE interfaces but
> later ide-pnp host driver will try to unregister them - this change fixes it).

> Also skip hwif->hold check if 'initializing == 1' since it is set only by:

> * pmac
>   - PPC && PMAC specific => no ISA

> * au1xxx-ide
>   - MIPS && SOC_AU1200 specific => no ISA

> and use ide_find_port() helper to find free ide_hwifs[] slot.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei

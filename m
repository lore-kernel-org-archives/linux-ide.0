From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] siimage: fix kernel oops on PPC 44x
Date: Tue, 08 Apr 2008 17:09:57 +0400
Message-ID: <47FB6EA5.4070606@ru.mvista.com>
References: <200804080005.03683.sshtylyov@ru.mvista.com> <200804072330.00610.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:40481 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752219AbYDHNKi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Apr 2008 09:10:38 -0400
In-Reply-To: <200804072330.00610.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org

Bartlomiej Zolnierkiewicz wrote:

>>Fix kernel oops due to machine check occuring in init_chipset_siimage() on PPC
>>44x platforms.  These 32-bit CPUs have 36-bit physical address and PCI I/O and
>>memory spaces are mapped beyond 4 GB; arch/ppc/ code has a fixup in ioremap()
>>that creates an illusion of the PCI I/O and memory resources being mapped below
>>4 GB, while arch/powerpc/ code got rid of this fixup with PPC 44x having instead
>>CONFIG_RESOURCES_64BIT=y -- this causes the resources to be truncated to 32-bit
>>'unsigned long' type in this driver, and so non-existant memory being ioremap'ed
>>and then accessed...

>>Thanks to Valentine Barshak for providing an initial patch and explanations.

>>Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> applied and pushed to Linus, thanks!

> I guess that it would be worth to audit the rest of IDE code for

    Already done. Some drivers, like sgiioc4, scc_pata, and pmac are prone to
that at least in theory.  Although I doubt that they ever get used in such
environments as PPC 44x platform kernels, i.e. 32-bit kernel and PCI mapped 
beyond 4 GB.

> pci_resource_{start,end}() vs 'unsigned long' occurences and fix them.

    There are quite a lot of those overall but they only pose danger if the 
resource in question is in memory space since the I/O space always uses 
'unsigned long' addresses. So, IDE core and drivers using only I/O resources 
should not be prone to that kind of issue.

> [ Even if they work at the moment they are just bugs waiting to happened
>   when we add support for some new platforms or rewrite the code... ]

WBR, Sergei


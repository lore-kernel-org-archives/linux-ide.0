From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] siimage: fix kernel oops on PPC 44x
Date: Mon, 7 Apr 2008 23:29:59 +0200
Message-ID: <200804072330.00610.bzolnier@gmail.com>
References: <200804080005.03683.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:46427 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752523AbYDGVWT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Apr 2008 17:22:19 -0400
Received: by nf-out-0910.google.com with SMTP id g13so770276nfb.21
        for <linux-ide@vger.kernel.org>; Mon, 07 Apr 2008 14:22:17 -0700 (PDT)
In-Reply-To: <200804080005.03683.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org

On Monday 07 April 2008, Sergei Shtylyov wrote:
> Fix kernel oops due to machine check occuring in init_chipset_siimage() on PPC
> 44x platforms.  These 32-bit CPUs have 36-bit physical address and PCI I/O and
> memory spaces are mapped beyond 4 GB; arch/ppc/ code has a fixup in ioremap()
> that creates an illusion of the PCI I/O and memory resources being mapped below
> 4 GB, while arch/powerpc/ code got rid of this fixup with PPC 44x having instead
> CONFIG_RESOURCES_64BIT=y -- this causes the resources to be truncated to 32-bit
> 'unsigned long' type in this driver, and so non-existant memory being ioremap'ed
> and then accessed...
> 
> Thanks to Valentine Barshak for providing an initial patch and explanations.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied and pushed to Linus, thanks!

I guess that it would be worth to audit the rest of IDE code for
pci_resource_{start,end}() vs 'unsigned long' occurences and fix them.

[ Even if they work at the moment they are just bugs waiting to happened
  when we add support for some new platforms or rewrite the code... ]

From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC: 2.6 patch] schedule BLK_DEV_IDE_SATA for removal
Date: Fri, 22 Jun 2007 10:02:16 +0100
Message-ID: <20070622100216.45abf2b3@the-village.bc.nu>
References: <20070621235211.GH23017@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51771 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751708AbXFVI6e (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Jun 2007 04:58:34 -0400
In-Reply-To: <20070621235211.GH23017@stusta.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 22 Jun 2007 01:52:11 +0200
Adrian Bunk <bunk@stusta.de> wrote:

> Users should use the libata based drivers for SATA drives.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> --- linux-2.6.22-rc4-mm2/Documentation/feature-removal-schedule.txt.old	2007-06-21 23:41:03.000000000 +0200
> +++ linux-2.6.22-rc4-mm2/Documentation/feature-removal-schedule.txt	2007-06-21 23:42:03.000000000 +0200
> @@ -347,3 +347,10 @@
>  Who:	Jean Delvare <khali@linux-fr.org>
>  
>  ---------------------------
> +
> +What:  CONFIG_BLK_DEV_IDE_SATA
> +When:  December 2007
> +Why:   users should use the libata based drivers for SATA
> +Who:   Adrian Bunk <bunk@stusta.de>
> +
> +---------------------------

NAK this for now

For the standard SATA controllers it is probably true now and will
definitely be true by December 2007 but there is lots of stuff out there
which uses SATA/PATA bridges on older PATA controllers such as the
VIA and HPT controllers. While support for them varies between rock solid
(VIA) and passable (HPT), I don't think its yet time to bump those people
towards libata forcibly at all.

About the only thing this would meaningfully obsolete would be
ide/pci/siimage.c for SI3112 and some PCI identifiers from ide/pci/piix.c.


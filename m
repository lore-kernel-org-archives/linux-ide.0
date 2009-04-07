From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [git pull] IDE updates part 4
Date: Wed, 8 Apr 2009 01:26:58 +0200
Message-ID: <200904080126.58613.bzolnier@gmail.com>
References: <200904080020.43175.bzolnier@gmail.com> <49DBD3EE.3010601@garzik.org> <200904080059.43698.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.188]:49089 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752561AbZDGXX7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Apr 2009 19:23:59 -0400
In-Reply-To: <200904080059.43698.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 08 April 2009 00:59:43 Bartlomiej Zolnierkiewicz wrote:

[...]

> diff --git a/drivers/ide/ide.c b/drivers/ide/ide.c
> index 7b7cd76..4ed66d0 100644
> --- a/drivers/ide/ide.c
> +++ b/drivers/ide/ide.c
> @@ -178,11 +178,14 @@ EXPORT_SYMBOL_GPL(ide_pci_clk);
>  module_param_named(pci_clock, ide_pci_clk, int, 0);
>  MODULE_PARM_DESC(pci_clock, "PCI bus clock frequency (in MHz)");
>  
> +/* needs block layer support */
> +#if 0
>  int ide_trim = 0;

This patch is crap and will break ide-disk build.

Linus, I'll revisit the pull request later...

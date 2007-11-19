From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 21/21] ide: make remaining built-in only IDE host drivers modular
Date: Mon, 19 Nov 2007 01:16:08 +0100
Message-ID: <200711190116.09096.bzolnier@gmail.com>
References: <200711182341.31267.bzolnier@gmail.com> <1195427098.7022.13.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:11380 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921AbXKSAKk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Nov 2007 19:10:40 -0500
Received: by ug-out-1314.google.com with SMTP id z38so878093ugc
        for <linux-ide@vger.kernel.org>; Sun, 18 Nov 2007 16:10:39 -0800 (PST)
In-Reply-To: <1195427098.7022.13.camel@pasglop>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: benh@kernel.crashing.org
Cc: linux-ide@vger.kernel.org, Mikael Starvik <starvik@axis.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Roman Zippel <zippel@linux-m68k.org>


Hi,

On Monday 19 November 2007, Benjamin Herrenschmidt wrote:
> 
> On Sun, 2007-11-18 at 23:41 +0100, Bartlomiej Zolnierkiewicz wrote:
> > * Make remaining built-in only IDE host drivers modular, add ide-scan-pci.c
> >   file for probing PCI host drivers registered with IDE core (special case
> >   for built-in IDE and CONFIG_IDEPCI_PCIBUS_ORDER=y) and then take care of
> >   the ordering in which all IDE host drivers are probed when IDE is built-in
> >   during link time.
> 
>   .../...
> 
> Do you have a git tree I can get all that stuff from ?

git tree containing IDE quilt tree + this patch series (103 patches in total):

	git://git.kernel.org/pub/scm/linux/kernel/git/bart/ide-2.6-scratch.git

same content in quilt tree form:

	http://kernel.org/pub/linux/kernel/people/bart/pata-2.6-scratch/

Thanks,
Bart

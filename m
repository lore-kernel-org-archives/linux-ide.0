From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] [428/2many] MAINTAINERS - SERIAL ATA (SATA) SUBSYSTEM:
Date: Mon, 13 Aug 2007 14:43:35 -0700
Message-ID: <1187041415.10249.332.camel@localhost>
References: <46bffbb6.4FinvGMu+SlIxG24%joe@perches.com>
	 <20070813120221.2e70e32f@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from DSL022.labridge.com ([206.117.136.22]:3767 "EHLO perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754359AbXHMVns (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Aug 2007 17:43:48 -0400
In-Reply-To: <20070813120221.2e70e32f@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jgarzik@pobox.com, akpm@linux-foundation.org

On Mon, 2007-08-13 at 12:02 +0100, Alan Cox wrote:
> > @@ -4077,6 +4077,7 @@ M:	jgarzik@pobox.com
> >  L:	linux-ide@vger.kernel.org
> >  T:	git kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
> >  S:	Supported
> > +F:	drivers/ata/sata_*
> 
> NAK
> 	sata_inic is Tejun
> 
> and various others are also different

How does adding

X:	file patterns to exclude

and updating the script sound?


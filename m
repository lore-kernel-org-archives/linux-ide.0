From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] [ide] mmio ide support
Date: Sat, 7 Jul 2007 21:02:34 +0100
Message-ID: <20070707210234.6aed88bb@the-village.bc.nu>
References: <20070707094852.9473.21013.stgit@localhost.localdomain>
	<200707071419.52650.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57080 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753102AbXGGT4i (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 7 Jul 2007 15:56:38 -0400
In-Reply-To: <200707071419.52650.arnd@arndb.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Vitaly Bordug <vitb@kernel.crashing.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> You could also make it an of_platform_driver at the same time
> instead of adding more cruft to fsl_soc.c. Since we're already
> about to add the electra_ide.c driver in 2.6.23, I guess there
> should really be _one_ driver that is able to handle all
> of_device based ATA hosts.

and do so using libata. Preferably ata_platform but it does look like
ata_of would make sense as a companion.

Alan

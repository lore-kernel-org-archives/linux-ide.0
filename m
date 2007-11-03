From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Bart's efforts?
Date: Sat, 3 Nov 2007 16:22:03 +0000
Message-ID: <20071103162203.5388a37f@the-village.bc.nu>
References: <200711031541.lA3FfJ6h006120@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53368 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754211AbXKCQU6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 Nov 2007 12:20:58 -0400
In-Reply-To: <200711031541.lA3FfJ6h006120@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: greg.freemyer@gmail.com, linux-ide@vger.kernel.org

> 1) there's no libata replacement for the IDE pmac driver

This is true currently. David Woodhouse loaned me a Pmac to fix that but
it died so thats waiting for the PPC people to do something about it.

> 2) pata_pdc202xx_old can't do UDMA on my 440BX PIII box

Bug # ?

> 3) pata_legacy doesn't release io/irq combinations for failed
>    probes, causing conflicts with drivers loaded later on

In my tree it does but I'm still testing some bits. I've been rewriting
the legacy driver to make it a lot cleaner and easy to plug other ISA/VLB
device handlers into it.


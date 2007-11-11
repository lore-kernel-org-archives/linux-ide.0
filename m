From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.24-rc1: pata_acpi fails to activate DMA for DVD-ROM on ALi
 M5229 secondary channel
Date: Sun, 11 Nov 2007 20:02:36 +0000
Message-ID: <20071111200236.4cece127@the-village.bc.nu>
References: <200710262130.03567.arvidjaar@mail.ru>
	<20071026202559.01161aa9@the-village.bc.nu>
	<200711112223.13542.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54094 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756145AbXKKUDO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Nov 2007 15:03:14 -0500
In-Reply-To: <200711112223.13542.arvidjaar@mail.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

> BTW in rc2 it does not even boot - it babbles something about
> Unable to determine IRQ for 00:04.0  (which is IDE controller) and that is
> the end of story. No IDE device is found.

Thats not an IDE breakage I suspect. Various people are reporting IRQ
related breakage with -rc2 so you should probably report that to the main
linux-kernel list

Doesn't explain the ALi DMA problem but I think its unrelated

Alan

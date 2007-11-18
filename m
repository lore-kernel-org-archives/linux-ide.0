From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 21/21] ide: make remaining built-in only IDE host
	drivers modular
Date: Mon, 19 Nov 2007 10:04:58 +1100
Message-ID: <1195427098.7022.13.camel@pasglop>
References: <200711182341.31267.bzolnier@gmail.com>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:44991 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752687AbXKRXFQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 18 Nov 2007 18:05:16 -0500
In-Reply-To: <200711182341.31267.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Mikael Starvik <starvik@axis.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Roman Zippel <zippel@linux-m68k.org>


On Sun, 2007-11-18 at 23:41 +0100, Bartlomiej Zolnierkiewicz wrote:
> * Make remaining built-in only IDE host drivers modular, add ide-scan-pci.c
>   file for probing PCI host drivers registered with IDE core (special case
>   for built-in IDE and CONFIG_IDEPCI_PCIBUS_ORDER=y) and then take care of
>   the ordering in which all IDE host drivers are probed when IDE is built-in
>   during link time.

  .../...

Do you have a git tree I can get all that stuff from ?

Cheers,
Ben.



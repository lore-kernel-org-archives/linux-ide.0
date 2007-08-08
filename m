From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: pata_ali: trouble with DVD combo
Date: Wed, 8 Aug 2007 02:19:38 +0100
Message-ID: <20070808021938.44e45c32@the-village.bc.nu>
References: <20070808005739.221200@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43704 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S933525AbXHHBME (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Aug 2007 21:12:04 -0400
In-Reply-To: <20070808005739.221200@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Cornell Gonschior <df6fr@gmx.de>
Cc: linux-ide@vger.kernel.org

> The boot process takes several minutes when trying to configure the Combo
> drive with UDMA/33 and finally settles with UDMA/25:

Known problem. Still under investigation and not yet understood fully.

> Is this a problem with my drive? It works fine with alim15x3, so.
> Did I forget to enable something in the kernel?

Please send me an lspci -vvxxx after booting both the libata and non
libata kernel.

Alan

From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_hpt3x3: Major reworking and testing
Date: Tue, 3 Jul 2007 18:56:52 +0100
Message-ID: <20070703185652.0b807fcc@the-village.bc.nu>
References: <20070703161002.1576c39d@the-village.bc.nu>
	<200707031938.20956.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48907 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755408AbXGCRuq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 13:50:46 -0400
In-Reply-To: <200707031938.20956.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jeff@garzik.org

> The new improved driver is not really better than the old one because
> the old one is broken. :)
> 
> Old driver does identical configuration when it comes to PIO modes.

No the old driver doesn't even do that. It starts up. It spuriously
adjusts some non writable PCI BAR registers, prints a message about
resources being in use already then exits.

I had a poke around the setup. As far as I can observe we break even if
the ROM timing values are used as is. I suspect documentation or a good
deal of luck is needed.

Alan

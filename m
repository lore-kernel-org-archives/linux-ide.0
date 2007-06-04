From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2.6.22-rc2] libata: sata_sis fixes
Date: Mon, 4 Jun 2007 16:30:22 +0100
Message-ID: <20070604163022.1adf136f@the-village.bc.nu>
References: <200705250948.52588.uwe.koziolek@gmx.net>
	<20070525153230.325258e9@the-village.bc.nu>
	<465D33DF.9040708@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34244 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756874AbXFDPZV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Jun 2007 11:25:21 -0400
In-Reply-To: <465D33DF.9040708@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Uwe Koziolek <uwe.koziolek@gmx.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, "linux.ide" <linux-ide@vger.kernel.org>

> How should I proceed. I can submit both patches:
> - exclude SiS180 from enable bit checking or
> - exclude MuTol ATA133 from enable bit checking with different
> error_handler.

Been away but - SiS180 wants excluding anyway according to all the docs,
the MuToL does appear to be working correctly with enable bits and we've
got no failure cases in old/new IDE so leave it alone (for now anyway)

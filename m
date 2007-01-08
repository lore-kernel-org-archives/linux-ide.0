From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2.6.20-rc3-mm1 2/2] libata: SiS 180 pata/sata support
Date: Mon, 8 Jan 2007 15:30:03 +0000
Message-ID: <20070108153003.6f8cc076@localhost.localdomain>
References: <45A19F67.6050909@garzik.org>
	<20070108102809.512b4409@localhost.localdomain>
	<45A22E9F.1050607@garzik.org>
	<20070108125116.015da28f@localhost.localdomain>
	<45A23E06.5020605@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52425 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751582AbXAHPTc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Jan 2007 10:19:32 -0500
In-Reply-To: <45A23E06.5020605@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Uwe Koziolek <uwe.koziolek@gmx.net>, "linux.ide" <linux-ide@vger.kernel.org>, Sven Ladegast <sven@linux4geeks.de>

> Far better would be, then, to combine the drivers into a single ata_sis 
> driver, it sounds like.

Why do pure PATA users need all the SATA crap loaded ? 

Alan

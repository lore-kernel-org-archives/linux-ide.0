From: Uwe Koziolek <uwe.koziolek@gmx.net>
Subject: Re: SiS 180 pata
Date: Mon, 05 Jul 2004 22:31:11 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1089059471.2868.9.camel@uk3.local>
References: <200407051253.47003.ivololeribar@yahoo.it>
	 <40E95B1D.3080501@pobox.com>  <200407051603.48708.ivololeribar@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:25737 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261857AbUGEUbf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jul 2004 16:31:35 -0400
In-Reply-To: <200407051603.48708.ivololeribar@yahoo.it>
List-Id: linux-ide@vger.kernel.org
To: Nicola <ivololeribar@yahoo.it>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Hello Nicola,

please can you provide the output of lspci -vvxxx

> should be something like:
> { "SiS180",     PCI_DEVICE_ID_SI_180,   ATA_133   },
> inside sis5513.c
> 
if the pata ports on the Sis180 a using the same ID 180, then we have a
conflict. We have 2 drivers for SIS 180.

I expect a different way in the SiS180 chip: a different ID
The output of lspci may helps hopefully.

But maybe i do not answer before next monday.

Uwe




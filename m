From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH] ata: libata depends on HAS_DMA
Date: Wed, 13 May 2009 17:57:14 -0600
Message-ID: <4A0B5E5A.4090906@gmail.com>
References: <20090511222702.352192505@arndb.de>	<200905112238.55404.arnd@arndb.de>	<20090512090602.65722342@lxorguk.ukuu.org.uk>	<200905121123.21436.arnd@arndb.de>	<20090513033027.GA13193@cynthia.pants.nu>	<alpine.DEB.1.00.0905130610240.18305@zirkon.biophys.uni-duesseldorf.de>	<20090513043409.GA13577@cynthia.pants.nu> <20090513095127.308b00e7@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.187]:52526 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694AbZEMX5U (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 May 2009 19:57:20 -0400
In-Reply-To: <20090513095127.308b00e7@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Brad Boyer <flar@allandria.com>, Michael Schmitz <schmitz@biophys.uni-duesseldorf.de>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, takata@linux-m32r.org, geert@linux-m68k.org, linux-m68k@vger.kernel.org, ysato@users.sourceforge.jp

Alan Cox wrote:
>>> If it doesn't interfere with plain PIO mode, fine. 
>> I agree. There definitely needs to still be support for IDE ports that
>> don't have DMA capability.
> 
> There is - it's just if the platform doesn't implement the dma_* APIs you
> get a problem.

Wouldn't the easiest solution be to just dummy out the DMA API calls on 
this platform to always fail? That would fix these compile problems..

From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: SiS 180 pata
Date: Mon, 05 Jul 2004 16:55:56 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40E9C05C.9040800@pobox.com>
References: <200407051253.47003.ivololeribar@yahoo.it>	 <40E95B1D.3080501@pobox.com>  <200407051603.48708.ivololeribar@yahoo.it> <1089059471.2868.9.camel@uk3.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60075 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262101AbUGEU4O
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Jul 2004 16:56:14 -0400
In-Reply-To: <1089059471.2868.9.camel@uk3.local>
List-Id: linux-ide@vger.kernel.org
To: Uwe Koziolek <uwe.koziolek@gmx.net>
Cc: Nicola <ivololeribar@yahoo.it>, linux-ide@vger.kernel.org

Uwe Koziolek wrote:
> Hello Nicola,
> 
> please can you provide the output of lspci -vvxxx
> 
> 
>>should be something like:
>>{ "SiS180",     PCI_DEVICE_ID_SI_180,   ATA_133   },
>>inside sis5513.c
>>
> 
> if the pata ports on the Sis180 a using the same ID 180, then we have a
> conflict. We have 2 drivers for SIS 180.
> 
> I expect a different way in the SiS180 chip: a different ID
> The output of lspci may helps hopefully.
> 
> But maybe i do not answer before next monday.

If it uses the same PCI id, I can work on that, on the libata side.

	Jeff




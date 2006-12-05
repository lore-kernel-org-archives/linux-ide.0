From: Uwe Koziolek <uwe.koziolek@gmx.net>
Subject: Re: sata_sis and SIS180 in combined mode
Date: Tue, 05 Dec 2006 01:12:24 +0100
Message-ID: <4574B968.1070709@gmx.net>
References: <200612031834.16797.sven@linux4geeks.de>	<45735B51.5040501@gmx.net>	<20061204001114.066b10f3@localhost.localdomain>	<457370CB.60008@gmx.net> <20061204125637.539c102d@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:51823 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S967871AbWLEAM3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Dec 2006 19:12:29 -0500
In-Reply-To: <20061204125637.539c102d@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Sven Ladegast <sven@linux4geeks.de>, uwe.koziolek@web.de, linux-ide@vger.kernel.org


>> One port is PATA, the other port is SATA, they have the same PCI
>> resources. It is possible to configure
>> the controller to use both ports in SATA mode without slave. Then the
>> PATA part of the controller is not
>> reachable.
>>     
>
> Ok so if the pata_sis driver exports
>
> 	sis_info133		(UDMA 133 port_info structure)
>
> is that sufficient for you to attach the PATA port to the PATA methods
> for this chipset ?
>
> Alan
>   
It should be sufficient .

Uwe

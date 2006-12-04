From: Uwe Koziolek <uwe.koziolek@gmx.net>
Subject: Re: sata_sis and SIS180 in combined mode
Date: Mon, 04 Dec 2006 01:50:19 +0100
Message-ID: <457370CB.60008@gmx.net>
References: <200612031834.16797.sven@linux4geeks.de>	<45735B51.5040501@gmx.net> <20061204001114.066b10f3@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:24964 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1760176AbWLDAuW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Dec 2006 19:50:22 -0500
In-Reply-To: <20061204001114.066b10f3@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Sven Ladegast <sven@linux4geeks.de>, uwe.koziolek@web.de, linux-ide@vger.kernel.org


>> Because you are only using the PATA port, you can make a private
>> solution, move the PCI-ID 180 from  sata_sis.c  to  sis5513.c  or 
>> pata_sis.c
>> dependend on the ide driver you want to use.
>>
>> The SiS180 has no hardware RAID functionality, It is only a BIOS based
>> software raid. The SiS180 is a combined  SATA/PATA controller.
>>
>> I will try a patch for this issue.
>>     
>
> Are both ports off the same set of PCI resources ? If not then it would
> be better to put a set of entry points into pata_sis that allow sata_sis
> to "plug in" pata support. I'm happy to help hack on this given enough
> info.
>
> Alan
>
>   
One port is PATA, the other port is SATA, they have the same PCI
resources. It is possible to configure
the controller to use both ports in SATA mode without slave. Then the
PATA part of the controller is not
reachable.

Uwe

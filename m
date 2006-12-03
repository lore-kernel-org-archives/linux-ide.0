From: Uwe Koziolek <uwe.koziolek@gmx.net>
Subject: Re: sata_sis and SIS180 in combined mode
Date: Mon, 04 Dec 2006 00:18:41 +0100
Message-ID: <45735B51.5040501@gmx.net>
References: <200612031834.16797.sven@linux4geeks.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:31137 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1758846AbWLCXSo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Dec 2006 18:18:44 -0500
In-Reply-To: <200612031834.16797.sven@linux4geeks.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sven Ladegast <sven@linux4geeks.de>
Cc: uwe.koziolek@web.de, linux-ide@vger.kernel.org

Hello Sven,

the sata_sis does not really supports PATA-ports.  The driver must be
modified.
A good solution would be to move the SiS180/964 support to pata_sis
because the PATA code is much longer then the SATA code.
Only some lines must be added to the pata_sis, to support  the SATA  ports.
But actually it does not work.
Because you are only using the PATA port, you can make a private
solution, move the PCI-ID 180 from  sata_sis.c  to  sis5513.c  or 
pata_sis.c
dependend on the ide driver you want to use.

The SiS180 has no hardware RAID functionality, It is only a BIOS based
software raid. The SiS180 is a combined  SATA/PATA controller.

I will try a patch for this issue.

regards,
Uwe Koziolek


Sven Ladegast wrote:
> Hello Uwe,
>
> I am having problems to access a hard drive connected to a SIS180 
> SATA-RAID controller.
>
> The controller is located on my mainboard (Elitegroup KV2 extreme).
> There is only one hard disk drive connected to the PATA port od the 
> controller. Both SATA ports are empty. The BIOS of the controller 
> recognizes the disk and while running Microsoft Windows I can access the 
> disk.
>
> I do not know the SIS180 chipset. Probably it is a fake-RAID but I do not 
> know if the PATA port is just a SATA-PATA birdge hardwired on the 
> mainboard or if it is a seperate port.
>
>   

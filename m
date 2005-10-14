From: Erwan Velu <erwan@seanodes.com>
Subject: Re: [PATCH]: atiixp : Enabling UDMA5 on IXP200
Date: Fri, 14 Oct 2005 05:47:02 +0200
Message-ID: <434F2A36.2010002@seanodes.com>
References: <434A583D.2030401@seanodes.com> <434E79BC.308@seanodes.com> <58cb370e0510131058g23e956a8m7bb0a82d8f670ce6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from seanodes.co.fr.clara.net ([212.43.220.11]:21932 "EHLO
	seanodes.co.fr.clara.net") by vger.kernel.org with ESMTP
	id S932501AbVJNDq3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 13 Oct 2005 23:46:29 -0400
In-Reply-To: <58cb370e0510131058g23e956a8m7bb0a82d8f670ce6@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

>Hi,
>
>I've seen your patch but I'm still thinking how to solve this problem
>because we can't just check for PCI device ID as it is a PATA controller
>(I guess that there is some PATA-SATA bridge on this particular
>motherboard).  
>
By reading the pci device list, I can't find any of them :(

>One possible fix is to check if device is SATA using
><linux/ata.h>:ata_id_is_sata() but I don't know how reliable it is,
>I need to check both ATA and SATA specs).
>
>  
>
Do you know how can I check that if this call works on my system ?

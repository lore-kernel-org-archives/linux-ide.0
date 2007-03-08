From: Pillar Engineering <pillar@fastwebnet.it>
Subject: Re: Sata marvel kernel module
Date: Thu, 08 Mar 2007 15:18:22 +0000
Message-ID: <45F0293E.1020303@fastwebnet.it>
References: <45EFDE3C.3090604@fastwebnet.it> <45EFDFC6.2070100@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aa012msr.fastwebnet.it ([85.18.95.72]:55810 "EHLO
	aa012msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752103AbXCHPRA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Mar 2007 10:17:00 -0500
Received: from [2.255.65.193] (2.255.65.193) by aa012msr.fastwebnet.it (7.3.105.6) (authenticated as claudiopietro.sanfelici)
        id 45E84A47004EAE7E for linux-ide@vger.kernel.org; Thu, 8 Mar 2007 16:16:54 +0100
In-Reply-To: <45EFDFC6.2070100@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Thank you very much for your answer, but I don't understand.

It this moment I use the Vanilla kernel (2.6.20.1) and I can work with
the first two sata ports on the controller. Do you mean is not the
sata_mv module wich permit this?
Where I can find your patch?

Thanks

Pillar Engineering
di Sanfelici Claudio
Via Cardinal Ferrari 23 / B
Cernusco sul Naviglio - MI
P.Iva 05403820961
Cell. +39 333.14.27.805
E-Mail pillar@fastwebnet.it



Jeff Garzik ha scritto:
> Pillar Engineering wrote:
>> Hi, i'm working in a project and I use the  Marvell 88SE6145 sata 
>> controller.
>> I use the sata_mv module for the linux kernel and, untill now, 
>> version 2.6.20.1, it supports only the first two ports on the 
>> controller.
>
> sata_mv does not support your hardware at all.  The PCI ID is not 
> present, so it won't even load for your hardware without modification.
>
> For the time being, look around for the ahci.c patch I posted, which 
> enables the SATA portion of the 6145.
>
>     Jeff
>
>
>
>


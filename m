From: Uwe Koziolek <uwe.koziolek@gmx.net>
Subject: Re: [PATCH 2.6.22-rc2] libata: sata_sis fixes
Date: Wed, 30 May 2007 10:20:47 +0200
Message-ID: <465D33DF.9040708@gmx.net>
References: <200705250948.52588.uwe.koziolek@gmx.net> <20070525153230.325258e9@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:34852 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750825AbXE3IUt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 30 May 2007 04:20:49 -0400
In-Reply-To: <20070525153230.325258e9@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>
Cc: "linux.ide" <linux-ide@vger.kernel.org>


>   
>> The sata_sis driver supports SATA and PATA ports. The broken support
>> of both types in one controller is fixed.
>>
>> the PATA-port of SiS180 controller does not support a drive present status
>> in the pci configspace like the other SiS PATA controllers, check skipped.
>>
>> Signed-off-by: Uwe Koziolek <uwe.koziolek@gmx.net>
>>     
>
> Needs checking with SiS because they submitted code that uses those
> enable bits and its been in drivers/ide for years with respect of the
> MuTOL ATA133. No argument about the SATA one if you've checked the docs
> and seen the bug.
>
>   
How should I proceed. I can submit both patches:
- exclude SiS180 from enable bit checking or
- exclude MuTol ATA133 from enable bit checking with different
error_handler.

Uwe

From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: todays git: WARNING: at drivers/ata/libata-sff.c:1017	ata_sff_hsm_move+0x45e/0x750()
Date: Sat, 10 Jan 2009 18:34:13 +0300
Message-ID: <4968BFF5.2090707@ru.mvista.com>
References: <200901091334.55823.borntraeger@de.ibm.com>	 <200901101009.13699.borntraeger@de.ibm.com>	 <20090110104114.633cacd8@lxorguk.ukuu.org.uk>	 <200901101242.05203.borntraeger@de.ibm.com>	 <49688B63.5030105@ru.mvista.com>	 <20090110122130.318cf168@lxorguk.ukuu.org.uk>	 <1231598170.3642.12.camel@localhost.localdomain>	 <20090110151248.063199d2@lxorguk.ukuu.org.uk> <1231600972.3642.22.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:64776 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751952AbZAJPdi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 10 Jan 2009 10:33:38 -0500
In-Reply-To: <1231600972.3642.22.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@redhat.com>, lkml <linux-kernel@vger.kernel.org>

Hello.

James Bottomley wrote:

>>>not divisible by four.  If you want to use word based PIO, you'll have
>>>to fall back to collecting bytes for the last two.  Alternatively, you

>>Nope.. you can't do that with ATA block transfers - it isn't the same as
>>SCSI

> Well, in that case you'll have to do byte PIO for all ATAPI devices,
> because this is an expected device to host transfer length.

    Byte PIO doesn't work in the ATA world unless the device supports it (I 
guess only CFA devices really support it) and the driver has enabled it (which 
I think isn't really worth it unless you have some h/w constaints). What you 
can do is read the whole 16-bit (or 32-bit) word and ignore the bytes you 
don't need.

MBR, Sergei


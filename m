From: Aron Rubin <arubin@atl.lmco.com>
Subject: Re: SII 3512 SATA Progress but help still needed
Date: Tue, 09 Dec 2003 07:23:01 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <3FD5BEA5.9070806@atl.lmco.com>
References: <3FCF9B07.5020509@atl.lmco.com> <3FD4D88A.3050708@atl.lmco.com> <200312082126.32948.bzolnier@elka.pw.edu.pl> <3FD4E026.2020307@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [192.35.37.50] ([192.35.37.50]:4488 "EHLO
	enterprise.atl.lmco.com") by vger.kernel.org with ESMTP
	id S265486AbTLIMXM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Dec 2003 07:23:12 -0500
Received: from atl.lmco.com (druidia [166.17.245.107])
	by enterprise.atl.lmco.com (Postfix) with ESMTP id 34D98C1C86
	for <linux-ide@vger.kernel.org>; Tue,  9 Dec 2003 07:23:01 -0500 (EST)
In-Reply-To: <3FD4E026.2020307@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Thank you, I did not have a chance to look at this yet but I will soon.
Interresting that this lost interrupt message seems to apply in more
cases with the siimage driver. Is it related to differences in the
architecture (64bit)? I thought it was merely something about dealing
with the new chipset. Silicon Image has not replied to my email yet but
I am not sure the 3512 is different from the 3112 other than the design
for the AMD64 Gigabyte mobo.

Aron

Jeff Garzik wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
>> I don't know. ;-)
>>
>> I have only one idea right now - look what drivers/scsi/libata.c
>> does for SATA controllers during init and what drivers/ide/ doesn't.
>>
>> I am talking about sata_phy_reset() in libata.c.
> 
> 
> libata-core.c :)
> 
> Basically for Silicon Image:
> * use SATA "SCR" (status and control register) to bring device out of 
> any low-power state it may be in
> * use SATA SCR to reset SATA bus
> * do _not_ issue ATA software reset or E.D.D. (90h), as the desired 
> signature is already in the ATA command block registers
> * look at the signature, decide ATA or ATAPI
> * issue IDENTIFY [PACKET] DEVICE
> * issue SET FEATURES (XFER)
> 
> That's the ATA_FLAG_SATA_RESET code path.  If the driver has the flag 
> ATA_FLAG_SRST, then the first few steps change to:
> * issue ATA software reset, by flipping SRST bit in Device Control
> * look at signature[...]
> 
> I'm pretty sure drivers/ide/pci/siimage.c already does the 
> bring-it-out-of-low-power thing, twiddling the SCRs.
> 
> (the SCRs are documented in the public SATA spec on www.serialata.org)
> 
> In addition, drivers/ide/pci/siimage.c actually does initialize the 
> hardware a bit more fully than my SII driver does, IIRC...
> 
>     Jeff
> 
> 
> 


-- 

ssh aron@rubinium.org cat /dev/brain | grep ^work:

Aron Rubin                       Member, Engineering Staff
Lockheed Martin                  E-Mail: arubin@atl.lmco.com
Advanced Technology Laboratories Phone:  856.792.9865
3 Executive Campus               Fax:    856.792.9930
Cherry Hill, NJ USA 08002        Web:    http://www.atl.lmco.com



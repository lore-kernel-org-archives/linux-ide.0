From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [bisected] Re: todays git: WARNING: at drivers/ata/libata-sff.c:1017
 ata_sff_hsm_move+0x45e/0x750()
Date: Sun, 11 Jan 2009 12:18:14 +0300
Message-ID: <4969B956.6010802@ru.mvista.com>
References: <200901091334.55823.borntraeger@de.ibm.com>	<200901101009.13699.borntraeger@de.ibm.com>	<20090110104114.633cacd8@lxorguk.ukuu.org.uk>	<200901101242.05203.borntraeger@de.ibm.com>	<49688B63.5030105@ru.mvista.com>	<20090110122130.318cf168@lxorguk.ukuu.org.uk>	<20090110130745.GA14049@elte.hu>	<49689EA8.20506@garzik.org>	<20090110132412.GB14049@elte.hu>	<20090110133617.GA22304@elte.hu>	<20090110135731.0da08c90@lxorguk.ukuu.org.uk>	<4968BA6F.8050207@ru.mvista.com>	<20090110152800.44308491@lxorguk.ukuu.org.uk>	<4968C5CA.6010508@ru.mvista.com>	<4968FFD7.6070302@ru.mvista.com> <20090111001038.33943d2e@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:6877 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750917AbZAKJSV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Jan 2009 04:18:21 -0500
In-Reply-To: <20090111001038.33943d2e@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ingo Molnar <mingo@elte.hu>, Jeff Garzik <jeff@garzik.org>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>

Hello.

Alan Cox wrote:

>>>>     data_xfer transfers 18 bytes + 2 padding (correctly) -> 20 bytes
>>>>         
>>    Correctly indeed? I'm not at all sure it's correct to read an extra 
>> 16-bit word off the device when it thinks it's already done with the 
>> data transfer.
>>     

   OTOH, once can generally read the data register with no command 
active and not have anything locked up, so I'm not sure of how risky 
this can be... it's better to exclude such risk though.

> The VLB controller docs explicitly require you do entirely 32bit.

   Didn't VLB contollers largely predate ATAPI devices?

> The AMD ones seem to imply you should.
>   

   Indeed, AMD-8111 datasheet requires 32-bit writes -- but only when 
the write buffer is enabled.

> Its easy enough to not do that but for the VLB case we have to so the
> WARN needs fixing which ever path we go down.
>   

   Sure.

MBR, Sergei



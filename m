From: "Christian P. Schmidt" <schmidt@digadd.de>
Subject: Re: Support for Marvel 6141 in ahci.c
Date: Sat, 10 Jan 2009 15:54:51 +0300
Message-ID: <49689A9B.2070508@digadd.de>
References: <49686AE8.1050209@digadd.de> <20090110122438.0992c319@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.digadd.de ([195.47.195.236]:48882 "EHLO mx2.digadd.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751300AbZAJMxR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 10 Jan 2009 07:53:17 -0500
In-Reply-To: <20090110122438.0992c319@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Hi Alan,

Alan Cox wrote:
> On Sat, 10 Jan 2009 12:31:20 +0300
> "Christian P. Schmidt" <schmidt@digadd.de> wrote:
> 
>> Hi all,
>>
>> The Marvell 6141
>> 08:00.0 SATA controller: Marvell Technology Group Ltd. 88SE614x SATA II PCI-E controller (rev 01)
>> 08:00.0 0106: 11ab:6141 (rev 01)
>> seems to work with the ahci driver with the attached patch:
> 
> Try using the PATA port.

Sorry, can't do - the chip is on an ASUS M2N32 WS Professional mainboard where the PATA is only on the MCP55.

> For 2.6.29 we can probably add this ID to AHCI now as our AHCI code
> ignores Marvell devices when the pata_marvell driver is present.

pata_marvell.c doesn't seem to have support for the 6141 anyway, so there is no conflict.

Regards,
Chris

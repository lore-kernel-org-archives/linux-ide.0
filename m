From: Jean-Louis Dupond <info@dupondje.be>
Subject: Re: sata_mv not working with a RocketRaid 2220
Date: Tue, 18 Dec 2007 16:27:12 +0100
Message-ID: <4767E6D0.7010408@dupondje.be>
References: <4766562B.8090609@dupondje.be> <4766FBBF.5020606@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from powered.by.stone-is.net ([87.238.163.201]:60299 "EHLO
	vps.dupondje.be" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755282AbXLRP20 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Dec 2007 10:28:26 -0500
In-Reply-To: <4766FBBF.5020606@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Noticed it yet its not the best driver around, but its weird it almost 
can initialize 1 device on the controller (sdb), and the rest totally fails.

Tried to put each disk in a JBOD, but that doesn't fix it neither.

Anyway thank you for the reply. Think i'll get some better controller :)

Mark Lord schreef:
> Jean-Louis Dupond wrote:
>> Added CC to linux-ide
>>
>> -------- Originele bericht --------
>> Onderwerp:     sata_mv not working with a RocketRaid 2220
>> Datum:     Mon, 17 Dec 2007 00:15:30 +0100
>> Van:     Jean-Louis Dupond <info@dupondje.be>
>> Aan:     linux-kernel@vger.kernel.org
>>
>>
>>
>> Hello,
>>
>> I'm trying to get my HighPoint RocketRaid Controller working with the 
>> sata_mv drivers.
>> But something is not working correctly :(
>>
>> Kernel version 2.6.23.11 (also tried 2.6.24-rc5 with same results)
>> Controller in lspci: Marvell Technology Group Ltd. MV88SX6081 8-port 
>> SATA II PCI-X Controller (rev 07)
>>
> ..
> 
> The sata_mv driver is currently not very good,
> but should improve over this winter as some effort
> is finally going into fixing it.
> 
> And the Highpoint RocketRAID cards are a similarly dubious choice,
> as their onboard BIOS is known to corrupt filesystems before Linux
> is even booted.
> 
> In particular, an "unconfigured" drive -- just plugged into a RR card
> without entering the BIOS setup to configure a RAID -- gets sector 8 
> overwritten by the BIOS.  This will destroy GRUB if it was installed.
> And for drives which *have* been configured in the RR BIOS,
> it overwrites a sector at the end of the final full GB on the drive,
> for holding RR metadata.
> 
> Cheers
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

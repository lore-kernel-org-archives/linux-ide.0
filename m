From: Sylvain Munaut <tnt@246tNt.com>
Subject: Re: [PATCH/RFC] ata: Add support for the MPC52xx ATA controller using
 libata
Date: Fri, 17 Nov 2006 20:12:07 +0100
Message-ID: <455E0987.7000809@246tNt.com>
References: <11637151391017-git-send-email-tnt@246tNt.com> <20061116234601.78325642@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outmx003.isp.belgacom.be ([195.238.4.100]:50074 "EHLO
	outmx003.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1752261AbWKQTMY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 17 Nov 2006 14:12:24 -0500
Received: from outmx003.isp.belgacom.be (localhost [127.0.0.1])
        by outmx003.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22) with ESMTP id kAHJCJVB016251
        for <linux-ide@vger.kernel.org>; Fri, 17 Nov 2006 20:12:20 +0100
        (envelope-from <tnt@246tNt.com>)
In-Reply-To: <20061116234601.78325642@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Linux PPC Embedded <linuxppc-embedded@ozlabs.org>, Linux IDE <linux-ide@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Nicolas DET <nd@bplan-gmbh.de>, Sven Luther <sl@bplan-gmbh.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, John Rigby <jcrigby@gmail.com>

Alan wrote:
> On Thu, 16 Nov 2006 23:12:19 +0100
> Sylvain Munaut <tnt@246tNt.com> wrote:
>
>   
>> * The manual states we should check for the TIP bit before all
>> PIO transaction. That's not really supported by libata and requires
>> reimplementing almost all the hooks. But after talking to Freescale,
>> it turnsout it's not really necessary. So this driver doesn't implement
>> that check. I noticed no problem so far ...
>>
>>     
>
> All PIO transactions meaning each PIO command sequence or each register
> read/write ? In the former case is it not enough just to wrap the command
> write ?
>   
Each register write apparently.

>> * This driver doesn't use the standard function to compute timing
>> because the 5200 needs more timing parameters that are not handled
>> by the generic call (ta and t4).
>>     
>
> I'd rather the generic code was taught to compute any extra times you
> need but it seems clean enough.
>   
Well, I can do that as well. It should be simple enough and not
interfere with
the existing drivers.


Sylvain


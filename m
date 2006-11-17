From: Sylvain Munaut <tnt@246tNt.com>
Subject: Re: [PATCH/RFC] ata: Add support for the MPC52xx ATA controller using
 libata
Date: Fri, 17 Nov 2006 20:09:59 +0100
Message-ID: <455E0907.8000009@246tNt.com>
References: <11637151391017-git-send-email-tnt@246tNt.com> <200611172049.49260.jarno.manninen@tut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outmx009.isp.belgacom.be ([195.238.5.4]:36769 "EHLO
	outmx009.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1755708AbWKQTKU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 17 Nov 2006 14:10:20 -0500
Received: from outmx009.isp.belgacom.be (localhost [127.0.0.1])
        by outmx009.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22) with ESMTP id kAHJA9ce020909
        for <linux-ide@vger.kernel.org>; Fri, 17 Nov 2006 20:10:09 +0100
        (envelope-from <tnt@246tNt.com>)
In-Reply-To: <200611172049.49260.jarno.manninen@tut.fi>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jarno Manninen <jarno.manninen@tut.fi>
Cc: linuxppc-embedded@ozlabs.org, Linux IDE <linux-ide@vger.kernel.org>, Sven Luther <sl@bplan-gmbh.de>

Jarno Manninen wrote:
> On Friday 17 November 2006 00:12, Sylvain Munaut wrote:
>
>   
>> * The manual states we should check for the TIP bit before all
>> PIO transaction. That's not really supported by libata and requires
>> reimplementing almost all the hooks. But after talking to Freescale,
>> it turnsout it's not really necessary. So this driver doesn't implement
>> that check. I noticed no problem so far ...
>>     
>
> I've had some bad experiences with 2.4 line kernel when using BAPI 2.2 on Rev. 
> A 5200 while imposing heavy I/O load. Problems manifested as hanging XLB-bus 
> and so on. Funny thing is that combinations like Rev.A + BAPI 2.1 and Rev.B + 
> BAPI 2.[12] seem to be immune while doing similar stress tests.
>
> Problems went away after wrapping PIO access like this:
>
> 1. Stop XLB-pipelining
> 2. Wait for TIP bit to go down.
> 3. Do the access
> 4. Restore XLB-pipelining.
>
> Just polling for the TIP bit is not enough due to errata on Rev. A if the 
> pipelining is enabled.
>
> Just in case if someone else is having mysterious hangs on Rev.A:s with newer 
> microcode. :)
>   
Thanks for the info ! I'll certainly try to remember that.


The currentl kernel doesn't handle DMA so far so there is no problem and
we deactivate
XLB pipelining.

Since the current libata doesn't really support overriding IO accessors,
I'd keep it like
that for now. Apparently some other architecture needs special IO stuff
so we could see
a way to hook io accessor soon, and then we can change it if we notice
big problems.


    Sylvain

From: Brad Campbell <brad@wasp.net.au>
Subject: Re: Support for Marvel 6141 in ahci.c
Date: Sat, 10 Jan 2009 23:55:52 +0900
Message-ID: <4968B6F8.9050005@wasp.net.au>
References: <49686AE8.1050209@digadd.de> <20090110122438.0992c319@lxorguk.ukuu.org.uk> <49689A9B.2070508@digadd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 50.38.69.212.in-addr.fnarfbargle.com ([93.93.128.63]:44311 "EHLO
	fnarfbargle.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751913AbZAJPin (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Jan 2009 10:38:43 -0500
In-Reply-To: <49689A9B.2070508@digadd.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Christian P. Schmidt" <schmidt@digadd.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Christian P. Schmidt wrote:
> Hi Alan,
> 
> Alan Cox wrote:
>> On Sat, 10 Jan 2009 12:31:20 +0300
>> "Christian P. Schmidt" <schmidt@digadd.de> wrote:
>>
>>> Hi all,
>>>
>>> The Marvell 6141
>>> 08:00.0 SATA controller: Marvell Technology Group Ltd. 88SE614x SATA 
>>> II PCI-E controller (rev 01)
>>> 08:00.0 0106: 11ab:6141 (rev 01)
>>> seems to work with the ahci driver with the attached patch:
>>
>> Try using the PATA port.
> 
> Sorry, can't do - the chip is on an ASUS M2N32 WS Professional mainboard 
> where the PATA is only on the MCP55.

How is that working for you? I did the same style of patch back in 2.6.26 (on the same board) and 
found it died _hard_ when writing to more than one port at a time. It worked with only one drive 
attached though, although I could not get hot plugging to work either.

Regards,
Brad
-- 
Dolphins are so intelligent that within a few weeks they can
train Americans to stand at the edge of the pool and throw them
fish.

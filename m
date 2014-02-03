From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [patch v2 1/3] drivers: phy: Make NULL a valid phy reference
Date: Mon, 03 Feb 2014 22:17:24 +0300
Message-ID: <52EFEB44.30208@cogentembedded.com>
References: <52EF6D38.4060200@ti.com> <1391450446-15580-1-git-send-email-andrew@lunn.ch> <52EFE8A1.8010206@cogentembedded.com> <20140203181311.GA15442@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:51096 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289AbaBCSRG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Feb 2014 13:17:06 -0500
Received: by mail-la0-f47.google.com with SMTP id hr17so5618564lab.20
        for <linux-ide@vger.kernel.org>; Mon, 03 Feb 2014 10:17:05 -0800 (PST)
In-Reply-To: <20140203181311.GA15442@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: tj@kernel.org, kishon@ti.com, Jason Cooper <jason@lakedaemon.net>, Gregory Clement <gregory.clement@free-electrons.com>, linux-ide@vger.kernel.org

On 02/03/2014 09:13 PM, Andrew Lunn wrote:

>>> The common clock framework considers NULL a valid clock
>>> reference. This makes handling optional clocks simple, in that if the
>>> optional clock is not available, a NULL reference can be used in the
>>> place of a real clock, simplifying the clock consumer.

>>> Extend this concept to the phy consumer API. A NULL can be passed to
>>> the release calls, the phy_init() and phy_exit() calls, and
>>> phy_power_on() and phy_power_off() and a NOP is performed.

>>> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
>> [...]

>>>   When the controller no longer needs the PHY, it has to release the reference
>>> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
>>> index 645c867c1257..56535253e50c 100644
>>> --- a/drivers/phy/phy-core.c
>>> +++ b/drivers/phy/phy-core.c
>> [...]
>>> @@ -308,6 +320,9 @@ err0:
>>>    */
>>>   void phy_put(struct phy *phy)
>>>   {
>>> +	if (!phy)
>>> +		return;
>>> +
>>>   	if (IS_ERR(phy))
>>>   		return;

>>     Why not merge these two?

> Hi Sergei

> Have you heard Russell King talk about IS_ERR_NULL()?

    Probably not but I didn't think of it actually, just:

	if (!phy || IS_ERR(phy))
		return;

PS: BTW, I'm not sure why phy_put() has to handle error pointers...

>       Andrew

WBR, Sergei


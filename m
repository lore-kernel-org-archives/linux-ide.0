From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 1/5] Phy: DT binding documentation for Marvell MVEBU SATA
 phy.
Date: Wed, 11 Dec 2013 11:11:01 +0530
Message-ID: <52A7FAED.7080103@ti.com>
References: <1386177364-10164-1-git-send-email-andrew@lunn.ch> <1386177364-10164-2-git-send-email-andrew@lunn.ch> <52A01742.2080405@ti.com> <20131205094319.GD10498@lunn.ch> <20131210225900.GB17875@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39853 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774Ab3LKFlO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Dec 2013 00:41:14 -0500
In-Reply-To: <20131210225900.GB17875@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org, linux-ide@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>

Hi,

On Wednesday 11 December 2013 04:29 AM, Andrew Lunn wrote:
> On Thu, Dec 05, 2013 at 10:43:19AM +0100, Andrew Lunn wrote:
>>>>  Example:
>>>>  
>>>>  	sata@80000 {
>>>>  		compatible = "marvell,orion-sata";
>>>>  		reg = <0x80000 0x5000>;
>>>>  		interrupts = <21>;
>>>> +		phys = <&sata_phy0>, <&sata_phy1>;
>>>> +		phy-names = "0", "1";
>>>
>>> more descriptive phy-names? sata-phy0?
>>>>  		nr-ports = <2>;
>>
>> I could do, but i was following how the clocks work. Unfortunately,
>> the binding documentation is out of date and does not contain
>> clocks. A real example is:
>>
>>               sata@80000 {
>>                       compatible = "marvell,orion-sata";
>>                       reg = <0x80000 0x5000>;
>>                       interrupts = <21>;
>>                       clocks = <&gate_clk 14>, <&gate_clk 15>;
>>                       clock-names = "0", "1";
>>                       phys = <&sata_phy0>, <&sata_phy1>;
>>                       phy-names = "0", "1";
>>                       status = "disabled";
>>               };
>>
>> So clocks and the phy are described nearly identically. I can however
>> handle phys differently if you wish.
> 
> Hi Kishon
> 
> Please could you comment on this. Are you O.K. if i use the same
> naming scheme for phys as clocks?

I'd prefer descriptive names for phys.

Thanks
Kishon

From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v4 2/4] Phy: Add a PHY driver for Marvell MVEBU SATA PHY.
Date: Sat, 11 Jan 2014 16:42:43 +0530
Message-ID: <52D1272B.7050601@ti.com>
References: <20131219194237.GC22725@htj.dyndns.org> <1388078742-6726-1-git-send-email-andrew@lunn.ch> <1388078742-6726-3-git-send-email-andrew@lunn.ch> <52BDABD2.9080701@ti.com> <20140110193130.GS19878@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39492 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195AbaAKLM7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Jan 2014 06:12:59 -0500
In-Reply-To: <20140110193130.GS19878@titan.lakedaemon.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>, tj@kernel.org, devicetree@vger.kernel.org, linux-ide@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>

Hi Jason,

On Saturday 11 January 2014 01:01 AM, Jason Cooper wrote:
> On Fri, Dec 27, 2013 at 10:03:22PM +0530, Kishon Vijay Abraham I wrote:
>> Hi,
>>
>> On Thursday 26 December 2013 10:55 PM, Andrew Lunn wrote:
>>> Kirkwood and Dove can turn the SATA phy on and off. Add a PHY driver
>>> to control this.
>>>
>>> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
>>> ---
>>> v1->v2:
>>> Use #defines instead of magic values
>>> select GENERIC_PHY in Kconfig.
>>>
>>> v3->v4
>>>
>>> Register phy_provider as the last step.
>>
>> The previous version is already sent to be merged. We can have the
>> new change merged in the rc cycle.
>
> Kishon,
>
> Looking at the patch dependencies, we'd like to keep the sata change in
> the same branch as the phy changes.  Would you mind picking that one up
> and placing it in the same branch as the ones you already took?  I have

PHY changes go in Greg's tree and he generally closes it ~2 weeks before 
the start of merge window. So it's too late to go in PHY tree for this 
merge window. Sorry.

Thanks
Kishon

From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: PDC20269: Limit on number of controllers?
Date: Wed, 23 Feb 2005 15:09:17 +0800
Message-ID: <421C2C1D.9010207@tw.ibm.com>
References: <66F9227F7417874C8DB3CEB057727417044F99@MILEX0.Miltope.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from bluehawaii.tikira.net ([61.62.22.51]:9211 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261351AbVBWHJg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Feb 2005 02:09:36 -0500
In-Reply-To: <66F9227F7417874C8DB3CEB057727417044F99@MILEX0.Miltope.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Winstel, Drew" <DWinstel@Miltope.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>


Winstel, Drew wrote:

> I am not sure whether you are
> correct about the PLL being initialized (I don't know
> enough about the internals to say for certain), but I
> have attached the dmesg output from 2.6.10 compiled 
> with your patch 

   Thanks for the testing and dmesg. From the dmesg, we can see
1st adapter: pll_ctl[57][D]  => PLL initialized by the firmware
2nd adapter: pll_ctl[57][D]  => PLL initialized by the firmware
3rd adapter: pll_ctl[58][4D] => PLL uninitialized
4th adapter: pll_ctl[58][4D] => PLL uninitialized

So, the firmware on the pdc20269 only initialize the 1st and 2nd adapters.
PLL of adapter 3/4 are left uninitialized by the firmware.

The pdc202xx_new driver relies on the firmware to initialize the PLL.
That's why adapter 3/4 won't work.

> I have yet to test ATAPI devices on it.  
With 2.6.10 + pdc20269, there is a known problem on ATAPI DMA.
Please use 2.6.11 to test ATAPI.


Albert



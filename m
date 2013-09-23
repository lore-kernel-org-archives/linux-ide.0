From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [RFC PATCH 08/15] ata: ahci_platform: Manage SATA PHY
Date: Mon, 23 Sep 2013 18:10:30 +0400
Message-ID: <52404BD6.9070101@cogentembedded.com>
References: <1379595943-14622-1-git-send-email-rogerq@ti.com> <1379595943-14622-9-git-send-email-rogerq@ti.com> <523F3567.80303@cogentembedded.com> <20130922214859.GC27616@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20130922214859.GC27616@mtj.dyndns.org>
Sender: linux-omap-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Roger Quadros <rogerq@ti.com>, balbi@ti.com, bcousson@baylibre.com, tony@atomide.com, balajitk@ti.com, kishon@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello.

On 09/23/2013 01:48 AM, Tejun Heo wrote:

>>> @@ -37,6 +37,7 @@

>>>   #include <linux/clk.h>
>>>   #include <linux/libata.h>
>>> +#include <linux/phy/phy.h>

>> struct phy;

>> should suffice.

> Unless it's actually likely to cause inclusion loop, I think it's
> better to include the header than adding explicit declarations.

    Apparently, tastes differ here. E.g. Greg KH would have also told Roger to 
use forward declaration in such case. :-)

> Thanks.

WBR, Sergei


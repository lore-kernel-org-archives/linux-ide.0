From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v2 2/2] ata: ahci_platform: runtime resume the device
 before use
Date: Fri, 18 Oct 2013 15:24:00 +0300
Message-ID: <52612860.6020104@ti.com>
References: <1381923773-10596-1-git-send-email-rogerq@ti.com> <1381923773-10596-3-git-send-email-rogerq@ti.com> <1662147.qHgNzWWiSr@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39177 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753152Ab3JRMYL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 18 Oct 2013 08:24:11 -0400
In-Reply-To: <1662147.qHgNzWWiSr@amdc1032>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: tj@kernel.org, sergei.shtylyov@cogentembedded.com, kishon@ti.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Balaji T K <balajitk@ti.com>

Hi,

On 10/17/2013 05:15 PM, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> On Wednesday, October 16, 2013 02:42:53 PM Roger Quadros wrote:
>> On OMAP platforms the device needs to be runtime resumed before
>> it can be accessed. The OMAP HWMOD framework takes care of
>> enabling the module and its resources based on the
>> device's runtime PM state.
>>
>> In this patch we runtime resume during .probe() and runtime suspend
>> during .remove() (i.e. ahci_host_stop()).
>>
>> We also update the runtime PM state during .resume().
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> Signed-off-by: Balaji T K <balajitk@ti.com>
>> ---
>>  drivers/ata/ahci_platform.c |   12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
>> index 5a0f1418..0da3b95 100644
>> --- a/drivers/ata/ahci_platform.c
>> +++ b/drivers/ata/ahci_platform.c
>> @@ -23,6 +23,7 @@
>>  #include <linux/platform_device.h>
>>  #include <linux/libata.h>
>>  #include <linux/ahci_platform.h>
>> +#include <linux/pm_runtime.h>
>>  #include "ahci.h"
>>  
>>  static void ahci_host_stop(struct ata_host *host);
>> @@ -141,6 +142,9 @@ static int ahci_probe(struct platform_device *pdev)
>>  		}
>>  	}
>>  
>> +	pm_runtime_enable(dev);
>> +	pm_runtime_get_sync(dev);
>> +
>>  	hpriv->phy = devm_phy_get(dev, "sata-phy");
>>  	if (IS_ERR(hpriv->phy)) {
>>  		dev_dbg(dev, "can't get sata-phy\n");
>> @@ -268,6 +272,9 @@ static void ahci_host_stop(struct ata_host *host)
>>  		clk_disable_unprepare(hpriv->clk);
>>  		clk_put(hpriv->clk);
>>  	}
>> +
>> +	pm_runtime_put_sync(dev);
>> +	pm_runtime_disable(dev);
> 
> It would be better to add proper .remove callback (i.e. named
> ahci_remove_one) and put this code there so it matches .probe
> callback.

After ahci host is started (i.e. probe succeeded), ahci_host_stop() is called
when the device resources are freed via devres management. So, we don't really
need to do this again in the .remove callback.

If we want to do all that in .remove then everything that is done in ahci_host_stop()
must be done in .remove() and ahci_host_stop() becomes a nop.

cheers,
-roger

> 
>>  }
>>  
>>  #ifdef CONFIG_PM_SLEEP
>> @@ -339,6 +346,11 @@ static int ahci_resume(struct device *dev)
>>  
>>  	ata_host_resume(host);
>>  
>> +	/* We resumed so update PM runtime state */
>> +	pm_runtime_disable(dev);
>> +	pm_runtime_set_active(dev);
>> +	pm_runtime_enable(dev);
>> +
>>  	return 0;
>>  
>>  disable_unprepare_clk:
> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 


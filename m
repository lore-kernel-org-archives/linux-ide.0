From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v5 07/14] ahci-platform: "Library-ise"
 ahci_probe functionality
Date: Mon, 27 Jan 2014 16:27:12 +0200
Message-ID: <52E66CC0.3080205@ti.com>
References: <1390417489-5354-1-git-send-email-hdegoede@redhat.com> <1390417489-5354-8-git-send-email-hdegoede@redhat.com> <52E63778.5000509@ti.com> <52E63A1F.6080301@redhat.com> <52E63D08.6080704@ti.com> <52E642F7.3000308@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBD45J6OZZMOBBSGZTGLQKGQENUG2Q7Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <52E642F7.3000308-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On 01/27/2014 01:28 PM, Hans de Goede wrote:
> Hi,
> 
> On 01/27/2014 12:03 PM, Roger Quadros wrote:
>> On 01/27/2014 12:51 PM, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 01/27/2014 11:39 AM, Roger Quadros wrote:
>>>> Hi,
>>>>
>>>> On 01/22/2014 09:04 PM, Hans de Goede wrote:
>>>
>>> <snip>
>>>
>>>>> --- a/include/linux/ahci_platform.h
>>>>> +++ b/include/linux/ahci_platform.h
>>>>> @@ -20,7 +20,13 @@
>>>>>    struct device;
>>>>>    struct ata_port_info;
>>>>>    struct ahci_host_priv;
>>>>> +struct platform_device;
>>>>>
>>>>> +/*
>>>>> + * Note ahci_platform_data is deprecated. New drivers which need to override
>>>>> + * any of these, should instead declare there own platform_driver struct, and
>>>>> + * use ahci_platform* functions in their own probe, suspend and resume methods.
>>>>> + */
>>>>>    struct ahci_platform_data {
>>>>>        int (*init)(struct device *dev, struct ahci_host_priv *hpriv);
>>>>>        void (*exit)(struct device *dev);
>>>>> @@ -35,5 +41,13 @@ int ahci_platform_enable_clks(struct ahci_host_priv *hpriv);
>>>>>    void ahci_platform_disable_clks(struct ahci_host_priv *hpriv);
>>>>>    int ahci_platform_enable_resources(struct ahci_host_priv *hpriv);
>>>>>    void ahci_platform_disable_resources(struct ahci_host_priv *hpriv);
>>>>> +struct ahci_host_priv *ahci_platform_get_resources(
>>>>> +    struct platform_device *pdev);
>>>>
>>>> Why not use 'struct device' as the argument?
>>>
>>> Because of calls to platform_get_resource inside the function.
>>>
>>>>> +void ahci_platform_put_resources(struct ahci_host_priv *hpriv);
>>>>
>>>> Can we have 'struct device' as the argument? Else it becomes
>>>> impossible to get 'struct device' from 'hpriv' if we need to call e.g.
>>>> pm_runtime_*() APIs.
>>>
>>> The plan for is for this function to go away once we have a
>>> devm version of of_clk_get, so if you need to put pm_runtime_calls
>>> somewhere, please don't put them here. This sounds like something which
>>> should go in enable / disable resources instead ?
>>
>> OK. I need to add pm_runtime_enable() + pm_runtime_get_sync() during
>> initialization and pm_runtime_put_sync() + pm_runtime_disable() during cleanup.
> 
> Note that enable / disable resources will get called by (the default implementations
> of) suspend / resume too.
> 
> If that is undesirable then I take back what I said before and
> ahci_platform_put_resources' prototype should be changed to:
> 
> void ahci_platform_put_resources(struct device *dev, struct ahci_host_priv *hpriv);
> 
> And we will need to keep it around even after we get devm_of_clk_get.
> 
>> If ahci_platform_enable/disable_resources is the right place then we must be
>> able to access struct device from there.
> 
> Right, and if not we need to access it from ahci_platform_put_resources(),
> which is in essence the same problem.
> 
>> Is it a good to add 'struct device *dev' into the 'struct ahci_host_priv'?
>> Then you can leave this series as is and i'll add a new patch for that.
> 
> Normally we get a device * as argument, and get to hpriv like this:
> 
>         struct ata_host *host = dev_get_drvdata(dev);
>         struct ahci_host_priv *hpriv = host->private_data;
> 
> So having a dev * in hpriv is normally not useful.
> 
> But the ata_host gets allocated after the first ahci_platform_enable_resources
> call, so we cannot use this there. Likewise disable_resources / put_resources
> is used in error handling paths in probe where we don't have an ata_host yet,
> so my vote goes to adding a "struct device *dev" as first argument, like I
> suggested above for ahci_platform_put_resources.
> 
> This can be done as an add-on patch (if you do don't forget to also fix
> ahci_sunxi.c and ahci_imx.c), or I can respin my series to have this from
> day one.
> 
> If you want me to do a respin, please let me know which fix you'll need
> (the put_resources or the enable/disable one).
> 

For now I'm using get/put_resources to enable runtime PM and enable the device
like in the below patch.

I'll make the necessary changes to ahci_platform_put_resources();

cheers,
-roger

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 5ec6fe6..965f4b4 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -23,6 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/libata.h>
 #include <linux/ahci_platform.h>
+#include <linux/pm_runtime.h>
 #include "ahci.h"
 
 static void ahci_host_stop(struct ata_host *host);
@@ -233,6 +234,9 @@ struct ahci_host_priv *ahci_platform_get_resources(
                }
        }
 
+       pm_runtime_enable(dev);
+       pm_runtime_get_sync(dev);
+
        return hpriv;
 
 free_clk:
@@ -246,6 +250,9 @@ void ahci_platform_put_resources(struct ahci_host_priv *hpriv)
 {
        int c;
 
+       pm_runtime_put_sync(dev);
+       pm_runtime_disable(dev);
+
        for (c = 0; c < AHCI_MAX_CLKS && hpriv->clks[c]; c++)
                clk_put(hpriv->clks[c]);
 }
@@ -478,6 +485,11 @@ int ahci_platform_resume(struct device *dev)
        if (rc)
                goto disable_resources;
 
+       /* We resumed so update PM runtime state */
+       pm_runtime_disable(dev);
+       pm_runtime_set_active(dev);
+       pm_runtime_enable(dev);
+
        return 0;
 
 disable_resources:

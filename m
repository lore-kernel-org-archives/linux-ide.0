From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v5 07/14] ahci-platform: "Library-ise"
 ahci_probe functionality
Date: Mon, 27 Jan 2014 13:03:36 +0200
Message-ID: <52E63D08.6080704@ti.com>
References: <1390417489-5354-1-git-send-email-hdegoede@redhat.com> <1390417489-5354-8-git-send-email-hdegoede@redhat.com> <52E63778.5000509@ti.com> <52E63A1F.6080301@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBD45J6OZZMOBBEH2TCLQKGQEYVHBFIA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <52E63A1F.6080301-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On 01/27/2014 12:51 PM, Hans de Goede wrote:
> Hi,
> 
> On 01/27/2014 11:39 AM, Roger Quadros wrote:
>> Hi,
>>
>> On 01/22/2014 09:04 PM, Hans de Goede wrote:
> 
> <snip>
> 
>>> --- a/include/linux/ahci_platform.h
>>> +++ b/include/linux/ahci_platform.h
>>> @@ -20,7 +20,13 @@
>>>   struct device;
>>>   struct ata_port_info;
>>>   struct ahci_host_priv;
>>> +struct platform_device;
>>>
>>> +/*
>>> + * Note ahci_platform_data is deprecated. New drivers which need to override
>>> + * any of these, should instead declare there own platform_driver struct, and
>>> + * use ahci_platform* functions in their own probe, suspend and resume methods.
>>> + */
>>>   struct ahci_platform_data {
>>>       int (*init)(struct device *dev, struct ahci_host_priv *hpriv);
>>>       void (*exit)(struct device *dev);
>>> @@ -35,5 +41,13 @@ int ahci_platform_enable_clks(struct ahci_host_priv *hpriv);
>>>   void ahci_platform_disable_clks(struct ahci_host_priv *hpriv);
>>>   int ahci_platform_enable_resources(struct ahci_host_priv *hpriv);
>>>   void ahci_platform_disable_resources(struct ahci_host_priv *hpriv);
>>> +struct ahci_host_priv *ahci_platform_get_resources(
>>> +    struct platform_device *pdev);
>>
>> Why not use 'struct device' as the argument?
> 
> Because of calls to platform_get_resource inside the function.
> 
>>> +void ahci_platform_put_resources(struct ahci_host_priv *hpriv);
>>
>> Can we have 'struct device' as the argument? Else it becomes
>> impossible to get 'struct device' from 'hpriv' if we need to call e.g.
>> pm_runtime_*() APIs.
> 
> The plan for is for this function to go away once we have a
> devm version of of_clk_get, so if you need to put pm_runtime_calls
> somewhere, please don't put them here. This sounds like something which
> should go in enable / disable resources instead ?

OK. I need to add pm_runtime_enable() + pm_runtime_get_sync() during
initialization and pm_runtime_put_sync() + pm_runtime_disable() during cleanup.

If ahci_platform_enable/disable_resources is the right place then we must be
able to access struct device from there. 

Is it a good to add 'struct device *dev' into the 'struct ahci_host_priv'?
Then you can leave this series as is and i'll add a new patch for that.

If there is a better way, please let me know.

cheers,
-roger

From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v5 08/14] ahci-platform: "Library-ise"
 suspend / resume functionality
Date: Tue, 04 Feb 2014 11:20:53 +0100
Message-ID: <52F0BF05.8080607@redhat.com>
References: <1390417489-5354-1-git-send-email-hdegoede@redhat.com> <1390417489-5354-9-git-send-email-hdegoede@redhat.com> <201402031553.46083.arnd@arndb.de>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBE76YKLQKGQEJTAYPAA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <201402031553.46083.arnd-r2nGTMty4D4@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

Hi,

On 02/03/2014 03:53 PM, Arnd Bergmann wrote:
> On Wednesday 22 January 2014, Hans de Goede wrote:
>> --- a/include/linux/ahci_platform.h
>> +++ b/include/linux/ahci_platform.h
>> @@ -50,4 +50,11 @@ int ahci_platform_init_host(struct platform_device *pdev,
>>                             unsigned int force_port_map,
>>                             unsigned int mask_port_map);
>>  
>> +#ifdef CONFIG_PM_SLEEP
>> +int ahci_platform_suspend_host(struct device *dev);
>> +int ahci_platform_resume_host(struct device *dev);
>> +int ahci_platform_suspend(struct device *dev);
>> +int ahci_platform_resume(struct device *dev);
>> +#endif
>> +
> 
> Not sure if the #ifdef does any good here. Normally, we don't hide declarations
> so we can do stuff like

Thanks for the review, I'll remove the #ifdef in the next version of this patch-set.

Regards,

Hans

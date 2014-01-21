From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v5 0/4] ata: ahci_platform: Add PHY support and OMAP support
Date: Tue, 21 Jan 2014 13:59:16 +0200
Message-ID: <52DE6114.20601@ti.com>
References: <1390228888-5537-1-git-send-email-rogerq@ti.com> <52DD5368.5020301@redhat.com> <52DE3132.3000007@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52DE3132.3000007-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org
Cc: sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On 01/21/2014 10:34 AM, Roger Quadros wrote:
> On 01/20/2014 06:48 PM, Hans de Goede wrote:
>> Hi,
>>
>> On 01/20/2014 03:41 PM, Roger Quadros wrote:
>>> Hi,
>>>
>>> Some platforms have a PHY hooked up to the SATA controller.
>>> The PHY needs to be initialized and powered up for SATA to work.
>>> We do that using the Generic PHY framework in PATCH 3.
>>>
>>> In order to support SATA on the OMAP platforms we need to runtime
>>> resume the device before use. PATCH 4 takes care of that.
>>
>> Thanks for keeping me in the loop on this. I'm afraid this conflicts
>> quite a bit with my recent ahci_platform.c work, not a big problem
>> really, the series can go in either way.
>>
>> Your phy support will slot nicely into the new ahci_platform_get_resources
>> and ahci_platform_enable_resources functions my refactoring introduces,
>> looking at it from this pov it might be better / easier to rebase your series
>> on top of the v4 of my series I've just send.
>>
>> Which brings me to one comment about your series why are you not doing phy_exit
>> and phy_init on suspend resp. resume ? The phy can use quite a bit of power,
>> if the phy init / exit end up in ahci_platform_enable_resources /
>> ahci_platform_disable_resources, this will happen automatically for better or
>> worse. So it would be good to test if this would work or not ...
> 
> Right. Bartlomiej had pointed this out earlier, but I just wasn't very sure about it.
> 
> Is it sufficient to just call phy_power_off() in suspend and phy_power_on() in resume?
> Or do we call phy_exit() and phy_init() respectively as well.
> 
> Kishon, any suggestions?

OK. Answering my own question.

On OMAP platform we power down the phy in phy_power_off() and idle the DPLL in phy_exit(),
so my guess is both should be called in suspend() to save the most power.

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

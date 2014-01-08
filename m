From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v3 2/3] ata: ahci_platform: Manage SATA PHY
Date: Wed, 08 Jan 2014 16:55:04 +0100
Message-ID: <52CD74D8.4080808@redhat.com>
References: <1389174428-31414-1-git-send-email-rogerq@ti.com> <1389174428-31414-3-git-send-email-rogerq@ti.com> <52CD2176.6050102@ti.com> <6214646.nAF6lzWV79@wuerfel> <52CD364F.4060104@ti.com> <52CD4F2A.9080301@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52CD4F2A.9080301-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

Hi,

On 01/08/2014 02:14 PM, Hans de Goede wrote:
> Hi,
>
> On 01/08/2014 12:28 PM, Roger Quadros wrote:
>> On 01/08/2014 03:35 PM, Arnd Bergmann wrote:
>>> On Wednesday 08 January 2014 15:29:18 Kishon Vijay Abraham I wrote:
>>>>> +     hpriv->phy = devm_phy_get(dev, "sata-phy");
>>>>> +     if (IS_ERR(hpriv->phy)) {
>>>>> +             dev_dbg(dev, "can't get sata-phy\n");
>>>>> +             /* return only if -EPROBE_DEFER */
>>>>> +             if (PTR_ERR(hpriv->phy) == -EPROBE_DEFER) {
>>>>> +                     rc = -EPROBE_DEFER;
>>>>> +                     goto disable_unprepare_clk;
>>>>> +             }
>>>>> +     }
>>>
>>> This should probably check for all errors except "not present"
>>> rather than checking for -EPROBE_DEFER. We want to abort the
>>> probe function for deferred probe as well as the case where we
>>> a PHY was listed but isn't working properly.
>>
>> OK.
>>
>>>
>>>>> +     if (!IS_ERR(hpriv->phy)) {
>>>>> +             phy_init(hpriv->phy);
>>>>
>>>> Don't we have to check the return values of phy_init and phy_power_on? Is it
>>>> not needed because it is an optional phy?
>>>
>>> Right. I think we should set hpriv->phy to NULL if it's not there and
>>> then call the functions only if it's actually present but bail out on
>>> an error.
>>
>> OK. How does this look?
>>
>> hpriv->phy = devm_phy_get(dev, "sata-phy");
>> if (IS_ERR(hpriv->phy)) {
>>     if (PTR_ERR(hpriv->phy) == -ENODEV)
>>         goto continue;
>
> -ENODEV is not the right errno to check for,
> if there is no phy specified in the dt then
> you will get -EINVAL (no phy-names property) or
> -ENODATA (phy-names property is there but name
> not found).
>
> Also you don't want to log an error on
> PROBE_DEFERRAL.
>
> Here is what I've for similar code I'm working on
> for ehci-platform.c and ohci-platform.c :
>
>                  priv->phy = devm_phy_get(&dev->dev, "phy0");
>                  if (IS_ERR(priv->phy)) {
>                          err = PTR_ERR(priv->phy);
>                          if (err != -EINVAL && err != -ENODATA) {
>                                  if (err != -EPROBE_DEFER)
>                                          dev_err(&dev->dev,
>                                                  "Error getting phy\n");
>                                  goto err_put_hcd;
>                          }
>                          priv->phy = NULL;
>                  }

Scrap that I was reading the code wrong. Indeed if there is no
devicetree phy info it will return -ENODEV. Actually it will only ever
return one of -ENOPROBE or -ENODEV, so only checking for -ENOPROBE and
then fail silently be enough. This also has the advantage of being
future proof, if the error code for no phy found ever changes,
things won't break.

Regards,

Hans
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

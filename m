From: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 2/3] ata: ahci-platform: Add ports-implemented dt
 bindings.
Date: Tue, 29 Mar 2016 15:43:06 +0100
Message-ID: <56FA947A.5080806@linaro.org>
References: <1459257075-21393-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1459257075-21393-3-git-send-email-srinivas.kandagatla@linaro.org>
 <CAL_JsqLhSz1qWj01mAAg4X89hb4LnYB-CjJ2d1JW=jJw66Oq=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL_JsqLhSz1qWj01mAAg4X89hb4LnYB-CjJ2d1JW=jJw66Oq=g@mail.gmail.com>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andy Gross <andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, jmaggard10-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-ide@vger.kernel.org



On 29/03/16 15:11, Rob Herring wrote:
> On Tue, Mar 29, 2016 at 8:11 AM, Srinivas Kandagatla
> <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>> On some SOCs PORTS_IMPL register value is never programmed by the BIOS
>
> s/BIOS/firmware/
BIOS is the word used in the AHCI SPECS so want to stick to this.
>
> You do plan to fix this in your firmware/bootloader, too, right?

No. This feature was working just before v4.5, we have no plans to fix 
this in firmware as of today.
>
>> and left at zero value. Which means that no sata ports are avaiable for
>> software. AHCI driver used to cope up with this by fabricating the
>> port_map if the PORTS_IMPL register is read zero, but recent patch
>> broke this workaround as zero value was valid for nvme disks.
>
> s/nvme/NVMe/

Yep, will fix it.
>
>>
>> This patch adds ports-implemented dt bindings as workaround for this issue
>
> s/dt/DT/
Ok, will fix it.

>
>> in a way that DT can dictate the port_map incase where the SOCs does not
>> program it already.
>
> port_map is a Linux term.
Yes, I can rephrase it to ports implemented.
>
> ...can override the PORTS_IMPL register in cases where the firmware
> did not program it already.
>
>>
>> Fixes: 566d1827df2e ("libata: disable forced PORTS_IMPL for >= AHCI 1.3)
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> ---
>>   Documentation/devicetree/bindings/ata/ahci-platform.txt | 11 +++++++++++
>>   drivers/ata/ahci_platform.c                             |  4 ++++
>>   2 files changed, 15 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
>> index 30df832..8165db3 100644
>> --- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
>> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
>> @@ -32,6 +32,10 @@ Optional properties:
>>   - target-supply     : regulator for SATA target power
>>   - phys              : reference to the SATA PHY node
>>   - phy-names         : must be "sata-phy"
>> +- ports-implemented : Mask that indicates which ports that the HBA supports
>> +                     are available for software to use. Useful if PORTS_IMPL
>> +                     is not programmed by the BIOS, which is true with
>> +                     some embedded SOC's.
>>
>>   Required properties when using sub-nodes:
>>   - #address-cells    : number of cells to encode an address
>> @@ -59,6 +63,13 @@ Examples:
>>                  target-supply = <&reg_ahci_5v>;
>>          };
>>
>> +       sata0: sata@29000000 { /* Qualcomm APQ8064 */
>
> Do you really need another example just for this?
>
>> +               compatible = "generic-ahci";
>
> Where's your chip specific compatible string? You would not require a
> DT update to fix this if you had that.

Possibly, But we really are not doing anything specific in the ahci 
driver which is not generic, that might be the reason why we skipped 
this in the first place.

I agree we could solve this issue in more than one way, The only 
advantage of this new bindings would be to other platforms benefiting 
from this workaround would not have to keep adding a new compatible 
string into the ahci-platform driver.

Like Annapurna Alpine platform seems to have the same issue.

Am ok to do it either way.


thanks,
srini

>
>> +               reg = <0x29000000 0x180>;
>> +               interrupts = <GIC_SPI 209 IRQ_TYPE_NONE>;
>> +               ports-implemented = <0x1>;
>> +       };
>> +
>>   With sub-nodes:
>>          sata@f7e90000 {
>>                  compatible = "marvell,berlin2q-achi", "generic-ahci";
>> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
>> index 4044233..ec8db80 100644
>> --- a/drivers/ata/ahci_platform.c
>> +++ b/drivers/ata/ahci_platform.c
>> @@ -42,6 +42,7 @@ static int ahci_probe(struct platform_device *pdev)
>>          struct device *dev = &pdev->dev;
>>          struct ahci_host_priv *hpriv;
>>          int rc;
>> +       u32 ports_impl;
>>
>>          hpriv = ahci_platform_get_resources(pdev);
>>          if (IS_ERR(hpriv))
>> @@ -51,6 +52,9 @@ static int ahci_probe(struct platform_device *pdev)
>>          if (rc)
>>                  return rc;
>>
>> +       of_property_read_u32(dev->of_node,
>> +                            "ports-implemented", &hpriv->force_port_map);
>> +
>>          if (of_device_is_compatible(dev->of_node, "hisilicon,hisi-ahci"))
>>                  hpriv->flags |= AHCI_HFLAG_NO_FBS | AHCI_HFLAG_NO_NCQ;
>>
>> --
>> 2.5.0
>>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC v3 08/13] ahci-platform: Allow specifying
 platform_data through of_device_id
Date: Mon, 20 Jan 2014 09:35:06 +0100
Message-ID: <52DCDFBA.2070903@redhat.com>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com> <1390088935-7193-9-git-send-email-hdegoede@redhat.com> <20140120082438.GH16215@pengutronix.de>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBQV76OLAKGQEOTTSU3A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140120082438.GH16215-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-ide@vger.kernel.org

Hi,

On 01/20/2014 09:24 AM, Sascha Hauer wrote:
> On Sun, Jan 19, 2014 at 12:48:50AM +0100, Hans de Goede wrote:
>> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> ---
>>   drivers/ata/ahci_platform.c | 41 +++++++++++++++++++++++++++++------------
>>   1 file changed, 29 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
>> index 3bc2dab..0676d72 100644
>> --- a/drivers/ata/ahci_platform.c
>> +++ b/drivers/ata/ahci_platform.c
>> @@ -20,6 +20,7 @@
>>   #include <linux/init.h>
>>   #include <linux/interrupt.h>
>>   #include <linux/device.h>
>> +#include <linux/of_device.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/libata.h>
>>   #include <linux/ahci_platform.h>
>> @@ -87,6 +88,30 @@ static struct scsi_host_template ahci_platform_sht = {
>>   	AHCI_SHT("ahci_platform"),
>>   };
>>
>> +static const struct of_device_id ahci_of_match[] = {
>> +	{ .compatible = "snps,spear-ahci", },
>> +	{ .compatible = "snps,exynos5440-ahci", },
>> +	{ .compatible = "ibm,476gtr-ahci", },
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(of, ahci_of_match);
>> +
>> +static const struct ahci_platform_data *ahci_get_pdata(struct device *dev)
>> +{
>> +	struct ahci_platform_data *pdata;
>> +	const struct of_device_id *of_id;
>> +
>> +	pdata = dev_get_platdata(dev);
>> +	if (pdata)
>> +		return pdata;
>> +
>> +	of_id = of_match_device(ahci_of_match, dev);
>> +	if (of_id)
>> +		return of_id->data;
>
> I don't think it's a good idea to force of_id->data to be of type struct
> struct ahci_platform_data *. With this we don't have a place to store
> SoC specific data anymore.

?? ahci_platform_data *is* soc specific data, it allows various soc
specific overrides.

Regards,

Hans

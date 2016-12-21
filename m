From: Mikko Perttunen <cyndis-/1wQRMveznE@public.gmane.org>
Subject: Re: [v2,2/3] ata: ahci_tegra: Add support to disable features
Date: Wed, 21 Dec 2016 11:31:22 +0200
Message-ID: <268c0db6-e172-0430-b5e0-a04e74c6ee9d@kapsi.fi>
References: <1479973418-21351-3-git-send-email-pchandru@nvidia.com>
 <bb810105-4196-0594-d378-3c6a7a94b475@nvidia.com>
 <209a3fbeaf094dd992220b850cc62692@bgmail103.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <209a3fbeaf094dd992220b850cc62692-7W72rfoJkVnYuxH7O460wFaTQe2KTcn/@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Preetham Chandru <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "preetham260-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <preetham260-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Venu Byravarasu <vbyravarasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Pavan Kunapuli <pkunapuli-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

On 21.12.2016 11:12, Preetham Chandru wrote:
>
>
>> -----Original Message-----
>> From: Mikko Perttunen
>> Sent: Monday, November 28, 2016 6:09 PM
>> To: Preetham Chandru; tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org;
>> thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; preetham260-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
>> Cc: Laxman Dewangan; linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Venu Byravarasu; Pavan
>> Kunapuli; linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> Subject: Re: [v2,2/3] ata: ahci_tegra: Add support to disable features
>>
>> On 24.11.2016 09:43, PREETHAM RAMACHANDRA wrote:
>>> From: Preetham Chandru R <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>>
>>> Add support to disable DIPM, HIPM, DevSlp, partial, slumber and NCQ
>>> features from DT. By default these features are enabled.
>>>
>>
>> Why are these features disabled? Are they broken on all Tegra210 chips,
>> broken on specific boards or do they require some support from the driver
>> that is not there?
>>
>> Most likely we should hardcode the disabled features into the driver instead
>> of reading them from the device tree.
>>
>
> Yes, currently DevSlp and DIPM features are broken for t210 and t124 but devslp is fixed for tegra186.
>  Also I thought it would be nice to provide similar options for other features as well.
> Since we do not support hotplug this would help us in debugging if we face issues with certain drives during kernel boot.
> We can disable features we think are causing issues and retry.

We should put this data into the soc_data struct in the driver, since it 
is easily determined from just the compatibility string; for example

struct tegra_ahci_soc {
	...
	uint32_t quirks;
};

then

.quirks = NO_DEVSLP | NO_DIPM

or the other way around and list the features that we want to enable. 
This is also quite easy to change to test.

The device tree should also only contain information that describes the 
hardware itself, and nothing related to any specific driver's operation; 
so if there's a possibility that some feature is not working due to a 
driver issue, then the device tree definitely should not contain any 
entry disabling that feature.

(The downstream kernel can of course carry such features as patches on 
top, if required for some reason - but naturally it increases 
maintenance effort)

Thanks,
Mikko.

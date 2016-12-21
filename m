From: Mikko Perttunen <cyndis-/1wQRMveznE@public.gmane.org>
Subject: Re: [v2,1/3] ata: ahci_tegra: add support for tegra210
Date: Wed, 21 Dec 2016 11:02:26 +0200
Message-ID: <70930ea8-dc92-6a59-aa02-a7a05fc34742@kapsi.fi>
References: <1479973418-21351-2-git-send-email-pchandru@nvidia.com>
 <7a8d3270-b8b7-06f9-b8d1-39f9575645ce@nvidia.com>
 <7c1c25bc28a040df9f1f47884ad25746@bgmail103.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <7c1c25bc28a040df9f1f47884ad25746-7W72rfoJkVnYuxH7O460wFaTQe2KTcn/@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Preetham Chandru <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "preetham260-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <preetham260-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Venu Byravarasu <vbyravarasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Pavan Kunapuli <pkunapuli-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

On 21.12.2016 10:50, Preetham Chandru wrote:
>...
>>
>> Perhaps the "-sata-" should be removed from these - I believe the supply
>> name here should refer to the usage of the supplied power within the IP
>> block. The IP block here is SATA so it is clear that it is used for something
>> SATA related. If someone is better informed, please comment.
>>
>> It also looks like this doesn't include the 5V and 12V supplies which had to
>> be enabled on the Jetson TK1 to enable power output through the Molex
>> connector - do you know if the Jetson TX1 no longer needs similar to enable
>> the SATA power connector?
>>
>
> We need to keep regulator name matching with pin name. The regulatory framework and policy suggests that regulator name should match the pin name. So I have named it accordingly.
> The 5V and 12V does not seem to be required for tx1. I will take a closer look at it and if required I will push another patch for it.

Ok, that makes sense; sounds good to me.

Thanks,
Mikko.

From: Preetham Chandru <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH V3 1/3] ata: ahci_tegra: Add AHCI support for tegra210
Date: Thu, 25 May 2017 11:15:32 +0000
Message-ID: <86b5174d6eff458dbbefd70d59f96a08@bgmail103.nvidia.com>
References: <1494581650-11115-1-git-send-email-pchandru@nvidia.com>
 <1494581650-11115-2-git-send-email-pchandru@nvidia.com>
 <c3457c8e12b0402293bdea825883277f@bgmail103.nvidia.com>
 <3dfdc451-794a-832e-4985-ac56d7e1843e@kapsi.fi>
 <db35147839414c609a5dc2cde44dd998@BGMAIL104.nvidia.com>
 <6a39df12-c51d-d5b5-c126-1f264bb00ad0@kapsi.fi>
 <e7a2cbef-71c7-cffb-58d5-aac998c8e156@kapsi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <e7a2cbef-71c7-cffb-58d5-aac998c8e156-/1wQRMveznE@public.gmane.org>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mikko Perttunen <cyndis-/1wQRMveznE@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "preetham260-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <preetham260-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Venu Byravarasu <vbyravarasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Pavan Kunapuli <pkunapuli-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org



>-----Original Message-----
>From: Mikko Perttunen [mailto:cyndis-/1wQRMveznE@public.gmane.org]
>Sent: Wednesday, May 24, 2017 12:46 PM
>To: Preetham Chandru <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>; thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org;
>tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
>Cc: linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>;
>preetham260-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; Venu Byravarasu <vbyravarasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>; Pavan
>Kunapuli <pkunapuli-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>; linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>Subject: Re: [PATCH V3 1/3] ata: ahci_tegra: Add AHCI support for tegra210
>
>Also Vagrant Cascadian mentioned on IRC that the call to
>tegra_ahci_handle_quirks is currently before the definition of the function which
>causes warnings or compilation errors. So please add a declaration of the
>function before the call.
>

Okay.


>Cheers,
>Mikko.
>
>On 24.05.2017 10:14, Mikko Perttunen wrote:
>> On 24.05.2017 08:44, Preetham Chandru wrote:
>>> ...

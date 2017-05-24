From: Mikko Perttunen <cyndis-/1wQRMveznE@public.gmane.org>
Subject: Re: [PATCH V3 1/3] ata: ahci_tegra: Add AHCI support for tegra210
Date: Wed, 24 May 2017 10:15:57 +0300
Message-ID: <e7a2cbef-71c7-cffb-58d5-aac998c8e156@kapsi.fi>
References: <1494581650-11115-1-git-send-email-pchandru@nvidia.com>
 <1494581650-11115-2-git-send-email-pchandru@nvidia.com>
 <c3457c8e12b0402293bdea825883277f@bgmail103.nvidia.com>
 <3dfdc451-794a-832e-4985-ac56d7e1843e@kapsi.fi>
 <db35147839414c609a5dc2cde44dd998@BGMAIL104.nvidia.com>
 <6a39df12-c51d-d5b5-c126-1f264bb00ad0@kapsi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <6a39df12-c51d-d5b5-c126-1f264bb00ad0-/1wQRMveznE@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Preetham Chandru <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "preetham260-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <preetham260-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Venu Byravarasu <vbyravarasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Pavan Kunapuli <pkunapuli-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

Also Vagrant Cascadian mentioned on IRC that the call to 
tegra_ahci_handle_quirks is currently before the definition of the 
function which causes warnings or compilation errors. So please add a 
declaration of the function before the call.

Cheers,
Mikko.

On 24.05.2017 10:14, Mikko Perttunen wrote:
> On 24.05.2017 08:44, Preetham Chandru wrote:
>> ...

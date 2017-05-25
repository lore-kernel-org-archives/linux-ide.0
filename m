From: Preetham Chandru <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH V3 1/3] ata: ahci_tegra: Add AHCI support for tegra210
Date: Thu, 25 May 2017 11:11:45 +0000
Message-ID: <3759eceaaf5d452e9d09563bb94503ee@bgmail103.nvidia.com>
References: <1494581650-11115-1-git-send-email-pchandru@nvidia.com>
 <1494581650-11115-2-git-send-email-pchandru@nvidia.com>
 <c3457c8e12b0402293bdea825883277f@bgmail103.nvidia.com>
 <3dfdc451-794a-832e-4985-ac56d7e1843e@kapsi.fi>
 <db35147839414c609a5dc2cde44dd998@BGMAIL104.nvidia.com>
 <6a39df12-c51d-d5b5-c126-1f264bb00ad0@kapsi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <6a39df12-c51d-d5b5-c126-1f264bb00ad0-/1wQRMveznE@public.gmane.org>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mikko Perttunen <cyndis-/1wQRMveznE@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "preetham260-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <preetham260-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Venu Byravarasu <vbyravarasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Pavan Kunapuli <pkunapuli-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

>>>>> +		ahci_tegra_port_info.flags |= ATA_FLAG_NO_DIPM;
>>>
>>> Looking at the downstream device trees, it looks like DIPM and DEVSLP
>>> are still disabled for Tegra186 - so why don't we just hardcode these
>>> quirks, by always writing the MISC_CNTL_1_0 register and just adding
>>> ATA_FLAG_NO_DIPM to ahci_tegra_port_info's static definition.
>>>
>>
>> For Tegra186 the devslp pin is shared with PCIE clk req pin.
>> In downstream PCIe driver by default assumes that CLKREQ is present and it
>owns it.
>> So by default devslp is disabled. We verify devslp by making sure that
>> pcie does not own this pin. This issue will be fixed in future chips.
>
>Ok. How about DIPM, can we hardcode that? If not, or if it is fixed in Xavier, I
>think it would be cleaner to have two static port_info structs and select between
>then based on the quirk, so that we don't need to mutate the static data.
>

No, DIPM is not fixed in that chip as well. I will hardcode it now and in future when it gets fixed we can have two port_info structs as suggested.

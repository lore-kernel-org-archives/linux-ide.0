From: Patrice CHOTARD <patrice.chotard-qxv4g6HH51o@public.gmane.org>
Subject: Re: [PATCH] ata: ahci-platform: add reset control support
Date: Thu, 5 Apr 2018 13:17:45 +0000
Message-ID: <e33f54ed-2848-9a4f-9669-7fada8c60326@st.com>
References: <1521768653-11824-1-git-send-email-hayashi.kunihiko@socionext.com>
 <20180405095429.GA7506@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20180405095429.GA7506@ulmo>
Content-Language: en-US
Content-ID: <BE3B334EEE98F84BA88BFEA6331EA38F-qxv4g6HH51o@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kunihiko Hayashi <hayashi.kunihiko-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

Hi Thierry

On 04/05/2018 11:54 AM, Thierry Reding wrote:
> On Fri, Mar 23, 2018 at 10:30:53AM +0900, Kunihiko Hayashi wrote:
>> Add support to get and control a list of resets for the device
>> as optional and shared. These resets must be kept de-asserted until
>> the device is enabled.
>>
>> This is specified as shared because some SoCs like UniPhier series
>> have common reset controls with all ahci controller instances.
>>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
>> ---
>>   .../devicetree/bindings/ata/ahci-platform.txt      |  1 +
>>   drivers/ata/ahci.h                                 |  1 +
>>   drivers/ata/libahci_platform.c                     | 24 +++++++++++++++++++---
>>   3 files changed, 23 insertions(+), 3 deletions(-)
> 
> This causes a regression on Tegra because we explicitly request the
> resets after the call to ahci_platform_get_resources().

I confirm, we got exactly the same behavior on STi platform.

> 
>  From a quick look, ahci_mtk and ahci_st are in the same boat, adding the
> corresponding maintainers to Cc.
> 
> Patrice, Matthias: does SATA still work for you after this patch? This
> has been in linux-next since next-20180327.

SATA is still working after this patch, but a kernel warning is 
triggered due to the fact that resets are both requested by 
libahci_platform and by ahci_st driver.

Patrice

> 
> Given how this is one of the more hardware-specific bits, perhaps a
> better way to do this is to move reset handling into a Uniphier driver
> much like Tegra, Mediatek and ST?
> 
> That said, I don't see SATA support for any of the Socionext hardware
> either in the DT bindings or drivers/ata, so perhaps it'd be best to
> back this out again until we have something that's more well tested?
> 
> Thierry
> 

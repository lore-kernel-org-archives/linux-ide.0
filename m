From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] ata: ahci-platform: add reset control support
Date: Thu, 5 Apr 2018 15:27:03 +0200
Message-ID: <1f7d0738-1963-21c5-c293-e46fb0214ecf@redhat.com>
References: <1521768653-11824-1-git-send-email-hayashi.kunihiko@socionext.com>
 <20180405095429.GA7506@ulmo> <e33f54ed-2848-9a4f-9669-7fada8c60326@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e33f54ed-2848-9a4f-9669-7fada8c60326@st.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Patrice CHOTARD <patrice.chotard@st.com>, Thierry Reding <thierry.reding@gmail.com>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Tejun Heo <tj@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
List-Id: linux-ide@vger.kernel.org

Hi,

On 05-04-18 15:17, Patrice CHOTARD wrote:
> Hi Thierry
> 
> On 04/05/2018 11:54 AM, Thierry Reding wrote:
>> On Fri, Mar 23, 2018 at 10:30:53AM +0900, Kunihiko Hayashi wrote:
>>> Add support to get and control a list of resets for the device
>>> as optional and shared. These resets must be kept de-asserted until
>>> the device is enabled.
>>>
>>> This is specified as shared because some SoCs like UniPhier series
>>> have common reset controls with all ahci controller instances.
>>>
>>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>>> ---
>>>    .../devicetree/bindings/ata/ahci-platform.txt      |  1 +
>>>    drivers/ata/ahci.h                                 |  1 +
>>>    drivers/ata/libahci_platform.c                     | 24 +++++++++++++++++++---
>>>    3 files changed, 23 insertions(+), 3 deletions(-)
>>
>> This causes a regression on Tegra because we explicitly request the
>> resets after the call to ahci_platform_get_resources().
> 
> I confirm, we got exactly the same behavior on STi platform.
> 
>>
>>   From a quick look, ahci_mtk and ahci_st are in the same boat, adding the
>> corresponding maintainers to Cc.
>>
>> Patrice, Matthias: does SATA still work for you after this patch? This
>> has been in linux-next since next-20180327.
> 
> SATA is still working after this patch, but a kernel warning is
> triggered due to the fact that resets are both requested by
> libahci_platform and by ahci_st driver.

So in your case you might be able to remove the reset handling
from the ahci_st driver and rely on the new libahci_platform
handling instead? If that works that seems like a win to me.

As said elsewhere in this thread I think it makes sense to keep (or re-add
after a revert) the libahci_platform reset code, but make it conditional
on a flag passed to ahci_platform_get_resources(). This way we get
the shared code for most cases and platforms which need special handling
can opt-out.

Regards,

Hans


> 
> Patrice
> 
>>
>> Given how this is one of the more hardware-specific bits, perhaps a
>> better way to do this is to move reset handling into a Uniphier driver
>> much like Tegra, Mediatek and ST?
>>
>> That said, I don't see SATA support for any of the Socionext hardware
>> either in the DT bindings or drivers/ata, so perhaps it'd be best to
>> back this out again until we have something that's more well tested?
>>
>> Thierry

From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 03/10] devicetree: bindings: add bindings for ahci-da850
Date: Mon, 16 Jan 2017 18:15:13 +0530
Message-ID: <d8406f53-b97d-ca9a-f7d1-94ce5b7064f7@ti.com>
References: <1484311084-31547-1-git-send-email-bgolaszewski@baylibre.com>
 <1484311084-31547-4-git-send-email-bgolaszewski@baylibre.com>
 <35ff358d-9b17-b2be-38d8-6a51cdddc1a1@lechnology.com>
 <CAMpxmJUau9BgAOhacPvcA=NwyE6-yEfDgPdcCZ_JCuNH-amJSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAMpxmJUau9BgAOhacPvcA=NwyE6-yEfDgPdcCZ_JCuNH-amJSA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>, David Lechner <david@lechnology.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-devicetree <devicetree@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Russell King <linux@armlinux.org.uk>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Patrick Titiano <ptitiano@baylibre.com>, Tejun Heo <tj@kernel.org>, arm-soc <linux-arm-kernel@lists.infradead.org>
List-Id: linux-ide@vger.kernel.org

On Monday 16 January 2017 03:43 PM, Bartosz Golaszewski wrote:
> 2017-01-13 20:25 GMT+01:00 David Lechner <david@lechnology.com>:
>> On 01/13/2017 06:37 AM, Bartosz Golaszewski wrote:
>>>
>>> Add DT bindings for the TI DA850 AHCI SATA controller.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>> ---
>>>  .../devicetree/bindings/ata/ahci-da850.txt          | 21
>>> +++++++++++++++++++++
>>>  1 file changed, 21 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/ata/ahci-da850.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/ata/ahci-da850.txt
>>> b/Documentation/devicetree/bindings/ata/ahci-da850.txt
>>> new file mode 100644
>>> index 0000000..d07c241
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/ata/ahci-da850.txt
>>> @@ -0,0 +1,21 @@
>>> +Device tree binding for the TI DA850 AHCI SATA Controller
>>> +---------------------------------------------------------
>>> +
>>> +Required properties:
>>> +  - compatible: must be "ti,da850-ahci"
>>> +  - reg: physical base addresses and sizes of the controller's register
>>> areas
>>> +  - interrupts: interrupt specifier (refer to the interrupt binding)
>>> +
>>> +Optional properties:
>>> +  - clocks: clock specifier (refer to the common clock binding)
>>> +  - da850,clk_multiplier: the multiplier for the reference clock needed
>>> +                          for 1.5GHz PLL output
>>
>>
>> A clock multiplier property seems redundant if you are specifying a clock.
>> It should be possible to get the rate from the clock to determine which
>> multiplier is needed.
>>
> 
> I probably should have named it differently. This is not a multiplier
> of a clock derived from PLL0 or PLL1. Instead it's a value set by
> writing to the Port PHY Control Register (MPY bits) of the SATA
> controller that configures the multiplier for the external low-jitter
> clock. On the lcdk the signals (REFCLKP, REFCLKN) are provided by
> CDCM61001 (SATA OSCILLATOR component on the schematics).
> 
> I'll find a better name and comment the property accordingly.
> 
> FYI: the da850 platform does not use the common clock framework, so I
> don't specify the clock property on the sata node in the device tree.
> Instead I add the clock lookup entry in patch [01/10]. This is
> transparent for AHCI which can get the clock as usual by calling
> clk_get() in ahci_platform_get_resources().

I think David's point is that the SATA_REFCLK needs to be modeled as a
actual clock input to the IP. You should be able to get the rate using
clk_get_rate() and make the MPY bits calculation depending on the
incoming rate.

You should be able to model the clock even when not using common clock
framework.

DA850 AHCI does not use a con_id at the moment (it assumes a single
clock), and that needs to change.

Thanks,
Sekhar

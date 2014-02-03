From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v5 13/14] ARM: sun4i: dts: Add ahci / sata support
Date: Mon, 03 Feb 2014 11:35:14 +0100
Message-ID: <52EF70E2.6070803@redhat.com>
References: <1390417489-5354-1-git-send-email-hdegoede@redhat.com> <1390417489-5354-14-git-send-email-hdegoede@redhat.com> <20140131134505.GG2950@lukather>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBAPCXWLQKGQEW57N5TA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140131134505.GG2950@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-ide@vger.kernel.org

Hi,

On 01/31/2014 02:45 PM, Maxime Ripard wrote:
> Hi Hans,
>
> On Wed, Jan 22, 2014 at 08:04:48PM +0100, Hans de Goede wrote:
>> From: Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
>>
>> This patch adds sunxi sata support to A10 boards that have such a connector.
>> Some boards also feature a regulator via a GPIO and support for this is also
>> added.
>>
>> Signed-off-by: Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
>> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> ---
>>   arch/arm/boot/dts/sun4i-a10-a1000.dts      |  4 ++++
>>   arch/arm/boot/dts/sun4i-a10-cubieboard.dts |  6 +++++
>>   arch/arm/boot/dts/sun4i-a10.dtsi           |  8 +++++++
>>   arch/arm/boot/dts/sunxi-ahci-reg.dtsi      | 38 ++++++++++++++++++++++++++++++
>
> I'm still half convinced about this at the moment, given the number of
> platforms we support, we can always change it back if things become too messy.

I assume that this == sunxi-ahci-reg.dtsi ?  To be sure I understand you correctly,
you're ok with going this route for now, right ?

How about the same for the usb ohci/ehci controller dts patches ? Currently they
are still using the put a regulator node in each dts file model, which leads to
a lot of boilerplate code. So I would like to move to the same model as I'm
using here for the sata supply.


>
>>   4 files changed, 56 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/sunxi-ahci-reg.dtsi
>>
>> diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/sun4i-a10-a1000.dts
>> index aef8207..3fb7305 100644
>> --- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
>> +++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
>> @@ -48,6 +48,10 @@
>>   			status = "okay";
>>   		};
>>
>> +		ahci: sata@01c18000 {
>> +			status = "okay";
>> +		};
>> +
>>   		pinctrl@01c20800 {
>>   			mmc0_cd_pin_a1000: mmc0_cd_pin@0 {
>>   				allwinner,pins = "PH1";
>> diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
>> index f50fb2b..6ae1110 100644
>> --- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
>> +++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
>> @@ -12,6 +12,7 @@
>>
>>   /dts-v1/;
>>   /include/ "sun4i-a10.dtsi"
>> +/include/ "sunxi-ahci-reg.dtsi"
>>
>>   / {
>>   	model = "Cubietech Cubieboard";
>> @@ -51,6 +52,11 @@
>>   			status = "okay";
>>   		};
>>
>> +		ahci: sata@01c18000 {
>> +			target-supply = <&reg_ahci_5v>;
>> +			status = "okay";
>> +		};
>> +
>>   		pinctrl@01c20800 {
>>   			mmc0_cd_pin_cubieboard: mmc0_cd_pin@0 {
>>   				allwinner,pins = "PH1";
>> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
>> index 4736dd2..198dcda 100644
>> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
>> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
>> @@ -331,6 +331,14 @@
>>   			status = "disabled";
>>   		};
>>
>> +		ahci: sata@01c18000 {
>> +			compatible = "allwinner,sun4i-a10-ahci";
>
> To be consistent with the rest of the sun4i devices compatible, It
> should be sun4i-ahci.
>
> However, since these devices don't use the same compatible pattern as
> their own machine compatible, and are consisent with the rest of the
> compatibles for the other SoCs, we can probably make this a go to
> transition progressively to this pattern.

Ack, I think it would be good to be consistent and try to use
sun?i-aXX-foo everywhere. I noticed that we already use that in various
places, so I thought it would be good to do that for all new dts bindings.

> I'll cook up some patches for the other devices.

Thanks.

>
>> +			reg = <0x01c18000 0x1000>;
>> +			interrupts = <56>;
>> +			clocks = <&pll6 0>, <&ahb_gates 25>;
>> +			status = "disabled";
>> +		};
>> +
>>   		intc: interrupt-controller@01c20400 {
>>   			compatible = "allwinner,sun4i-ic";
>>   			reg = <0x01c20400 0x400>;
>> diff --git a/arch/arm/boot/dts/sunxi-ahci-reg.dtsi b/arch/arm/boot/dts/sunxi-ahci-reg.dtsi
>> new file mode 100644
>> index 0000000..955b197
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/sunxi-ahci-reg.dtsi
>> @@ -0,0 +1,38 @@
>> +/*
>> + * sunxi boards sata target power supply common code
>> + *
>> + * Copyright 2014 - Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> + *
>> + * The code contained herein is licensed under the GNU General Public
>> + * License. You may obtain a copy of the GNU General Public License
>> + * Version 2 or later at the following locations:
>> + *
>> + * http://www.opensource.org/licenses/gpl-license.html
>> + * http://www.gnu.org/copyleft/gpl.html
>> + */
>> +
>> +/ {
>> +	soc@01c00000 {
>> +		ahci_pwr_pin_a: ahci_pwr_pin@0 {
>> +			allwinner,pins = "PB8";
>> +			allwinner,function = "gpio_out";
>> +			allwinner,drive = <0>;
>> +			allwinner,pull = <0>;
>> +		};
>
> This should be under the pinctrl node.

Fixed already locally.

Regards,

Hans

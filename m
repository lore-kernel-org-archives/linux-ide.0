From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3 2/7] leds: documentation: 'ide-disk' to 'disk-activity'
Date: Tue, 21 Jun 2016 16:05:32 +0100
Message-ID: <20160621150532.GG3302@leverpostej>
References: <20160608223000.433-1-linz@li-pro.net>
 <20160608223000.433-2-linz@li-pro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41217 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751635AbcFUPFi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Jun 2016 11:05:38 -0400
Content-Disposition: inline
In-Reply-To: <20160608223000.433-2-linz@li-pro.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stephan Linz <linz@li-pro.net>
Cc: linux-leds@vger.kernel.org, linux-ide@vger.kernel.org, Joseph Jezak <josejx@gentoo.org>, Nico Macrionitis <acrux@cruxppc.org>, =?utf-8?B?SsO2cmc=?= Sommer <joerg@alea.gnuu.de>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Jonathan Corbet <corbet@lwn.net>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org

On Thu, Jun 09, 2016 at 12:29:37AM +0200, Stephan Linz wrote:
> Cc: Joseph Jezak <josejx@gentoo.org>
> Cc: Nico Macrionitis <acrux@cruxppc.org>
> Cc: J=C3=B6rg Sommer <joerg@alea.gnuu.de>
> Signed-off-by: Stephan Linz <linz@li-pro.net>
> ---
>  Documentation/devicetree/bindings/leds/common.txt    | 2 +-
>  Documentation/devicetree/bindings/leds/leds-gpio.txt | 2 +-
>  Documentation/laptops/asus-laptop.txt                | 2 +-
>  Documentation/leds/leds-class.txt                    | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/leds/common.txt b/Docu=
mentation/devicetree/bindings/leds/common.txt
> index af10678..1e97169 100644
> --- a/Documentation/devicetree/bindings/leds/common.txt
> +++ b/Documentation/devicetree/bindings/leds/common.txt
> @@ -26,7 +26,7 @@ Optional properties for child nodes:
>       "default-on" - LED will turn on (but for leds-gpio see "default=
-state"
>  		    property in Documentation/devicetree/bindings/gpio/led.txt)
>       "heartbeat" - LED "double" flashes at a load average based rate
> -     "ide-disk" - LED indicates disk activity
> +     "disk-activity" - LED indicates disk activity
>       "timer" - LED flashes at a fixed, configurable rate

We should not break the binding.

Code must continue to support "ide-disk", though we can mark it
deprecated in the binding documentation, and update the in-kernel dts
files to use "disk-activity".

Thanks,
Mark.

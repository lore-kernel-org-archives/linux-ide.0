From: Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: Re: [PATCH v5] leds: documentation: 'ide-disk' to 'disk-activity'
Date: Fri, 24 Jun 2016 08:50:11 +0200
Message-ID: <576CD823.1080906@samsung.com>
References: <576B8467.3060407@samsung.com>
 <20160623193857.14538-1-linz@li-pro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-leds-owner@vger.kernel.org>
In-reply-to: <20160623193857.14538-1-linz@li-pro.net>
Sender: linux-leds-owner@vger.kernel.org
To: Stephan Linz <linz@li-pro.net>
Cc: linux-leds@vger.kernel.org, linux-ide@vger.kernel.org, Joseph Jezak <josejx@gentoo.org>, =?UTF-8?B?SsO2cmcgU29tbWVy?= <joerg@alea.gnuu.de>, Mark Rutland <mark.rutland@arm.com>, Richard Purdie <rpurdie@rpsys.net>, Rob Herring <robh+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi Stephan,

On 06/23/2016 09:38 PM, Stephan Linz wrote:
> Cc: Joseph Jezak <josejx@gentoo.org>
> Cc: J=C3=B6rg Sommer <joerg@alea.gnuu.de>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Stephan Linz <linz@li-pro.net>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Jacek Anaszewski <j.anaszewski@samsung.com>
> ---
> Changes in v5:
>    - Keep documentation for the old 'ide-disk' device tree
>      binding, but mark as deprecated and refer to the new
>      trigger 'disk-activity'.
>
> Changes in v4:
>    - Keep the 'ide-disk' trigger and add a second one
>      for 'disk-activity'.
>
> Changes in v3:
>    - Port to kernel 4.x
>    - Split into platform independent and dependent parts.
>
> v2: https://patchwork.ozlabs.org/patch/117485/
> v1: http://dev.gentoo.org/~josejx/ata.patch
> ---
>   Documentation/devicetree/bindings/leds/common.txt    | 5 ++++-
>   Documentation/devicetree/bindings/leds/leds-gpio.txt | 4 ++--
>   Documentation/laptops/asus-laptop.txt                | 2 +-
>   Documentation/leds/leds-class.txt                    | 2 +-
>   4 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/leds/common.txt b/Docu=
mentation/devicetree/bindings/leds/common.txt
> index af10678..1c32e31 100644
> --- a/Documentation/devicetree/bindings/leds/common.txt
> +++ b/Documentation/devicetree/bindings/leds/common.txt
> @@ -25,8 +25,11 @@ Optional properties for child nodes:
>   		   system
>        "default-on" - LED will turn on (but for leds-gpio see "defaul=
t-state"
>   		    property in Documentation/devicetree/bindings/gpio/led.txt)
> +     "disk-activity" - LED indicates disk activity, the old name "id=
e-disk" is
> +                       still valid for backward compatibility
>        "heartbeat" - LED "double" flashes at a load average based rat=
e
> -     "ide-disk" - LED indicates disk activity
> +     "ide-disk" - LED indicates IDE disk activity (deprecated), do n=
ot use for
> +                  new implementation, use the new "disk-activity" na=
me instead

I'd like to reorganize this change.

I think that the two affected properties should be placed next to
each other. I'd also remove the remark about ide-disk at disk-activity,
since we're leaving ide-disk, with added reference to disk-activity.

How about following:

+     "disk-activity" - LED indicates disk activity
-     "ide-disk" - LED indicates disk activity
+     "ide-disk" - LED indicates IDE disk activity (deprecated),
                    in new implementations use "disk-activity"

>        "timer" - LED flashes at a fixed, configurable rate
>
>   - led-max-microamp : Maximum LED supply current in microamperes. Th=
is property
> diff --git a/Documentation/devicetree/bindings/leds/leds-gpio.txt b/D=
ocumentation/devicetree/bindings/leds/leds-gpio.txt
> index cbbeb18..5b1b43a 100644
> --- a/Documentation/devicetree/bindings/leds/leds-gpio.txt
> +++ b/Documentation/devicetree/bindings/leds/leds-gpio.txt
> @@ -33,9 +33,9 @@ Examples:
>   leds {
>   	compatible =3D "gpio-leds";
>   	hdd {
> -		label =3D "IDE Activity";
> +		label =3D "Disk Activity";
>   		gpios =3D <&mcu_pio 0 GPIO_ACTIVE_LOW>;
> -		linux,default-trigger =3D "ide-disk";
> +		linux,default-trigger =3D "disk-activity";
>   	};
>
>   	fault {
> diff --git a/Documentation/laptops/asus-laptop.txt b/Documentation/la=
ptops/asus-laptop.txt
> index 79a1bc6..5f28587 100644
> --- a/Documentation/laptops/asus-laptop.txt
> +++ b/Documentation/laptops/asus-laptop.txt
> @@ -72,7 +72,7 @@ LEDs
>       echo 1 >  /sys/class/leds/asus::mail/brightness
>     will switch the mail LED on.
>     You can also know if they are on/off by reading their content and=
 use
> -  kernel triggers like ide-disk or heartbeat.
> +  kernel triggers like disk-activity or heartbeat.
>
>   Backlight
>   ---------
> diff --git a/Documentation/leds/leds-class.txt b/Documentation/leds/l=
eds-class.txt
> index 44f5e6b..f1f7ec9 100644
> --- a/Documentation/leds/leds-class.txt
> +++ b/Documentation/leds/leds-class.txt
> @@ -11,7 +11,7 @@ brightness support so will just be turned on for no=
n-zero brightness settings.
>   The class also introduces the optional concept of an LED trigger. A=
 trigger
>   is a kernel based source of led events. Triggers can either be simp=
le or
>   complex. A simple trigger isn't configurable and is designed to slo=
t into
> -existing subsystems with minimal additional code. Examples are the i=
de-disk,
> +existing subsystems with minimal additional code. Examples are the d=
isk-activity,
>   nand-disk and sharpsl-charge triggers. With led triggers disabled, =
the code
>   optimises away.
>
>


--=20
Best regards,
Jacek Anaszewski

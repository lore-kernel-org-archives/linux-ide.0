From: Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v6] leds: documentation: 'ide-disk' to 'disk-activity'
Date: Mon, 27 Jun 2016 09:04:13 +0200
Message-ID: <5770CFED.4090300@samsung.com>
References: <20160624171704.13399-1-linz@li-pro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20160624171704.13399-1-linz-LlUBiLVY8XKsTnJN9+BGXg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephan Linz <linz-LlUBiLVY8XKsTnJN9+BGXg@public.gmane.org>
Cc: linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joseph Jezak <josejx-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>, =?UTF-8?B?SsO2cmcgU29tbWVy?= <joerg-au2b9oQwubsjnolme5KbmQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

Hi Stephan,

On 06/24/2016 07:16 PM, Stephan Linz wrote:
> Cc: Joseph Jezak <josejx-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
> Cc: J=C3=B6rg Sommer <joerg-au2b9oQwubsjnolme5KbmQ@public.gmane.org>
> Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
> Signed-off-by: Stephan Linz <linz-LlUBiLVY8XKsTnJN9+BGXg@public.gmane.org>
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
> Changes in v6:
>    - Reorganize v5.
>
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
>   Documentation/devicetree/bindings/leds/common.txt    | 4 +++-
>   Documentation/devicetree/bindings/leds/leds-gpio.txt | 4 ++--
>   Documentation/laptops/asus-laptop.txt                | 2 +-
>   Documentation/leds/leds-class.txt                    | 2 +-
>   4 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/leds/common.txt b/Docu=
mentation/devicetree/bindings/leds/common.txt
> index af10678..93ef6e6 100644
> --- a/Documentation/devicetree/bindings/leds/common.txt
> +++ b/Documentation/devicetree/bindings/leds/common.txt
> @@ -26,7 +26,9 @@ Optional properties for child nodes:
>        "default-on" - LED will turn on (but for leds-gpio see "defaul=
t-state"
>   		    property in Documentation/devicetree/bindings/gpio/led.txt)
>        "heartbeat" - LED "double" flashes at a load average based rat=
e
> -     "ide-disk" - LED indicates disk activity
> +     "disk-activity" - LED indicates disk activity
> +     "ide-disk" - LED indicates IDE disk activity (deprecated),
> +                  in new implementations use "disk-activity"
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

Applied, thanks.

--=20
Best regards,
Jacek Anaszewski
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

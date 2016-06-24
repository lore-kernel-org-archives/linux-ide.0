From: Stephan Linz <linz@li-pro.net>
Subject: Re: [PATCH v5] leds: documentation: 'ide-disk' to 'disk-activity'
Date: Fri, 24 Jun 2016 19:18:52 +0200
Message-ID: <576D6B7C.1050602@li-pro.net>
References: <576B8467.3060407@samsung.com>
 <20160623193857.14538-1-linz@li-pro.net> <576CD823.1080906@samsung.com>
Reply-To: linz@li-pro.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="XCQPjKkSp0oKKwXvb76s5LHKxPJTkv8NU"
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <576CD823.1080906@samsung.com>
Sender: linux-doc-owner@vger.kernel.org
To: Jacek Anaszewski <j.anaszewski@samsung.com>
Cc: linux-leds@vger.kernel.org, linux-ide@vger.kernel.org, Joseph Jezak <josejx@gentoo.org>, =?UTF-8?Q?J=c3=b6rg_Sommer?= <joerg@alea.gnuu.de>, Mark Rutland <mark.rutland@arm.com>, Richard Purdie <rpurdie@rpsys.net>, Rob Herring <robh+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XCQPjKkSp0oKKwXvb76s5LHKxPJTkv8NU
Content-Type: multipart/mixed; boundary="6noP5rETnob1IiVttb8RAEVxFHLHaDAFo"
From: Stephan Linz <linz@li-pro.net>
Reply-To: linz@li-pro.net
To: Jacek Anaszewski <j.anaszewski@samsung.com>
Cc: linux-leds@vger.kernel.org, linux-ide@vger.kernel.org,
 Joseph Jezak <josejx@gentoo.org>, =?UTF-8?Q?J=c3=b6rg_Sommer?=
 <joerg@alea.gnuu.de>, Mark Rutland <mark.rutland@arm.com>,
 Richard Purdie <rpurdie@rpsys.net>, Rob Herring <robh+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Message-ID: <576D6B7C.1050602@li-pro.net>
Subject: Re: [PATCH v5] leds: documentation: 'ide-disk' to 'disk-activity'
References: <576B8467.3060407@samsung.com>
 <20160623193857.14538-1-linz@li-pro.net> <576CD823.1080906@samsung.com>
In-Reply-To: <576CD823.1080906@samsung.com>

--6noP5rETnob1IiVttb8RAEVxFHLHaDAFo
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Jacek,

thanks for your help. The new patch is on the way (v6).


br,
Stephan

Am 24.06.2016 um 08:50 schrieb Jacek Anaszewski:
> Hi Stephan,
>=20
> On 06/23/2016 09:38 PM, Stephan Linz wrote:
>> Cc: Joseph Jezak <josejx@gentoo.org>
>> Cc: J=C3=B6rg Sommer <joerg@alea.gnuu.de>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Stephan Linz <linz@li-pro.net>
>> Acked-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Jacek Anaszewski <j.anaszewski@samsung.com>
>> ---
>> Changes in v5:
>>    - Keep documentation for the old 'ide-disk' device tree
>>      binding, but mark as deprecated and refer to the new
>>      trigger 'disk-activity'.
>>
>> Changes in v4:
>>    - Keep the 'ide-disk' trigger and add a second one
>>      for 'disk-activity'.
>>
>> Changes in v3:
>>    - Port to kernel 4.x
>>    - Split into platform independent and dependent parts.
>>
>> v2: https://patchwork.ozlabs.org/patch/117485/
>> v1: http://dev.gentoo.org/~josejx/ata.patch
>> ---
>>   Documentation/devicetree/bindings/leds/common.txt    | 5 ++++-
>>   Documentation/devicetree/bindings/leds/leds-gpio.txt | 4 ++--
>>   Documentation/laptops/asus-laptop.txt                | 2 +-
>>   Documentation/leds/leds-class.txt                    | 2 +-
>>   4 files changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/leds/common.txt
>> b/Documentation/devicetree/bindings/leds/common.txt
>> index af10678..1c32e31 100644
>> --- a/Documentation/devicetree/bindings/leds/common.txt
>> +++ b/Documentation/devicetree/bindings/leds/common.txt
>> @@ -25,8 +25,11 @@ Optional properties for child nodes:
>>              system
>>        "default-on" - LED will turn on (but for leds-gpio see
>> "default-state"
>>               property in Documentation/devicetree/bindings/gpio/led.t=
xt)
>> +     "disk-activity" - LED indicates disk activity, the old name
>> "ide-disk" is
>> +                       still valid for backward compatibility
>>        "heartbeat" - LED "double" flashes at a load average based rate=

>> -     "ide-disk" - LED indicates disk activity
>> +     "ide-disk" - LED indicates IDE disk activity (deprecated), do
>> not use for
>> +                  new implementation, use the new "disk-activity"
>> name instead
>=20
> I'd like to reorganize this change.
>=20
> I think that the two affected properties should be placed next to
> each other. I'd also remove the remark about ide-disk at disk-activity,=

> since we're leaving ide-disk, with added reference to disk-activity.
>=20
> How about following:
>=20
> +     "disk-activity" - LED indicates disk activity
> -     "ide-disk" - LED indicates disk activity
> +     "ide-disk" - LED indicates IDE disk activity (deprecated),
>                    in new implementations use "disk-activity"
>=20
>>        "timer" - LED flashes at a fixed, configurable rate
>>
>>   - led-max-microamp : Maximum LED supply current in microamperes.
>> This property
>> diff --git a/Documentation/devicetree/bindings/leds/leds-gpio.txt
>> b/Documentation/devicetree/bindings/leds/leds-gpio.txt
>> index cbbeb18..5b1b43a 100644
>> --- a/Documentation/devicetree/bindings/leds/leds-gpio.txt
>> +++ b/Documentation/devicetree/bindings/leds/leds-gpio.txt
>> @@ -33,9 +33,9 @@ Examples:
>>   leds {
>>       compatible =3D "gpio-leds";
>>       hdd {
>> -        label =3D "IDE Activity";
>> +        label =3D "Disk Activity";
>>           gpios =3D <&mcu_pio 0 GPIO_ACTIVE_LOW>;
>> -        linux,default-trigger =3D "ide-disk";
>> +        linux,default-trigger =3D "disk-activity";
>>       };
>>
>>       fault {
>> diff --git a/Documentation/laptops/asus-laptop.txt
>> b/Documentation/laptops/asus-laptop.txt
>> index 79a1bc6..5f28587 100644
>> --- a/Documentation/laptops/asus-laptop.txt
>> +++ b/Documentation/laptops/asus-laptop.txt
>> @@ -72,7 +72,7 @@ LEDs
>>       echo 1 >  /sys/class/leds/asus::mail/brightness
>>     will switch the mail LED on.
>>     You can also know if they are on/off by reading their content and =
use
>> -  kernel triggers like ide-disk or heartbeat.
>> +  kernel triggers like disk-activity or heartbeat.
>>
>>   Backlight
>>   ---------
>> diff --git a/Documentation/leds/leds-class.txt
>> b/Documentation/leds/leds-class.txt
>> index 44f5e6b..f1f7ec9 100644
>> --- a/Documentation/leds/leds-class.txt
>> +++ b/Documentation/leds/leds-class.txt
>> @@ -11,7 +11,7 @@ brightness support so will just be turned on for
>> non-zero brightness settings.
>>   The class also introduces the optional concept of an LED trigger. A
>> trigger
>>   is a kernel based source of led events. Triggers can either be
>> simple or
>>   complex. A simple trigger isn't configurable and is designed to slot=

>> into
>> -existing subsystems with minimal additional code. Examples are the
>> ide-disk,
>> +existing subsystems with minimal additional code. Examples are the
>> disk-activity,
>>   nand-disk and sharpsl-charge triggers. With led triggers disabled,
>> the code
>>   optimises away.
>>
>>
>=20
>=20


--6noP5rETnob1IiVttb8RAEVxFHLHaDAFo--

--XCQPjKkSp0oKKwXvb76s5LHKxPJTkv8NU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJXbWt8AAoJEFebNK/earQ5HsQP/jBYPPNECOT5DLO5JGtJzGiJ
7DRp/dyDqHRLnAUNEtrzwXqlrE2waXFGU/6dEjmnNnKQ9LLYmja4pqHLC3BjakSP
bSLTcp4J9vuYpJOFU++ZRSCLy151k6m2BLWau0BLzxBrKeMVJU+1w9UYruTYIhND
u8a77Ha4zmnZocec11R8COhtCc3rKUkhvI5vyxXg1s400KTaMM+qoVovGfgCw+yF
CVK0JHYLY/V5UkaNWPILtdPNuk5RIgvZ0GLGz05iX8x9N5Zw8yHoKBzdAvIkmNCB
7tCQ84QtgCtG3n76VMvt01Zf57AoZf1g6kfodVbQmTTPAAQa/oMT0jcjUo8VnOxx
arP/tx3AvmXjc1By41Ykik0hMSHivIu1v+kCCK1B4iazodWWufY6kF+FfxK7zQAq
97sGWt6LawMIjnRCquh52PdAU+lvH/CyrZC0VikE3qFh6YRuMoikNZWmY0DaNEQm
iIzDWcW8/Hb+za20sPC1WUjwvHOCnhME+swAySgzFMARV09cKC/MKTTAXzsGNlvC
SpIKhuSAPYoiX6iAp9UiMH6xlxHAZC4/oGH/cNO28dhy0Gc1/N2Q1Z3wDxPXUPh7
GbSMGZ3GCb0L9D5ax9XHEhJbYn8s7dJ6xZF7+yplqzaoiLEPyD7r3DKwrlCYIrvR
dx7ZiddhWcAA3oGEYLLs
=2Kgi
-----END PGP SIGNATURE-----

--XCQPjKkSp0oKKwXvb76s5LHKxPJTkv8NU--

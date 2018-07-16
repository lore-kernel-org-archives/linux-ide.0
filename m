From: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
Subject: Re: [PATCH v3 7/9] dt-bindings: ata: ahci-platform:
 document port-supply
Date: Tue, 17 Jul 2018 00:02:42 +0800
Message-ID: <99FC6EC0-941D-4757-9C7F-57BE2BDBEF91@aosc.io>
References: <1531479786-4911-1-git-send-email-clabbe@baylibre.com> <1531479786-4911-8-git-send-email-clabbe@baylibre.com> <20180716155938.GA6947@rob-hp-laptop>
Reply-To: icenowy-h8G6r0blFSE@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDS6XAN6ZADRBSEDWPNAKGQE2GKIDGQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20180716155938.GA6947@rob-hp-laptop>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Corentin Labbe <clabbe-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: linux-ide@vger.kernel.org



=E4=BA=8E 2018=E5=B9=B47=E6=9C=8816=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=8811=
:59:38, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> =E5=86=99=E5=88=B0:
>On Fri, Jul 13, 2018 at 11:03:04AM +0000, Corentin Labbe wrote:
>> This patch document the new optional port-supply
>>=20
>> Signed-off-by: Corentin Labbe <clabbe-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
>> ---
>>  Documentation/devicetree/bindings/ata/ahci-platform.txt | 2 ++
>>  1 file changed, 2 insertions(+)
>>=20
>> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt
>b/Documentation/devicetree/bindings/ata/ahci-platform.txt
>> index 47652521a6ed..40a636b9851e 100644
>> --- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
>> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
>> @@ -31,6 +31,7 @@ Optional properties:
>>  - dma-coherent      : Present if dma operations are coherent
>>  - clocks            : a list of phandle + clock specifier pairs
>>  - target-supply     : regulator for SATA target power
>> +- port-supply       : regulator for SATA port
>
>Humm, I'm pretty sure that's what target-supply was supposed to be. If=20
>anything, need to clearly define what is what.
>
>How does this work with multiple ports?

He wrongly named it. It's for PHY.

>
>>  - phys              : reference to the SATA PHY node
>>  - phy-names         : must be "sata-phy"
>>  - ahci-supply       : regulator for AHCI controller
>
>Also, please group all the supplies together.
>
>> @@ -51,6 +52,7 @@ Sub-nodes required properties:
>>  And at least one of the following properties:
>>  - phys		    : reference to the SATA PHY node
>>  - target-supply     : regulator for SATA target power
>> +- port-supply       : regulator for SATA port
>> =20
>>  Examples:
>>          sata@ffe08000 {
>> --=20
>> 2.16.4
>>=20
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

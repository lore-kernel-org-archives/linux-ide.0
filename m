From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [PATCH RFC 1/2] libahci_platform: add
 ahci_platform_get_of_property
Date: Wed, 18 Jun 2014 09:37:25 +0200
Message-ID: <20140618093725.0f381633@ipc1.ka-ro>
References: <xuwei5@hisilicon.com, kefeng.wang@linaro.org,>
	<1403067249-8021-1-git-send-email-zhangfei.gao@linaro.org>
	<1403067249-8021-2-git-send-email-zhangfei.gao@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:56370 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756388AbaFRHiK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jun 2014 03:38:10 -0400
In-Reply-To: <1403067249-8021-2-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: tj@kernel.org, hdegoede@redhat.com, arnd@arndb.de, mark.rutland@arm.com, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Hi,

Zhangfei Gao wrote:
> Instead of setting hflags in different files,
> ahci_platform_get_of_property set hpriv->flags when ahci_platform_ini=
t_host
> according to property in dts.
>=20
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>  .../devicetree/bindings/ata/ahci-platform.txt      |    9 +++++
>  drivers/ata/libahci_platform.c                     |   39 ++++++++++=
++++++++++
>  2 files changed, 48 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt =
b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> index c96d8dcf98fd..c0b9f6e76ba4 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> @@ -26,6 +26,15 @@ Optional properties:
>  - clocks            : must contain the sata, sata_ref and ahb clocks
>  - clock-names       : must contain "ahb" for the ahb clock
> =20
> +- no-ncq: when present, controller can't do NCQ, turning off CAP_NCQ
> +- 32bit-only: when present, controller can't do 64bit DMA, forcing 3=
2bit
> +- no-msi: when present, no PCI MSI
> +- no-pmp: when present, controller can't do PMP, turning off CAP_PMP
> +- yes-ncq: when present,controller can do NCQ, turning on CAP_NCQ
> +- no-suspend: when present, controller can't do suspend
> +- yes-fbs: when present, controller can do FBS, turning on CAP_FBS
> +- no-fbs: when present, controller can't do FBS, turning off CAP_FBS
> +
'yes-...' sounds a bit silly to me.
What about 'force-...'?
That's also what the comment to the flag definitions in
drivers/ata/ahci.h says:
|AHCI_HFLAG_YES_NCQ              =3D (1 << 9), /* force NCQ cap on */
|AHCI_HFLAG_YES_FBS              =3D (1 << 14), /* force FBS cap on */


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________

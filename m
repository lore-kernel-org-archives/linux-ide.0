From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v4 0/4] ata: libahci: Allow using a regulator for each
 port
Date: Fri, 16 Jan 2015 08:58:18 +0100
Message-ID: <54B8C49A.9070302@redhat.com>
References: <1421330978-9694-1-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1421330978-9694-1-git-send-email-gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?B?QW50b2luZSBUw6luYXJ0?= <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Tawfik Bayouk <tawfik-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

Hi,

On 15-01-15 15:09, Gregory CLEMENT wrote:
> The current implementation of the libahci allows using one PHY per
> port but we still have one single regulator for the whole
> controller. This series adds the support of multiple regulators.
>
> This is the forth version of the series.
>
> The improvement of this version is the use of
> ahci_platform_put_resources to put the reference to the regulators.
>
> Thanks,
>
> Gr=C3=A9gory

Thanks, patches 1 - 3 look good and are:

Acked-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Tejun, can you please queue up 1 - 3 ?

I still have some remarks wrt patch 4 (*), and it should probably go
upstream through another tree anyways.

Regards,

Hans


*) I didn't look closely at patch 4 as it seemed trivial, until now
that is ...



>
> Changelog:
>
>   v3 -> v4
> - Moved putting the reference to the regulators into the
>    ahci_platform_put_resources function.
> - Tested the port_dev pointer before dereferencing.
>
>   v2 -> v3:
> - put back the regulator inside the sub-node ports
> - made the ports platform devices when the device tree is used
> - released the regulator in case of error in the probe function
>
>   v1 -> v2:
> - Kept the case when no child node are present under the ahci node
> - Fix the test done under the label disable_target_pwrs
> - No more use an of_ version of the regulator framework and instead
>    associate each regulator of a port with an unique name.
> - Added the acked-by on the clean-up patch
>
> Gregory CLEMENT (4):
>    ata: libahci: Clean-up the ahci_platform_en/disable_phys functions
>    Documentation: bindings: Add the regulator property to the sub-nod=
es
>      AHCI bindings
>    ata: libahci: Allow using multiple regulators
>    ARM: mvebu: Armada 385 GP: Add regulators to the SATA port
>
>   .../devicetree/bindings/ata/ahci-platform.txt      |   9 +-
>   arch/arm/boot/dts/armada-388-gp.dts                | 126 ++++++++++=
+
>   drivers/ata/ahci.h                                 |   2 +-
>   drivers/ata/ahci_imx.c                             |  14 +-
>   drivers/ata/libahci_platform.c                     | 236 ++++++++++=
++++-------
>   include/linux/ahci_platform.h                      |   2 +
>   6 files changed, 305 insertions(+), 84 deletions(-)
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

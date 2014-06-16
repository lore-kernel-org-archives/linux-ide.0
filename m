From: Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 0/7] ARM: berlin: add AHCI support
Date: Mon, 16 Jun 2014 12:46:22 +0200
Message-ID: <539ECAFE.3000508@gmail.com>
References: <1402914392-6028-1-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1402914392-6028-1-git-send-email-antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?B?QW50b2luZSBUw6luYXJ0?= <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org
Cc: alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, zmxu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On 06/16/2014 12:26 PM, Antoine T=C3=A9nart wrote:
> This series adds the support for Berlin SoC AHCI controller. The
> controller allows to use the SATA host interface and, for example, th=
e
> eSATA port on the BG2Q.
>
> The series adds a PHY driver to control the two SATA ports available,
> and adds a generic compatible to use the existing ahci_platform drive=
r.

Besides the comment about adding SATA clock to SATA PHY node and driver=
,

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

for patches 1-5.

> Also enable the eSATA interface on the BG2Q DMP.
>
> Changes sinve v5:
> 	- rebased on top of v3.16-rc1
> 	- added the clocks property in the sata node
>
> Changes since v4:
>          - updated PHY driver as tristate
>          - handled the case were no SATA port is enabled
>          - updated the compatible to a generic one
>          - cosmetic fixups
>
> Changes since v3:
>          - moved all PHY operations to the PHY driver
>          - removed PHY sub-nodes
>          - removed the custom Berlin AHCI driver and switched to
>            ahci_platform
>          - added multiple PHYs support to the libahci_platform
>
> Changes since v2:
>          - modeled each PHY as a sub-node
>          - cosmetic fixups
>
> Changes since v1:
>          - added a PHY driver, allowing to enable each port
>            individually and removed the 'force-port-map' property
>          - made the drivers a bit less magic :)
>          - wrote a function to select and configure registers in the
>            AHCI driver
>          - removed BG2 / BG2CD nodes
>
> Antoine T=C3=A9nart (7):
>    phy: add a driver for the Berlin SATA PHY
>    Documentation: bindings: add the Berlin SATA PHY
>    ata: libahci: allow to use multiple PHYs
>    ata: ahci_platform: add a generic AHCI compatible
>    Documentation: bindings: document the sub-nodes AHCI bindings
>    ARM: berlin: add the AHCI node for the BG2Q
>    ARM: berlin: enable the eSATA interface on the BG2Q DMP
>
>   .../devicetree/bindings/ata/ahci-platform.txt      |  37 ++++
>   .../devicetree/bindings/phy/berlin-sata-phy.txt    |  14 ++
>   arch/arm/boot/dts/berlin2q-marvell-dmp.dts         |   8 +
>   arch/arm/boot/dts/berlin2q.dtsi                    |  28 +++
>   drivers/ata/ahci.h                                 |   3 +-
>   drivers/ata/ahci_platform.c                        |   2 +
>   drivers/ata/libahci.c                              |   7 +
>   drivers/ata/libahci_platform.c                     | 170 ++++++++++=
+----
>   drivers/phy/Kconfig                                |   7 +
>   drivers/phy/Makefile                               |   1 +
>   drivers/phy/phy-berlin-sata.c                      | 232 ++++++++++=
+++++++++++
>   11 files changed, 473 insertions(+), 36 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/phy/berlin-sat=
a-phy.txt
>   create mode 100644 drivers/phy/phy-berlin-sata.c
>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

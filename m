From: Preetham Chandru <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH V3 2/3] dt-bindings: tegra: Add tegra210 AHCI
Date: Fri, 12 May 2017 09:55:56 +0000
Message-ID: <66578c4b5f77447aa6c4e3c7ce0cf8db@bgmail103.nvidia.com>
References: <1494581650-11115-1-git-send-email-pchandru@nvidia.com>
 <1494581650-11115-3-git-send-email-pchandru@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1494581650-11115-3-git-send-email-pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "preetham260-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <preetham260-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Venu Byravarasu <vbyravarasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Pavan Kunapuli <pkunapuli-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

+CC linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

>-----Original Message-----
>From: Preetham Chandru
>Sent: Friday, May 12, 2017 3:04 PM
>To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
>Cc: tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Laxman Dewangan
><ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>; preetham260-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; Venu Byravarasu
><vbyravarasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>; Pavan Kunapuli <pkunapuli-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>; Preetham
>Chandru <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>Subject: [PATCH V3 2/3] dt-bindings: tegra: Add tegra210 AHCI
>
>From: Preetham Chandru R <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>
>Signed-off-by: Preetham Chandru R <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>---
>v3:
>* Add AUX register.
>v2:
>* change cml1, pll_e and phy regulators as optional
>  for T210.
>---
> .../bindings/ata/nvidia,tegra124-ahci.txt          | 45 +++++++++++++++-------
> 1 file changed, 31 insertions(+), 14 deletions(-)
>
>diff --git a/Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt
>b/Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt
>index 66c83c3..dc62dba 100644
>--- a/Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt
>+++ b/Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt
>@@ -1,32 +1,49 @@
>-Tegra124 SoC SATA AHCI controller
>+Tegra SoC SATA AHCI controller
>
> Required properties :
>-- compatible : For Tegra124, must contain "nvidia,tegra124-ahci".  Otherwise,
>-  must contain '"nvidia,<chip>-ahci", "nvidia,tegra124-ahci"', where <chip>
>-  is tegra132.
>-- reg : Should contain 2 entries:
>+- compatible : Must be one of:
>+  - Tegra124 : "nvidia,tegra124-ahci"
>+  - Tegra210 : "nvidia,tegra210-ahci"
>+- reg : Should contain 3 entries:
>   - AHCI register set (SATA BAR5)
>   - SATA register set
>+  - AUX register set
> - interrupts : Defines the interrupt used by SATA
> - clocks : Must contain an entry for each entry in clock-names.
>   See ../clocks/clock-bindings.txt for details.
> - clock-names : Must include the following entries:
>   - sata
>   - sata-oob
>-  - cml1
>-  - pll_e
> - resets : Must contain an entry for each entry in reset-names.
>   See ../reset/reset.txt for details.
> - reset-names : Must include the following entries:
>   - sata
>   - sata-oob
>-  - sata-cold
>+  - For T124: sata-cold
> - phys : Must contain an entry for each entry in phy-names.
>   See ../phy/phy-bindings.txt for details.
> - phy-names : Must include the following entries:
>-  - sata-phy : XUSB PADCTL SATA PHY
>-- hvdd-supply : Defines the SATA HVDD regulator
>-- vddio-supply : Defines the SATA VDDIO regulator
>-- avdd-supply : Defines the SATA AVDD regulator
>-- target-5v-supply : Defines the SATA 5V power regulator
>-- target-12v-supply : Defines the SATA 12V power regulator
>+  - For T124:
>+    - sata-phy : XUSB PADCTL SATA PHY
>+  - For T210:
>+    - sata-0
>+- For T124:
>+  - hvdd-supply : Defines the SATA HVDD regulator
>+  - vddio-supply : Defines the SATA VDDIO regulator
>+  - avdd-supply : Defines the SATA AVDD regulator
>+  - target-5v-supply : Defines the SATA 5V power regulator
>+
>+Optional properties:
>+- clock-names :
>+  - cml1 :
>+    cml1 clock is required by phy so it is optional to define
>+    here as phy driver will be enabling this clock.
>+  - pll_e :
>+    pll_e is the parent of cml1 clock so it is optional to define
>+    here as phy driver will be enabling this clock.
>+- For T210:
>+  - l0-hvddio-sata-supply : Defines the SATA HVDDIO regulator
>+  - l0-dvddio-sata-supply : Defines the SATA DVDDIO regulator
>+  - hvdd-pex-pll-e-supply : Defines the PEX PLL_E regulator
>+  - dvdd-sata-pll-supply  : Defines the SATA PLL regulator
>+  - hvdd-sata-supply      : Defines the SATA HVDD regulator
>--
>2.1.4

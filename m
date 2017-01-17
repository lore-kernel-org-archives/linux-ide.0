From: David Lechner <david@lechnology.com>
Subject: Re: [PATCH v2 01/14] devicetree: bindings: add bindings for
 ahci-da850
Date: Tue, 17 Jan 2017 12:35:31 -0600
Message-ID: <7e3c8946-2a19-3e11-c071-b3737554005c@lechnology.com>
References: <1484655976-25382-1-git-send-email-bgolaszewski@baylibre.com>
 <1484655976-25382-2-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vern.gendns.com ([206.190.152.46]:55611 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750866AbdAQSfb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 17 Jan 2017 13:35:31 -0500
In-Reply-To: <1484655976-25382-2-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Patrick Titiano <ptitiano@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 01/17/2017 06:26 AM, Bartosz Golaszewski wrote:
> Add DT bindings for the TI DA850 AHCI SATA controller.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  Documentation/devicetree/bindings/ata/ahci-da850.txt | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ata/ahci-da850.txt
>
> diff --git a/Documentation/devicetree/bindings/ata/ahci-da850.txt b/Documentation/devicetree/bindings/ata/ahci-da850.txt
> new file mode 100644
> index 0000000..e7111b4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/ahci-da850.txt
> @@ -0,0 +1,18 @@
> +Device tree binding for the TI DA850 AHCI SATA Controller
> +---------------------------------------------------------
> +
> +Required properties:
> +  - compatible: must be "ti,da850-ahci"
> +  - reg: physical base addresses and sizes of the controller's register areas
> +  - interrupts: interrupt specifier (refer to the interrupt binding)
> +
> +Optional properties:
> +  - clocks: clock specifier (refer to the common clock binding)

Won't you also need a clock-names property since there are two clocks?

> +
> +Example:
> +
> +	sata: ahci@218000 {
> +		compatible = "ti,da850-ahci";
> +		reg = <0x218000 0x2000>, <0x22c018 0x4>;
> +		interrupts = <67>;
> +	};
>

It would be nice to have clocks and clock-names in the example as well.

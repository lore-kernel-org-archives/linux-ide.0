From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v5 01/14] devicetree: bindings: add bindings for
 ahci-da850
Date: Fri, 20 Jan 2017 19:02:08 +0530
Message-ID: <5615fb6b-af26-c2fb-1f97-416548a9faaf@ti.com>
References: <1484911325-23425-1-git-send-email-bgolaszewski@baylibre.com>
 <1484911325-23425-2-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484911325-23425-2-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Kevin Hilman <khilman@kernel.org>, Patrick Titiano <ptitiano@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, David Lechner <david@lechnology.com>
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

Hi Rob,

On Friday 20 January 2017 04:51 PM, Bartosz Golaszewski wrote:
> Add DT bindings for the TI DA850 AHCI SATA controller.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Could you ack this binding?

Thanks,
Sekhar

> ---
>  Documentation/devicetree/bindings/ata/ahci-da850.txt | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ata/ahci-da850.txt
> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-da850.txt b/Documentation/devicetree/bindings/ata/ahci-da850.txt
> new file mode 100644
> index 0000000..268fe87
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/ahci-da850.txt
> @@ -0,0 +1,15 @@
> +Device tree binding for the TI DA850 AHCI SATA Controller
> +---------------------------------------------------------
> +
> +Required properties:
> +  - compatible: must be "ti,da850-ahci"
> +  - reg: physical base addresses and sizes of the controller's register areas
> +  - interrupts: interrupt specifier (refer to the interrupt binding)
> +
> +Example:
> +
> +	sata: sata@218000 {
> +		compatible = "ti,da850-ahci";
> +		reg = <0x218000 0x2000>, <0x22c018 0x4>;
> +		interrupts = <67>;
> +	};
> 

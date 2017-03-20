From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: ata: add DT bindings for ahci-dm816
 SATA controller
Date: Mon, 20 Mar 2017 17:13:33 -0500
Message-ID: <20170320221333.essgja7mumdhzps2@rob-hp-laptop>
References: <1489489491-14195-1-git-send-email-bgolaszewski@baylibre.com>
 <1489489491-14195-2-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1489489491-14195-2-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Tejun Heo <tj@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Neil Armstrong <narmstrong@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, Tony Lindgren <tony@atomide.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, Mar 14, 2017 at 12:04:50PM +0100, Bartosz Golaszewski wrote:
> Add DT bindings for the onboard SATA controller present on the DM816x
> SoCs.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  .../devicetree/bindings/ata/ahci-dm816.txt          | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ata/ahci-dm816.txt

Acked-by: Rob Herring <robh@kernel.org>

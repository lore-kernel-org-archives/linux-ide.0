From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/7] dt-bindings: ata: rename brcm,sata-brcmstb.txt to
 brcm,sata-brcm.txt
Date: Mon, 20 Jun 2016 08:09:33 -0500
Message-ID: <20160620130933.GA25092@rob-hp-laptop>
References: <1466085215-10246-1-git-send-email-yendapally.reddy@broadcom.com>
 <1466085215-10246-2-git-send-email-yendapally.reddy@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1466085215-10246-2-git-send-email-yendapally.reddy@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
Cc: Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Russell King <linux@armlinux.org.uk>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Jaedon Shin <jaedon.shin@gmail.com>, Anup Patel <anup.patel@broadcom.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu, Jun 16, 2016 at 09:53:29AM -0400, Yendapally Reddy Dhananjaya Reddy wrote:
> Renames the dt bindings document of Broadcom STB ahci driver to
> common Broadcom ahci driver bindings document
> 
> Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
> ---
>  .../bindings/ata/{brcm,sata-brcmstb.txt => brcm,sata-brcm.txt}    | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>  rename Documentation/devicetree/bindings/ata/{brcm,sata-brcmstb.txt => brcm,sata-brcm.txt} (81%)

Acked-by: Rob Herring <robh@kernel.org>

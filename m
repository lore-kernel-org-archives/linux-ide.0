From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 01/14] devicetree: bindings: add bindings for
 ahci-da850
Date: Fri, 27 Jan 2017 14:58:54 -0600
Message-ID: <20170127205853.nzyznc7xu5eaqd7w@rob-hp-laptop>
References: <1485190856-4711-1-git-send-email-bgolaszewski@baylibre.com>
 <1485190856-4711-2-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:32782 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750839AbdA0U64 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 27 Jan 2017 15:58:56 -0500
Content-Disposition: inline
In-Reply-To: <1485190856-4711-2-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Patrick Titiano <ptitiano@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Tejun Heo <tj@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, David Lechner <david@lechnology.com>, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Jan 23, 2017 at 06:00:43PM +0100, Bartosz Golaszewski wrote:
> Add DT bindings for the TI DA850 AHCI SATA controller.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  Documentation/devicetree/bindings/ata/ahci-da850.txt | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ata/ahci-da850.txt

Acked-by: Rob Herring <robh@kernel.org>

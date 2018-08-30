From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v4 00/13] ata: ahci_platform: support allwinner R40 AHCI
Date: Thu, 30 Aug 2018 14:31:34 -0600
Message-ID: <f5838eae-fa6c-8699-14a4-95d0daa8a960@kernel.dk>
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180830190120.722-1-clabbe.montjoie@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Corentin Labbe <clabbe.montjoie@gmail.com>, hdegoede@redhat.com, kishon@ti.com, mark.rutland@arm.com, maxime.ripard@bootlin.com, robh+dt@kernel.org, wens@csie.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
List-Id: linux-ide@vger.kernel.org

On 8/30/18 1:01 PM, Corentin Labbe wrote:
> Hello
> 
> This patchset add support for allwinner R40 AHCI controller.
> 
> The whole patchset is tested on sun8i-r40-bananapi-m2-ultra and
> on sun7i-a20-cubieboard2 which doesnt have any of the ressources added
> by this serie, so no regression should come with it.
> 
> The last patch(ata: ahci_sunxi: remove PHY code) should not be merged,
> but will be resent for inclustion when all patchs will have hit linus
> tree.

Applied 1-12 with Hans's blessing, thanks Corentin.

-- 
Jens Axboe

From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v5 0/9] ata: ahci_platform: support allwinner R40 AHCI
Date: Mon, 3 Sep 2018 08:26:22 -0600
Message-ID: <f70d43de-1305-997e-687a-d6e9978e37f5@kernel.dk>
References: <20180903100201.23131-1-clabbe.montjoie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180903100201.23131-1-clabbe.montjoie@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Corentin Labbe <clabbe.montjoie@gmail.com>, hdegoede@redhat.com, mark.rutland@arm.com, maxime.ripard@bootlin.com, robh+dt@kernel.org, wens@csie.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
List-Id: linux-ide@vger.kernel.org

On 9/3/18 4:01 AM, Corentin Labbe wrote:
> This patchset add support for allwinner R40 AHCI controller.
> 
> The whole patchset is tested on sun8i-r40-bananapi-m2-ultra and
> on sun7i-a20-cubieboard2 which doesnt have any of the ressources added
> by this serie, so no regression should come with it.
> 
> Patchs 1-7 should go via the ata tree
> Patchs 8,9 should go via the sunxi tree

Applied 1-7 for 4.20, thanks everyone.

-- 
Jens Axboe

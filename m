From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] ata: add Buddha PATA controller driver
Date: Thu, 18 Oct 2018 05:41:18 -0700
Message-ID: <20181018124118.GA10376@infradead.org>
References: <CGME20181018122951eucas1p2be43dc17df8d2c754e771785b3ad7457@eucas1p2.samsung.com>
 <20181018122951eucas1p2be43dc17df8d2c754e771785b3ad7457~es8dn4Tg90035600356eucas1p2H@eucas1p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181018122951eucas1p2be43dc17df8d2c754e771785b3ad7457~es8dn4Tg90035600356eucas1p2H@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Michael Schmitz <schmitzmic@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

> +static int __init pata_buddha_init_one(void)
> +{
> +	struct zorro_dev *z = NULL;
> +
> +	while ((z = zorro_find_device(ZORRO_WILDCARD, z))) {

I'm not really an m68k expert, but shouldn't this implement a
struct zorro_driver instead?  (or maybe two of them as xsurf
seems sufficiently different).

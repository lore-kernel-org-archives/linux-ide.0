From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] Revert "ata: sata_mv: Convert to
 devm_ioremap_resource()"
Date: Tue, 30 May 2017 16:55:48 +0300
Message-ID: <1496152548.28981.25.camel@linux.intel.com>
References: <20170530135256.9966-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20170530135256.9966-1-linus.walleij@linaro.org>
Sender: stable-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Tejun Heo <tj@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-ide@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, 2017-05-30 at 15:52 +0200, Linus Walleij wrote:
> This reverts commit 368e5fbdfc60732643f34f538823ed4bc8829827.
> 
> My NAS stopped to mount root when I went from some v4.10-rc1
> to v4.12-rc3. Investigation of the bootlog yields this:
> 
> sata_mv f1080000.sata: can't request region for resource [mem
> 0xf1080000-0xf1084fff]
> sata_mv: probe of f1080000.sata failed with error -16
> 
> Reverting this offending patch makes the sata_mv probe and
> my SATA drive can mount root again, hooray!

It's already in upstream (ata tree).

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: ftide010: fix resource printing
Date: Wed, 21 Jun 2017 18:06:47 -0400
Message-ID: <20170621220647.GC18600@htj.duckdns.org>
References: <20170621220115.4100076-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170621220115.4100076-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Hans Ulli Kroll <ulli.kroll@googlemail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu, Jun 22, 2017 at 12:00:55AM +0200, Arnd Bergmann wrote:
> The new driver uses an incorrect format string for resource_size_t:
> 
> drivers/ata/pata_ftide010.c: In function 'pata_ftide010_probe':
> drivers/ata/pata_ftide010.c:520:17: warning: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'resource_size_t {aka long long unsigned int}' [-Wformat=]
> 
> The nicest way to print the address is to pretty-print the resource
> using %pR.
> 
> Fixes: be4e456ed3a5 ("ata: Add driver for Faraday Technology FTIDE010")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to libata/for-4.13.

Thanks.

-- 
Tejun

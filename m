From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: avoid gcc-7 warning in ata_timing_quantize
Date: Thu, 11 May 2017 10:50:09 -0400
Message-ID: <20170511145009.GB30473@htj.duckdns.org>
References: <20170511125145.265782-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170511125145.265782-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Adam Manzanares <adam.manzanares@wdc.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello, Arnd.

On Thu, May 11, 2017 at 02:51:25PM +0200, Arnd Bergmann wrote:
> gcc-7 warns about the result of a constant multiplication used as
> a boolean:
> 
> drivers/ata/libata-core.c: In function 'ata_timing_quantize':
> drivers/ata/libata-core.c:3164:30: warning: '*' in boolean context, suggest '&&' instead [-Wint-in-bool-context]
> 
> This slightly rearranges the macro to simplify the code and avoid
> the warning at the same time.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Heh, that's an interesting new warning.  Appied to
libata/for-4.12-fixes.

Thanks.

-- 
tejun

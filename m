From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] ata: remove redundant 'default n' from Kconfig
Date: Wed, 10 Oct 2018 14:12:10 -0600
Message-ID: <54c0922e-7c64-8870-f8da-65531aaefbf0@kernel.dk>
References: <CGME20181009144521eucas1p2e0e8163fc5be89f3894f25c27c2b01b0@eucas1p2.samsung.com>
 <20181009144521eucas1p2e0e8163fc5be89f3894f25c27c2b01b0~b9-NKlREZ1372313723eucas1p2t@eucas1p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181009144521eucas1p2e0e8163fc5be89f3894f25c27c2b01b0~b9-NKlREZ1372313723eucas1p2t@eucas1p2.samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 10/9/18 8:45 AM, Bartlomiej Zolnierkiewicz wrote:
> 'default n' is the default value for any bool or tristate Kconfig
> setting so there is no need to write it explicitly.
> 
> Also since commit f467c5640c29 ("kconfig: only write '# CONFIG_FOO
> is not set' for visible symbols") the Kconfig behavior is the same
> regardless of 'default n' being present or not:
> 
>     ...
>     One side effect of (and the main motivation for) this change is making
>     the following two definitions behave exactly the same:
>     
>         config FOO
>                 bool
>     
>         config FOO
>                 bool
>                 default n
>     
>     With this change, neither of these will generate a
>     '# CONFIG_FOO is not set' line (assuming FOO isn't selected/implied).
>     That might make it clearer to people that a bare 'default n' is
>     redundant.
>     ...

Applied, thanks.

-- 
Jens Axboe

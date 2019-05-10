From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [GIT] IDE
Date: Fri, 10 May 2019 19:22:34 +0200
Message-ID: <4b706a9a-5cfd-db15-456b-b06476a7bc31@samsung.com>
References: <20190508.165320.2267661705586017777.davem@davemloft.net>
        <CGME20190510172236eucas1p138115389e72802f72e47158df6ed9871@eucas1p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190508.165320.2267661705586017777.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>, torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


On 05/09/2019 01:53 AM, David Miller wrote:
> 
> Finally deprecate the legacy IDE layer.
> 
> Frankly this is long overdue.
> 
> Please pull, thanks a lot!

Thank you for applying this.

I'll continue to assist in moving legacy IDE users to libata
(when time permits).

> Christoph Hellwig (1):
>       ide: officially deprecated the legacy IDE driver

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

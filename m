From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2] ata: add Buddha PATA controller driver
Date: Fri, 8 Feb 2019 06:32:45 -0700
Message-ID: <84b22f87-3301-523e-3966-cff233e740c7@kernel.dk>
References: <CGME20190207122046eucas1p12d098289e0370252d341ccfed66b8295@eucas1p1.samsung.com>
 <6924b9b1-6c38-2639-a824-f2d765abe437@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6924b9b1-6c38-2639-a824-f2d765abe437@samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Michael Schmitz <schmitzmic@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 2/7/19 5:20 AM, Bartlomiej Zolnierkiewicz wrote:
> Add Buddha PATA controller driver. It enables libata support for
> the Buddha, Catweasel and X-Surf expansion boards on the Zorro
> expansion bus.
> 
> Module removal is currently unsupported (the old IDE's buddha
> driver also doesn't support it).
> 
> Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: Michael Schmitz <schmitzmic@gmail.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Applied for 5.1 thanks Bart.

-- 
Jens Axboe

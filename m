From: Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [PATCH v3] ata: add Amiga Gayle PATA controller driver
Date: Sat, 17 Mar 2018 22:24:18 -0700
Message-ID: <CAOFm3uEb6r33V9=Maxd72pM6vdwfMkvhap01+zEd6bnDuEAVKw@mail.gmail.com>
References: <CGME20180316161549epcas1p23166605ea9922198486e0c07bd184ed8@epcas1p2.samsung.com>
 <24149929.AaKeg4hYhL@amdc3058>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <24149929.AaKeg4hYhL@amdc3058>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Tejun Heo <tj@kernel.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Michael Schmitz <schmitzmic@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Fri, Mar 16, 2018 at 9:15 AM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> Add Amiga Gayle PATA controller driver. It enables libata support
> for the on-board IDE interfaces on some Amiga models (A600, A1200,
> A4000 and A4000T) and also for IDE interfaces on the Zorro expansion
> bus (M-Tech E-Matrix 530 expansion card).
>
> Thanks to John Paul Adrian Glaubitz and Michael Schmitz for help
> with testing the driver.
>
> Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: Michael Schmitz <schmitzmic@gmail.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Philippe Ombredanne <pombredanne@nexb.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
> v3:
> - fix minor issues reported by Andy
>
> v2:
> - clarify license version (it should be GPL 2.0)
> - use SPDX header

For the use of SPDX ids, you have my ack: (I am not qualified for the rest)

Acked-by: Philippe Ombredanne <pombredanne@nexb.com>

-- 
Cordially
Philippe Ombredanne

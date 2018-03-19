From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3] ata: add Amiga Gayle PATA controller driver
Date: Mon, 19 Mar 2018 07:41:01 -0700
Message-ID: <20180319144101.GH2943022@devbig577.frc2.facebook.com>
References: <CGME20180316161549epcas1p23166605ea9922198486e0c07bd184ed8@epcas1p2.samsung.com>
 <24149929.AaKeg4hYhL@amdc3058>
 <CAOFm3uEb6r33V9=Maxd72pM6vdwfMkvhap01+zEd6bnDuEAVKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOFm3uEb6r33V9=Maxd72pM6vdwfMkvhap01+zEd6bnDuEAVKw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Michael Schmitz <schmitzmic@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Hello,

On Sat, Mar 17, 2018 at 10:24:18PM -0700, Philippe Ombredanne wrote:
> > v2:
> > - clarify license version (it should be GPL 2.0)
> > - use SPDX header
> 
> For the use of SPDX ids, you have my ack: (I am not qualified for the rest)
> 
> Acked-by: Philippe Ombredanne <pombredanne@nexb.com>

I don't think it's a good idea to add this acked-by when it's purely
based on a single liner license tag.  I understand that you want to
encourage use of the new tags but this can be misleading and it'd be
great if you reconsider sending out acks like this.

Thanks.

-- 
tejun

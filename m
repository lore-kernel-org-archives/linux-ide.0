From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/3] ata: ftide010: constify ata_port_info
Date: Thu, 24 Aug 2017 21:46:12 +0200
Message-ID: <CACRpkdZt5-VojnYtqZ669-CjrUDbDYPU1L9Lit+ZR9Yo19x01w@mail.gmail.com>
References: <1503568201-9991-1-git-send-email-arvind.yadav.cs@gmail.com> <1503568201-9991-2-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503568201-9991-2-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu, Aug 24, 2017 at 11:49 AM, Arvind Yadav
<arvind.yadav.cs@gmail.com> wrote:

> ata_port_info are not supposed to change at runtime. All functions
> working with ata_port_info provided by <linux/libata.h> work with
> const ata_port_info. So mark the non-const structs as const.
>
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

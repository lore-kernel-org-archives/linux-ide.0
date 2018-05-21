From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 10/33] pata_hpt37x: use match_string() helper
Date: Tue, 22 May 2018 00:46:21 +0300
Message-ID: <CAHp75Vd7KbdFw_Y+h7T15K+GgDdEj0JJT7EhCMO56r5rhaQdfA@mail.gmail.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com> <1526903890-35761-11-git-send-email-xieyisheng1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526903890-35761-11-git-send-email-xieyisheng1@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Mon, May 21, 2018 at 2:57 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
> match_string() returns the index of an array for a matching string,
> which can be used intead of open coded variant.
>

https://www.spinics.net/lists/linux-ide/msg55658.html

> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: linux-ide@vger.kernel.org


-- 
With Best Regards,
Andy Shevchenko

From: Frank Lee <tiny.windzz@gmail.com>
Subject: Re: [PATCH] ata: pata_macio: add of_node_put()
Date: Fri, 21 Dec 2018 09:09:48 +0800
Message-ID: <CAEExFWuNc+3RyEHvpfAxtFFeFKk9nyVE_ZKHcpy2T6VWOEY1QA@mail.gmail.com>
References: <CGME20181121130510epcas3p4498edc67a02f61a6aa8e55efa9349681@epcas3p4.samsung.com>
 <20181121130439.22255-1-tiny.windzz@gmail.com> <b3331d3f-3bfd-f3ce-cea1-30c4b13e6374@samsung.com>
 <a925d66a-09ea-b6db-8043-df58548da192@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a925d66a-09ea-b6db-8043-df58548da192@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Fri, Dec 21, 2018 at 2:01 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 12/20/18 10:03 AM, Bartlomiej Zolnierkiewicz wrote:
> >
> > On 11/21/2018 02:04 PM, Yangtao Li wrote:
> >> of_find_node_by_path() acquires a reference to the node
> >> returned by it and that reference needs to be dropped by its caller.
> >> bl_idle_init() doesn't do that, so fix it.
> >>
> >> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> >
> > Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>
> Yangtao, were you going to resend this one?
Actually,I've rensent the v2 at  Nov 22.And  I just changed the changelog.
Can you pick it up?

Thanks,
Yangtao

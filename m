From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] ata: ftide010: Add a quirk for SQ201
Date: Mon, 27 Aug 2018 22:22:19 +0200
Message-ID: <CACRpkdbj1XU68xEuNy4yF_Tyo+Axup4vP4GpGYH0cnGZR59UGA@mail.gmail.com>
References: <20180715200929.10116-1-linus.walleij@linaro.org>
 <20180716191757.GO72677@devbig577.frc2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180716191757.GO72677@devbig577.frc2.facebook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Paulius Zaleckas <paulius.zaleckas@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Hans Ulli Kroll <ulli.kroll@googlemail.com>, linux-ide@vger.kernel.org, Janos Laube <janos.dev@gmail.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-ide@vger.kernel.org

On Mon, Jul 16, 2018 at 9:18 PM Tejun Heo <tj@kernel.org> wrote:
> On Sun, Jul 15, 2018 at 10:09:29PM +0200, Linus Walleij wrote:
> > The DMA is broken on this specific device for some unknown
> > reason (probably badly designed or plain broken interface
> > electronics) and will only work with PIO. Other users of
> > the same hardware does not have this problem.
> >
> > Add a specific quirk so that this Gemini device gets
> > DMA turned off. Also fix up some code around passing the
> > port information around in probe while we're at it.
> >
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> Applied to libata/for-4.18-fixes.

This never appeared in the tree, it's still not there in v4.19-rc1!

Jens can you apply it?

Yours,
Linus Walleij

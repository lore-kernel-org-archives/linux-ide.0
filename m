From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH v4 00/13] ata: ahci_platform: support
 allwinner R40 AHCI
Date: Fri, 31 Aug 2018 10:32:53 +0800
Message-ID: <CAGb2v67miUjqeKeDh_E_XPee_0Hq1C6YrfXxsOp_=NtQY+LLmQ@mail.gmail.com>
References: <20180830190120.722-1-clabbe.montjoie@gmail.com> <f5838eae-fa6c-8699-14a4-95d0daa8a960@kernel.dk>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCMILY6JWQBBBZGRULOAKGQESOG7FCA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <f5838eae-fa6c-8699-14a4-95d0daa8a960-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org, LABBE Corentin <clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

Hi,

On Fri, Aug 31, 2018 at 4:31 AM Jens Axboe <axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org> wrote:
>
> On 8/30/18 1:01 PM, Corentin Labbe wrote:
> > Hello
> >
> > This patchset add support for allwinner R40 AHCI controller.
> >
> > The whole patchset is tested on sun8i-r40-bananapi-m2-ultra and
> > on sun7i-a20-cubieboard2 which doesnt have any of the ressources added
> > by this serie, so no regression should come with it.
> >
> > The last patch(ata: ahci_sunxi: remove PHY code) should not be merged,
> > but will be resent for inclustion when all patchs will have hit linus
> > tree.
>
> Applied 1-12 with Hans's blessing, thanks Corentin.

Please don't merge device tree ("dts") patches, i.e. patches 9-12. We will
merge them through the sunxi / armsoc tree. Having them in separate trees
introduces conflicts when we have other stuff going through our tree.

Corentin, it's best to lay out the plan to get patches merges in the cover
letter, specifically which maintainer should take which patches, or if an
immutable tag/branch is preferred, when things can't be separated cleanly.
This helps other subsystem maintainers that don't routinely deal with armsoc.

Also, we probably can't merge the last patch that removes the PHY code,
since we have to support old device trees.

Thanks
ChenYu

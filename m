From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/4] ata: Add DT bindings for Faraday Technology FTIDE010
Date: Wed, 10 May 2017 17:48:30 +0200
Message-ID: <CACRpkdbyPcC5FiqQ0khkNh4OvXeft_p4uwwH_yvpiiePkHcRhw@mail.gmail.com>
References: <CGME20170506121118epcas2p1b2a2d1a8005a37582a73c0e7be4b1a1b@epcas2p1.samsung.com>
 <1678111.DmiVNKW3dQ@amdc3058> <CACRpkdbmOsrxKX8=a7bvcF+c=Q2tfwYQVt0=cz+_jhDyadwa2A@mail.gmail.com>
 <6650456.qCJGCGKGLl@amdc3058>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <6650456.qCJGCGKGLl@amdc3058>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Janos Laube <janos.dev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paulius Zaleckas <paulius.zaleckas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, openwrt-devel-p3rKhJxN3npAfugRpC6u6w@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Hans Ulli Kroll <ulli.kroll-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, John Feng-Hsin Chiang <john453-w0jeGXs5+AWXmMXjJBpWqg@public.gmane.org>, Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

On Wed, May 10, 2017 at 3:59 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> On Monday, May 08, 2017 10:26:49 PM Linus Walleij wrote:
>> On Mon, May 8, 2017 at 12:47 PM, Bartlomiej Zolnierkiewicz
>> <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:

>> So depending on whether they use an FPGA or an ASIC the values are
>> different, no matter what frequency (50 or 66 MHz) is used. So it is not
>> derived from frequency.
>>
>> So I think it makes most sense to have it in the device tree as we don't
>> know what designs are out there.
>
> I still would prefer to keep timing values private to the driver and just
> select the controller type (FPGA/ASIC) using the device tree.

OK I'll revert to static timings in the driver, no problem.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

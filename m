From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [RESEND PATCH] arm: assabet_defconfig: disable IDE subsystem
Date: Mon, 12 Dec 2016 13:45:03 +0100
Message-ID: <5370936.ZbqF1HU8Jz@amdc3058>
References: <1467991490-24895-1-git-send-email-b.zolnierkie@samsung.com>
 <m27fcn3pb1.fsf@baylibre.com> <578CEB74.2080002@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <578CEB74.2080002@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org


Hi,

On Monday, July 18, 2016 08:15:08 PM Sekhar Nori wrote:
> On Friday 15 July 2016 08:45 PM, Kevin Hilman wrote:
> > Arnd Bergmann <arnd@arndb.de> writes:
> > 
> >> On Wednesday, July 13, 2016 12:59:23 PM CEST Bartlomiej Zolnierkiewicz wrote:
> >>>
> >>> On Friday, July 08, 2016 10:23:48 PM Arnd Bergmann wrote:
> >>>> On Friday, July 8, 2016 5:24:41 PM CEST Bartlomiej Zolnierkiewicz wrote:
> >>>>> This patch disables deprecated IDE subsystem in assabet_defconfig
> >>>>> (no IDE host drivers are selected in this config so there is no
> >>>>> valid reason to enable IDE subsystem itself).
> >>>>>
> >>>>> Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> >>>>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> >>>>
> >>>> I think the series makes a lot of sense. I have checked your assertions
> >>>> in the changelogs and found no flaws in your logic, so I think we should
> >>>> take them all through arm-soc unless there are other concerns.
> >>>
> >>> Thank you.
> >>>
> >>> Should I resend everything or just patches that were not reposted yet
> >>> (the ones that were marked as RFT initially and got no feedback)?
> >>
> >> I'd be fine with just getting a pull request with all the patches that
> >> had no negative feedback and that were not already applied (if any).
> >>
> >>>> Do you have a list of ARM defconfigs that keep using CONFIG_IDE and
> >>>> how you determined that they need it?
> >>>
> >>> The only such defconfig is davinci_all_defconfig which uses
> >>> palm_bk3710 host driver (CONFIG_BLK_DEV_PALMCHIP_BK3710).
> >>>
> >>>> I know that ARCH_RPC/ARCH_ACORN has a couple of special drivers that
> >>>> have no libata replacement, are there any others like that, or are
> >>>> they all platforms that should in theory work with libata but need
> >>>> testing?
> >>>
> >>> All platforms except ARCH_ACORN, ARCH_DAVINCI & ARCH_RPC should work
> >>> with libata.
> >>
> >> Adding Sekhar and Kevin for DaVinci: At first sight, palm_bk3710 looks
> >> fairly straightforward (meaning someone has to do a few day's work)
> >> to convert into a libata driver.
> >>
> >> As this is on on-chip controller that is part of a dm644x and dm646x,
> >> it should also not be hard to test (as long as someone can find
> >> a hard drive to plug in).
> > 
> > I have a hard drive, but don't have any dm64xx hardware anymore to test
> > this.  My last working dm644x board died last year.
> 
> I have a working DM6446 EVM. I was able to connect a hard drive to it
> and do some basic tests with v4.6 kernel.
> 
> I will look into converting the driver to libata. Might take some time
> because this is unfamiliar territory for me.

Do you need some help with it?

I can provide you with draft driver patch if you want.

I'm also on #kernel IRC channel in case you have some questions..

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

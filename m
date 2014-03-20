From: Pratyush Anand <pratyush.anand@st.com>
Subject: Re: [PATCH RESEND] ARM: SPEAr1340: static-ize SATA functions
Date: Thu, 20 Mar 2014 14:25:09 +0530
Message-ID: <20140320085509.GB4607@pratyush-vbox>
References: <1678906.b5uh0Nm7QE@amdc1032>
 <CAOh2x=nr1mrkcFk8nQFwNXxCqMPiN1Hq4=f1wwN=i65StawJ1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAOh2x=nr1mrkcFk8nQFwNXxCqMPiN1Hq4=f1wwN=i65StawJ1Q@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: spear-devel <spear-devel@list.st.com>, Arnd Bergmann <arnd@arndb.de>, Mohit Kumar <mohit.kumar@st.com>, Shiraz Hashim <shiraz.hashim@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "...)" <linux-ide@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-ide@vger.kernel.org

On Tue, Mar 18, 2014 at 07:00:08PM +0800, Viresh Kumar wrote:
> On Tue, Mar 18, 2014 at 4:28 PM, Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
> > Make sata_miphy_exit(), sata_suspend() and sata_resume() static.
> >
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> > Previous submission:
> > https://lkml.org/lkml/2013/10/4/369
> >
> >  arch/arm/mach-spear/spear1340.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm/mach-spear/spear1340.c b/arch/arm/mach-spear/spear1340.c
> > index 3fb6834..e0e4251 100644
> > --- a/arch/arm/mach-spear/spear1340.c
> > +++ b/arch/arm/mach-spear/spear1340.c
> > @@ -93,7 +93,7 @@ static int sata_miphy_init(struct device *dev, void __iomem *addr)
> >         return 0;
> >  }
> >
> > -void sata_miphy_exit(struct device *dev)
> > +static void sata_miphy_exit(struct device *dev)
> >  {
> >         writel(0, SPEAR1340_PCIE_SATA_CFG);
> >         writel(0, SPEAR1340_PCIE_MIPHY_CFG);
> > @@ -107,7 +107,7 @@ void sata_miphy_exit(struct device *dev)
> >         msleep(20);
> >  }
> >
> > -int sata_suspend(struct device *dev)
> > +static int sata_suspend(struct device *dev)
> >  {
> >         if (dev->power.power_state.event == PM_EVENT_FREEZE)
> >                 return 0;
> > @@ -117,7 +117,7 @@ int sata_suspend(struct device *dev)
> >         return 0;
> >  }
> >
> > -int sata_resume(struct device *dev)
> > +static int sata_resume(struct device *dev)
> >  {
> >         if (dev->power.power_state.event == PM_EVENT_THAW)
> >                 return 0;
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

This patch will not be needed any more, since sata platform code has
already been cleaned up.

See:
https://lkml.org/lkml/2014/2/28/174

Regards
Pratyush

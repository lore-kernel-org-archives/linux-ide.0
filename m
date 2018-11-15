From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v3 0/7] include: add
 setbits32/clrbits32/clrsetbits32/setbits64/clrbits64/clrsetbits64
Date: Thu, 15 Nov 2018 09:33:48 +0000
Message-ID: <20181115093348.GV30658@n2100.armlinux.org.uk>
References: <1540366553-18541-1-git-send-email-clabbe@baylibre.com>
 <20181024085700.GR30658@n2100.armlinux.org.uk>
 <20181115093034.GB23965@Red>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181115093034.GB23965@Red>
Sender: linux-kernel-owner@vger.kernel.org
To: LABBE Corentin <clabbe@baylibre.com>
Cc: Gilles.Muller@lip6.fr, Julia.Lawall@lip6.fr, agust@denx.de, airlied@linux.ie, alexandre.torgue@st.com, alistair@popple.id.au, benh@kernel.crashing.org, carlo@caione.org, davem@davemloft.net, galak@kernel.crashing.org, joabreu@synopsys.com, khilman@baylibre.com, matthias.bgg@gmail.com, maxime.ripard@bootlin.com, michal.lkml@markovi.net, mpe@ellerman.id.au, mporter@kernel.crashing.org, narmstrong@baylibre.com, nicolas.palix@imag.fr, oss@buserror.net, paulus@samba.org, peppe.cavallaro@st.com, tj@kernel.org, vitb@kernel.crashing.org, wens@csie.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-ide@vger.kernel.org, linux-sunxi@googlegroups.com, linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org, linuxppc-dev@lists.ozlabs.
List-Id: linux-ide@vger.kernel.org

On Thu, Nov 15, 2018 at 10:30:34AM +0100, LABBE Corentin wrote:
> On Wed, Oct 24, 2018 at 09:57:00AM +0100, Russell King - ARM Linux wrote:
> > On Wed, Oct 24, 2018 at 07:35:46AM +0000, Corentin Labbe wrote:
> > > This patchset adds a new set of functions which are open-coded in lot of
> > > place.
> > > Basicly the pattern is always the same, "read, modify a bit, write"
> > > some driver and the powerpc arch already have thoses pattern them as functions. (like ahci_sunxi.c or dwmac-meson8b)
> > 
> > The advantage of them being open-coded is that it's _obvious_ to the
> > reviewer that there is a read-modify-write going on which, in a multi-
> > threaded environment, may need some locking (so it should trigger a
> > review of the locking around that code.)
> > 
> > With it hidden inside a helper which has no locking itself, it becomes
> > much easier to pass over in review, which means that races are much
> > more likely to go unspotted - and that is bad news.
> > 
> 
> Hello
> 
> I understand your fear, but I think the benefit overhaul thoses.
> Furthermore, drivers which I have converted does not need such locking.
> 
> If you want I can rename the header to linux/setbits-non-atomic.h for making obvious the lack of locking.

It'd probably be better in the function name - it then doesn't get
"lost" that it's non-atomic when it's included via other headers.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

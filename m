From: Simon Baatz <gmbnomis@gmail.com>
Subject: Re: [PATCH v3 0/9] ata: ahci_platform: support allwinner R40 AHCI
Date: Thu, 19 Jul 2018 02:16:42 +0200
Message-ID: <20180719001642.GA29105@gandalf>
References: <1531479786-4911-1-git-send-email-clabbe@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1531479786-4911-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Corentin Labbe <clabbe@baylibre.com>
Cc: hdegoede@redhat.com, linux@armlinux.org.uk, mark.rutland@arm.com, maxime.ripard@free-electrons.com, robh+dt@kernel.org, tj@kernel.org, wens@csie.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, thierry.reding@gmail.com, icenowy@aosc.io
List-Id: linux-ide@vger.kernel.org

Hi Corentin,

On Fri, Jul 13, 2018 at 11:02:57AM +0000, Corentin Labbe wrote:
> Hello
> 
> This patchset add support for allwinner R40 AHCI controller.
> 
> This controller need two regulator and one reset which is unsupported
> for the moment on ahci_platform.
> 
> So this patchset add support for reset and regulator for AHCI
> controller.
> It add also support for non-target regulator per SATA port.
> 
> The whole patchset is tested on sun8i-r40-bananapi-m2-ultra and
> on sun7i-a20-cubieboard2 which doesnt have any of the ressources added
> by this serie, so no regression should come with it.

I tested on sun8i-v40-bananapi-m2-berry (with an adapted device
tree).  I got it to work, but only if the U-Boot has support for AHCI
already (from the Banana Pi M2 Ultra support).  With an U-Boot that
hasn't, the system hangs at boot (probably when probing ahci-sunxi). 

Did you test this case on the M2 Ultra board?  (I think SATA should
work the same on both boards, but there may be subtle differences)

Perhaps I did not apply all necessary patches. I took this series and
your minor fixes series for ahci_platform. 

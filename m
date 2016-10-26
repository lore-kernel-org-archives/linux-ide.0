From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [RESEND PATCH] arm: assabet_defconfig: disable IDE subsystem
Date: Wed, 26 Oct 2016 19:01:12 +0200
Message-ID: <1913139.FJW82OAuEF@amdc3058>
References: <1467991490-24895-1-git-send-email-b.zolnierkie@samsung.com>
 <4818149.nzRaU7vJQE@amdc1976> <4264651.gPKphdYuCx@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:56411 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754944AbcJZRBR (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 26 Oct 2016 13:01:17 -0400
In-reply-to: <4264651.gPKphdYuCx@wuerfel>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Olof Johansson <olof@lixom.net>, Kevin Hilman <khilman@baylibre.com>, "Nori, Sekhar" <nsekhar@ti.com>


Hi,

On Wednesday, July 13, 2016 04:37:31 PM Arnd Bergmann wrote:
> On Wednesday, July 13, 2016 12:59:23 PM CEST Bartlomiej Zolnierkiewicz wrote:
> > 
> > On Friday, July 08, 2016 10:23:48 PM Arnd Bergmann wrote:
> > > On Friday, July 8, 2016 5:24:41 PM CEST Bartlomiej Zolnierkiewicz wrote:
> > > > This patch disables deprecated IDE subsystem in assabet_defconfig
> > > > (no IDE host drivers are selected in this config so there is no
> > > > valid reason to enable IDE subsystem itself).
> > > > 
> > > > Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> > > > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > > 
> > > I think the series makes a lot of sense. I have checked your assertions
> > > in the changelogs and found no flaws in your logic, so I think we should
> > > take them all through arm-soc unless there are other concerns.
> > 
> > Thank you.
> > 
> > Should I resend everything or just patches that were not reposted yet
> > (the ones that were marked as RFT initially and got no feedback)?
> 
> I'd be fine with just getting a pull request with all the patches that
> had no negative feedback and that were not already applied (if any).

Here it is (sorry for taking so long).

The following changes since commit 07d9a380680d1c0eb51ef87ff2eab5c994949e69:

  Linux 4.9-rc2 (2016-10-23 17:10:14 -0700)

are available in the git repository at:

  https://github.com/bzolnier/linux.git v4.9-rc2-arm-configs-pata

for you to fetch changes up to bc9c6cc857849ec0d83bd13c1812bae9345dc553:

  arm: spitz_defconfig: convert to use libata PATA drivers (2016-10-26 18:43:33 +0200)

----------------------------------------------------------------
Bartlomiej Zolnierkiewicz (16):
      arm: assabet_defconfig: disable IDE subsystem
      arm: badge4_defconfig: disable IDE subsystem
      arm: cerfcube_defconfig: disable IDE subsystem
      arm: lart_defconfig: disable IDE subsystem
      arm: mainstone_defconfig: disable IDE subsystem
      arm: shannon_defconfig: disable IDE subsystem
      arm: collie_defconfig: convert to use libata PATA drivers
      arm: omap1_defconfig: convert to use libata PATA drivers
      arm: am200epdkit_defconfig: convert to use libata PATA drivers
      arm: corgi_defconfig: convert to use libata PATA drivers
      arm: h3600_defconfig: convert to use libata PATA drivers
      arm: ixp4xx_defconfig: convert to use libata PATA drivers
      arm: jornada720_defconfig: convert to use libata PATA drivers
      arm: netwinder_defconfig: convert to use libata PATA drivers
      arm: s3c2410_defconfig: convert to use libata PATA drivers
      arm: spitz_defconfig: convert to use libata PATA drivers

 arch/arm/configs/am200epdkit_defconfig |  5 +++--
 arch/arm/configs/assabet_defconfig     |  1 -
 arch/arm/configs/badge4_defconfig      |  2 --
 arch/arm/configs/cerfcube_defconfig    |  1 -
 arch/arm/configs/collie_defconfig      |  5 +++--
 arch/arm/configs/corgi_defconfig       |  7 +++----
 arch/arm/configs/h3600_defconfig       |  5 +++--
 arch/arm/configs/ixp4xx_defconfig      |  9 +++++----
 arch/arm/configs/jornada720_defconfig  |  5 +++--
 arch/arm/configs/lart_defconfig        |  2 --
 arch/arm/configs/mainstone_defconfig   |  1 -
 arch/arm/configs/netwinder_defconfig   |  7 ++++---
 arch/arm/configs/omap1_defconfig       |  4 ++--
 arch/arm/configs/s3c2410_defconfig     | 10 +++-------
 arch/arm/configs/shannon_defconfig     |  1 -
 arch/arm/configs/spitz_defconfig       |  8 +++-----
 16 files changed, 32 insertions(+), 41 deletions(-)


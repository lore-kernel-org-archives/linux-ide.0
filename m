From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [RESEND PATCH] arm: assabet_defconfig: disable IDE subsystem
Date: Mon, 31 Oct 2016 19:24:46 +0100
Message-ID: <1512445.DtnT51NQqg@amdc3058>
References: <1467991490-24895-1-git-send-email-b.zolnierkie@samsung.com>
 <20161031154622.GB1041@n2100.armlinux.org.uk> <2291876.8LAt3RcuXX@amdc3058>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:35645 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S943966AbcJaSYv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 31 Oct 2016 14:24:51 -0400
In-reply-to: <2291876.8LAt3RcuXX@amdc3058>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Olof Johansson <olof@lixom.net>, Kevin Hilman <khilman@baylibre.com>, "Nori, Sekhar" <nsekhar@ti.com>

On Monday, October 31, 2016 07:14:13 PM Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> On Monday, October 31, 2016 03:46:22 PM Russell King - ARM Linux wrote:
> > On Wed, Oct 26, 2016 at 07:01:12PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > 
> > > Hi,
> > > 
> > > On Wednesday, July 13, 2016 04:37:31 PM Arnd Bergmann wrote:
> > > > On Wednesday, July 13, 2016 12:59:23 PM CEST Bartlomiej Zolnierkiewicz wrote:
> > > > > 
> > > > > On Friday, July 08, 2016 10:23:48 PM Arnd Bergmann wrote:
> > > > > > On Friday, July 8, 2016 5:24:41 PM CEST Bartlomiej Zolnierkiewicz wrote:
> > > > > > > This patch disables deprecated IDE subsystem in assabet_defconfig
> > > > > > > (no IDE host drivers are selected in this config so there is no
> > > > > > > valid reason to enable IDE subsystem itself).
> > > > > > > 
> > > > > > > Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> > > > > > > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > > > > > 
> > > > > > I think the series makes a lot of sense. I have checked your assertions
> > > > > > in the changelogs and found no flaws in your logic, so I think we should
> > > > > > take them all through arm-soc unless there are other concerns.
> > > > > 
> > > > > Thank you.
> > > > > 
> > > > > Should I resend everything or just patches that were not reposted yet
> > > > > (the ones that were marked as RFT initially and got no feedback)?
> > > > 
> > > > I'd be fine with just getting a pull request with all the patches that
> > > > had no negative feedback and that were not already applied (if any).
> > > 
> > > Here it is (sorry for taking so long).
> > 
> > I've just been digging in the dmesg logs from when I was using the
> > Assabet+Neponset as my firewall, and it was having to use the IDE
> > ide-cs driver rather than the pata pcmcia driver.
> > 
> > I don't recall whether the pata pcmcia driver was a problem or not,
> > as the PCMCIA interface can't cope with _any_ 32-bit accesses.  I
> > think PATA tries to use the "highest" possible access size by
> > default...
> 
> It doesn't actually - it defaults to 16-bits for PIO data access and
> you must explicitly enable 32-bits using ATA_PFLAG_PIO32 port flag
> (pata_pcmcia doesn't set it so it should be okay).  Also taskfile
> registers are accessed using 8-bits access by default transport
> functions (which are used by pata_pcmcia).

Please also note that:

- assebet_defconfig currently doesn't even enable ide-cs
  (CONFIG_BLK_DEV_IDECS) in the mainline kernel

- neponset_defconfig doesn't even enable IDE (CONFIG_IDE)
  in the mainline kernel

so there is no risk of breaking anything.. :-)

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


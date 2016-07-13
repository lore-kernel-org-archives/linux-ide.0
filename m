From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [RESEND PATCH] arm: assabet_defconfig: disable IDE subsystem
Date: Wed, 13 Jul 2016 12:59:23 +0200
Message-ID: <4818149.nzRaU7vJQE@amdc1976>
References: <1467991490-24895-1-git-send-email-b.zolnierkie@samsung.com>
 <2773873.Jjn1O47GXr@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:45734 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058AbcGMLAs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Jul 2016 07:00:48 -0400
In-reply-to: <2773873.Jjn1O47GXr@wuerfel>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Olof Johansson <olof@lixom.net>


Hi,

On Friday, July 08, 2016 10:23:48 PM Arnd Bergmann wrote:
> On Friday, July 8, 2016 5:24:41 PM CEST Bartlomiej Zolnierkiewicz wrote:
> > This patch disables deprecated IDE subsystem in assabet_defconfig
> > (no IDE host drivers are selected in this config so there is no
> > valid reason to enable IDE subsystem itself).
> > 
> > Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> 
> I think the series makes a lot of sense. I have checked your assertions
> in the changelogs and found no flaws in your logic, so I think we should
> take them all through arm-soc unless there are other concerns.

Thank you.

Should I resend everything or just patches that were not reposted yet
(the ones that were marked as RFT initially and got no feedback)?

> Do you have a list of ARM defconfigs that keep using CONFIG_IDE and
> how you determined that they need it?

The only such defconfig is davinci_all_defconfig which uses
palm_bk3710 host driver (CONFIG_BLK_DEV_PALMCHIP_BK3710).

> I know that ARCH_RPC/ARCH_ACORN has a couple of special drivers that
> have no libata replacement, are there any others like that, or are
> they all platforms that should in theory work with libata but need
> testing?

All platforms except ARCH_ACORN, ARCH_DAVINCI & ARCH_RPC should work
with libata.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


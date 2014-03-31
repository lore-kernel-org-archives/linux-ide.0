From: Marek Vasut <marex@denx.de>
Subject: Re: Warning at ahci_enable_ahci() during resume
Date: Mon, 31 Mar 2014 07:25:26 +0200
Message-ID: <201403310725.26460.marex@denx.de>
References: <CAOMZO5BXMmtsqQAsfdPw5fkziNUABBYwab69gbdGDMM_9bmMFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:42191 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753208AbaCaFZ3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 31 Mar 2014 01:25:29 -0400
In-Reply-To: <CAOMZO5BXMmtsqQAsfdPw5fkziNUABBYwab69gbdGDMM_9bmMFA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Shawn Guo <shawn.guo@freescale.com>, r65037@freescale.com, hdegoede@redhat.com, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Friday, March 28, 2014 at 03:38:53 PM, Fabio Estevam wrote:
> Hi,
> 
> I am running linux-next 20140328 on a mx6qsabresd board and I am
> getting the following warning at ahci_enable_ahci() during a
> suspend/resume cycle:
> 
> /$ echo mem > /sys/power/state
> PM: Syncing filesystems ... done.
> Freezing user space processes ... (elapsed 0.001 seconds) done.
> Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> Suspending console(s) (use no_console_suspend to debug)
> 
> , and then I press the GPIO key to wake-up the system:

Looks like the AHCI link doesn't come up again. Can you check if the clock are 
enabled? Are the correct bits programmed into the MX6's AHCI registers? Also see 
imx_sata_enable() function for the bits which are programmed into the GPR 
registers too and check if they are there.

Best regards,
Marek Vasut

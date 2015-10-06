From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [RFT PATCH] mips: bigsur_defconfig: convert to use libata PATA
 drivers
Date: Tue, 6 Oct 2015 16:23:12 +0200
Message-ID: <20151006142312.GA28984@linux-mips.org>
References: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:53067 "EHLO
	cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979AbbJFOXS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Oct 2015 10:23:18 -0400
Content-Disposition: inline
In-Reply-To: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Sep 14, 2015 at 05:51:42PM +0200, Bartlomiej Zolnierkiewicz wrote:

> IDE subsystem has been deprecated since 2009 and the majority
> (if not all) of Linux distributions have switched to use
> libata for ATA support exclusively.  However there are still
> some users (mostly old or/and embedded non-x86 systems) that
> have not converted from using IDE subsystem to libata PATA
> drivers.  This doesn't seem to be good thing in the long-term
> for Linux as while there is less and less PATA systems left
> in use:
> 
> * testing efforts are divided between two subsystems
> 
> * having duplicate drivers for same hardware confuses users
> 
> This patch converts bigsur_defconfig to use libata PATA
> drivers (tc86c001 IDE host driver has no corresponding libata
> driver yet so it is not converted).
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
> Build tested only.
> If you have affected hardware please test.  Thank you.

Nobody replied so I applied all 17 patches.

I've only too often updated the config I'm actually using to use libata
so thanks to doing this for all configs!

  Ralf

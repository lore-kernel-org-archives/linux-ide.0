From: "John W. Linville" <linville@tuxdriver.com>
Subject: Re: ahci or ata-piix for ich6?
Date: Sat, 30 Apr 2005 13:18:28 -0400
Message-ID: <20050430171827.GA14203@tuxdriver.com>
References: <d502d3$sl8$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ra.tuxdriver.com ([24.172.12.4]:15121 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S261310AbVD3RSb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Apr 2005 13:18:31 -0400
Content-Disposition: inline
In-Reply-To: <d502d3$sl8$1@sea.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sean <seandarcy2@gmail.com>
Cc: linux-ide@vger.kernel.org

On Sat, Apr 30, 2005 at 09:55:17AM -0400, sean wrote:
> I have a mobo with the 915G, 82801FB/FBW (ICH6/ICH6W) SATA 
> controller. Which SATA driver in 2.6.12-rc3?

If you configured AHCI in the BIOS, then ahci should work.  Otherwise
ata_piix is the choice.  In fact, for ICH6 ata_piix is smart enough
to disable AHCI on its own, if it gets loaded.  So, ata_piix is the
safe choice (ignoring any issues favoring AHCI).

For those observing, the reason this is an issue is because Intel
used the same PCI ID for ICH6 in either IDE or AHCI mode.  So, there
is no obvious choice for kudzu and the like to make.

John
-- 
John W. Linville
linville@tuxdriver.com

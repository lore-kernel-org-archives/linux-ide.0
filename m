From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH RESEND v2] sata/mvebu: use #ifdef around suspend/resume
 code
Date: Fri, 20 Nov 2015 15:03:00 -0500
Message-ID: <20151120200300.GA31848@mtj.duckdns.org>
References: <8025767.rG7ykO9yUZ@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f179.google.com ([209.85.160.179]:34339 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759582AbbKTUDS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Nov 2015 15:03:18 -0500
Content-Disposition: inline
In-Reply-To: <8025767.rG7ykO9yUZ@wuerfel>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Thu, Nov 19, 2015 at 03:16:30PM +0100, Arnd Bergmann wrote:
> The newly added suspend/resume implementation for ahci_mvebu causes
> a link error when CONFIG_PM_SLEEP is disabled:
> 
> ERROR: "ahci_platform_suspend_host" [drivers/ata/ahci_mvebu.ko] undefined!
> ERROR: "ahci_platform_resume_host" [drivers/ata/ahci_mvebu.ko] undefined!
> 
> This adds the same #ifdef here that exists in the ahci_platform driver
> which defines the above functions.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: d6ecf1581488 ("ata: ahci_mvebu: add suspend/resume support")
> Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Applied to libata/for-4.4-fixes.

Thanks.

-- 
tejun

From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH 4.2] ata: ahci_brcmstb: Fix warnings with
 CONFIG_PM_SLEEP=n
Date: Tue, 14 Jul 2015 15:06:29 -0700
Message-ID: <20150714220629.GA21362@localhost>
References: <1436904213-9205-1-git-send-email-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:32798 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752324AbbGNWGh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Jul 2015 18:06:37 -0400
Content-Disposition: inline
In-Reply-To: <1436904213-9205-1-git-send-email-f.fainelli@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, gregory.0xf0@gmail.com, tj@kernel.org

On Tue, Jul 14, 2015 at 01:03:33PM -0700, Florian Fainelli wrote:
> When CONFIG_PM_SLEEP is disabled, brcm_ahci_{suspend,resume} are not
> used, which causes such a build warning to occur:
> 
>   CC      drivers/ata/ahci_brcmstb.o
> drivers/ata/ahci_brcmstb.c:212:12: warning: 'brcm_ahci_suspend' defined
> but not used [-Wunused-function]
>  static int brcm_ahci_suspend(struct device *dev)
>             ^
> drivers/ata/ahci_brcmstb.c:224:12: warning: 'brcm_ahci_resume' defined
> but not used [-Wunused-function]
>  static int brcm_ahci_resume(struct device *dev)
>             ^
>   LD      drivers/ata/built-in.o
> 
> Fixes: 766a2d979632 ("ata: add Broadcom AHCI SATA3 driver for STB chips")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> Tejun, this is a new driver that got merged during 4.2, could you queue
> this up for an upcoming 4.2-rcX pull request?

Acked-by: Brian Norris <computersforpeace@gmail.com>

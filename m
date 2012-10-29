From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC v2 3/3] ahci_platform: perform platform exit in host_stop()
 hook
Date: Sun, 28 Oct 2012 18:37:09 -0700
Message-ID: <20121029013709.GB5171@htj.dyndns.org>
References: <1351368576-5264-1-git-send-email-computersforpeace@gmail.com>
 <1351368576-5264-4-git-send-email-computersforpeace@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55373 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837Ab2J2BhP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Oct 2012 21:37:15 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so3898987pbb.19
        for <linux-ide@vger.kernel.org>; Sun, 28 Oct 2012 18:37:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1351368576-5264-4-git-send-email-computersforpeace@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-pm@lists.linux-foundation.org, Kevin Cernekee <cernekee@gmail.com>

On Sat, Oct 27, 2012 at 01:09:36PM -0700, Brian Norris wrote:
> AHCI platform devices may provide an exit() routine, via
> ahci_platform_data, that powers off the SATA core. Such a routine should
> be executed from the ata_port_operations host_stop() hook. That way, the
> ATA subsystem can perform any last-minute hardware cleanup (via devres,
> for example), then trigger the power-off at the appropriate time.
> 
> This patch fixes bus errors triggered during module removal or device
> unbinding, seen on an SoC SATA core.
> 
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>

For all three patches,

  Acked-by: Tejun Heo <tj@kernel.org>

If you have some time, it would be nice to introduce
ata_platform_remove_one().  There's no reason to have that implemented
separately in each driver.  It would also be nice to move
remove_one()'s to some higher level port_ops so that individual
drivers don't have to specify them explicitly.

Thanks.

-- 
tejun

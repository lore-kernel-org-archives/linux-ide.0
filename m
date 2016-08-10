From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/1] Add CPU temperature sensor support for i.MX53
Date: Tue, 9 Aug 2016 23:10:21 -0400
Message-ID: <20160810031021.GZ25053@mtj.duckdns.org>
References: <1470209756-32705-1-git-send-email-fabien.lahoudere@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35471 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932697AbcHJDKY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Aug 2016 23:10:24 -0400
Content-Disposition: inline
In-Reply-To: <1470209756-32705-1-git-send-email-fabien.lahoudere@collabora.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
Cc: Csaba Kertesz <csaba.kertesz@vincit.fi>, "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" <linux-ide@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

Hello, Fabien.

Is $SUBJ right?  CPU temperature?

On Wed, Aug 03, 2016 at 09:35:56AM +0200, Fabien Lahoudere wrote:
> From: Csaba Kertesz <csaba.kertesz@vincit.fi>
> 
> The original patch was made by Richard Zhu for kernel 2.6.x:
> 
> ENGR00134041-MX53-Add-the-SATA-AHCI-temperature-monitor.patch
> 
> The old source code was migrated to the new kernel 3.x. The concept of
> value reading was changed a bit:
> 
> 1. The new 3.x kernel functions (imx_phy_reg_read, imx_phy_reg_write) use
>    16 bit registers while the original implementation used 32 bit integers
>    for this purpose.

The description seems pretty dated.

> 2. The communication is guarded against infinite loop to give up a certain
>    register reading after 100000 attempts. This number comes from the
>    original implementation. A new variable (read_attempt) is introduced to
>    count the trials.

That's a very high number for a retry counter.

> +/* SATA AHCI temperature monitor */
> +static ssize_t sata_ahci_current_tmp(struct device *dev, struct device_attribute

Abbreviating temperature to tmp probably isn't the best idea.

Patch looks good to me except for the above nits; however, I wonder
whether it being a one-off sysfs attribute is the right approach.
Don't we have subsystems and interfaces for things like temperature
readings?

Thanks.

-- 
tejun

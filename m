From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: Add ALPM power state accounting to the AHCI driver
Date: Sun, 15 Nov 2009 17:05:51 +0900
Message-ID: <4AFFB65F.3020201@kernel.org>
References: <20091113192429.4dfc9c39@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37278 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752044AbZKOIF1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Nov 2009 03:05:27 -0500
In-Reply-To: <20091113192429.4dfc9c39@infradead.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, akpm@linux-foundation.org

11/14/2009 12:24 PM, Arjan van de Ven wrote:
> From f62ff8c98080b4a9e66f82f793145b863b4e183a Mon Sep 17 00:00:00 2001
> From: Arjan van de Ven <arjan@linux.intel.com>
> Date: Fri, 13 Nov 2009 16:54:37 -0800
> Subject: [PATCH] libata: Add ALPM power state accounting to the AHCI driver
> 
> PowerTOP wants to show the user how effective the ALPM link
> power management is for the user. ALPM is worth around 0.5W on a quiet
> link; PowerTOP wants to be able to find and expose cases where the "quiet link" 
> isn't actually quiet.
> 
> This patch adds state accounting functionality to the AHCI driver for
> PowerTOP to use.
> The parts of the patch are
> 1) the sysfs logic of exposing the stats for each state in sysfs
> 2) the basic accounting logic that gets update on link change interrupts
>    (or when the user accesses the info from sysfs)
> 3) a "accounting enable" flag; in order to get the accounting to work,
>    the driver needs to get phyrdy interrupts on link status changes.
>    Normally and currently this is disabled by the driver when ALPM is
>    on (to reduce overhead); when PowerTOP is running this will need
>    to be on to get usable statistics... hence the sysfs tunable.
> 
> The PowerTOP output currently looks like this:
> 
> Recent SATA AHCI link activity statistics
> Active	Partial	Slumber	Device name
>   0.5%	 99.5%	  0.0%	host0
> 
> (work to resolve "host0" to a more human readable name is in progress in PowerTOP)

Most of logic seems to belong to libata generic part rather than in
ahci itself.  Wouldn't it be better to implement the thing as generic
libata feature which ahci uses?

Thanks.

-- 
tejun

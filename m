From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH 04/10] phy: phy_brcmstb_sata: make the driver buildable
 on BMIPS_GENERIC
Date: Fri, 23 Oct 2015 14:10:11 -0700
Message-ID: <20151023211011.GR13239@google.com>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com>
 <1445564663-66824-5-git-send-email-jaedon.shin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34807 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765AbbJWVKO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Oct 2015 17:10:14 -0400
Content-Disposition: inline
In-Reply-To: <1445564663-66824-5-git-send-email-jaedon.shin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jaedon Shin <jaedon.shin@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Ralf Baechle <ralf@linux-mips.org>, Florian Fainelli <f.fainelli@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org, linux-mips@linux-mips.org, devicetree@vger.kernel.org

On Fri, Oct 23, 2015 at 10:44:17AM +0900, Jaedon Shin wrote:
> The BCM7xxx ARM and MIPS platforms share a similar hardware block for AHCI
> SATA3 PHY.
> 
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>

Acked-by: Brian Norris <computersforpeace@gmail.com>

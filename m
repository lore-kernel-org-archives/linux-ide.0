From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH 01/10] ata: ahci_brcmstb: make the driver buildable on
 BMIPS_GENERIC
Date: Fri, 23 Oct 2015 14:26:34 -0700
Message-ID: <20151023212634.GT13239@google.com>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com>
 <1445564663-66824-2-git-send-email-jaedon.shin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35256 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752031AbbJWV0g (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Oct 2015 17:26:36 -0400
Content-Disposition: inline
In-Reply-To: <1445564663-66824-2-git-send-email-jaedon.shin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jaedon Shin <jaedon.shin@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Ralf Baechle <ralf@linux-mips.org>, Florian Fainelli <f.fainelli@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org, linux-mips@linux-mips.org, devicetree@vger.kernel.org

On Fri, Oct 23, 2015 at 10:44:14AM +0900, Jaedon Shin wrote:
> The BCM7xxx ARM and MIPS platforms share a similar hardware block for AHCI
> SATA3.
> 
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>

Acked-by: Brian Norris <computersforpeace@gmail.com>

From: Tejun Heo <tj@kernel.org>
Subject: Re: [v6 4/7] ata: ahci_brcmstb: remove unused definitions
Date: Mon, 30 Nov 2015 09:58:14 -0500
Message-ID: <20151130145814.GC3535@mtj.duckdns.org>
References: <1448506595-4981-1-git-send-email-jaedon.shin@gmail.com>
 <1448506595-4981-5-git-send-email-jaedon.shin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f175.google.com ([209.85.160.175]:36709 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754509AbbK3O6R (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Nov 2015 09:58:17 -0500
Received: by ykdr82 with SMTP id r82so185580092ykd.3
        for <linux-ide@vger.kernel.org>; Mon, 30 Nov 2015 06:58:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1448506595-4981-5-git-send-email-jaedon.shin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jaedon Shin <jaedon.shin@gmail.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>, Brian Norris <computersforpeace@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-ide@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Dragan Stancevic <dragan.stancevic@gmail.com>

On Thu, Nov 26, 2015 at 11:56:32AM +0900, Jaedon Shin wrote:
> Remove unused definitions, and this is to avoid confusion with MIPS-based
> platforms.
> 
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
> Tested-by: Florian Fainelli <f.fainelli@gmail.com>
> Acked-by: Brian Norris <computersforpeace@gmail.com>

Applied 2-4 to libata/for-4.5.

Thanks.

-- 
tejun

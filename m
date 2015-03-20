From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 4/5] phy: add Broadcom SATA3 PHY driver for Broadcom STB
 SoCs
Date: Fri, 20 Mar 2015 16:02:16 -0700
Message-ID: <550CA6F8.7080504@gmail.com>
References: <1426728222-8197-1-git-send-email-computersforpeace@gmail.com> <1426728222-8197-4-git-send-email-computersforpeace@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36354 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198AbbCTXC6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Mar 2015 19:02:58 -0400
In-Reply-To: <1426728222-8197-4-git-send-email-computersforpeace@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>, Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Gregory Fong <gregory.0xf0@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On 18/03/15 18:23, Brian Norris wrote:
> Supports up to two ports which can each be powered on/off and configured
> independently.
> 
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>
> ---

[snip]

> +
> +static const struct of_device_id brcmstb_sata_phy_of_match[] = {
> +	{ .compatible	= "brcm,bcm7445-sata-phy" },

The binding document specifies "brcm,phy-sata3" as a fallback compatible
string, so we want to match it here.

[snip]

> +
> +	dev_info(dev, "registered %d ports\n", count);

"registered %d port(s)" ;)
-- 
Florian

From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v4 3/4] SATA: MV: Add support for the optional PHYs
Date: Mon, 20 Jan 2014 07:47:24 -0500
Message-ID: <20140120124724.GD17155@htj.dyndns.org>
References: <20131219194237.GC22725@htj.dyndns.org>
 <1388078742-6726-1-git-send-email-andrew@lunn.ch>
 <1388078742-6726-4-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qe0-f41.google.com ([209.85.128.41]:60447 "EHLO
	mail-qe0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753303AbaATMr2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Jan 2014 07:47:28 -0500
Content-Disposition: inline
In-Reply-To: <1388078742-6726-4-git-send-email-andrew@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jason Cooper <jason@lakedaemon.net>, kishon@ti.com, devicetree@vger.kernel.org, linux-ide@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>

On Thu, Dec 26, 2013 at 06:25:41PM +0100, Andrew Lunn wrote:
> Some Marvell SoCs have a SATA PHY which can be powered off, in order
> to save power. Make use of the generic phy framework to control these
> phys.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Applied to libata/for-3.14.  It's late but not applying this patch
would reportedly lead to boot failures in certain configurations.

Thanks.

-- 
tejun

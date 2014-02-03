From: Tejun Heo <tj@kernel.org>
Subject: Re: [patch v2 3/3] ata: sata_mv: Fix probe failures with optional
 phys
Date: Mon, 3 Feb 2014 13:02:46 -0500
Message-ID: <20140203180246.GG30250@htj.dyndns.org>
References: <52EF6D38.4060200@ti.com>
 <1391450446-15580-1-git-send-email-andrew@lunn.ch>
 <1391450446-15580-3-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:43359 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752160AbaBCSCu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Feb 2014 13:02:50 -0500
Received: by mail-qc0-f175.google.com with SMTP id x13so11828343qcv.34
        for <linux-ide@vger.kernel.org>; Mon, 03 Feb 2014 10:02:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1391450446-15580-3-git-send-email-andrew@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: kishon@ti.com, Jason Cooper <jason@lakedaemon.net>, Gregory Clement <gregory.clement@free-electrons.com>, linux-ide@vger.kernel.org

On Mon, Feb 03, 2014 at 07:00:46PM +0100, Andrew Lunn wrote:
> Make use of devm_phy_optional() in order to fix probe failures on
> Armada 370, XP and others, when there is no phy driver available.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

 Acked-by: Tejun Heo <tj@kernel.org>

Please feel free to route any way you see fit.

Thanks!

-- 
tejun

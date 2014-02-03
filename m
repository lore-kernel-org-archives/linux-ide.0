From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 3/3] ata: sata_mv: Fix probe failures with optional phys
Date: Mon, 3 Feb 2014 11:03:15 -0500
Message-ID: <20140203160315.GB30250@htj.dyndns.org>
References: <0140131114857.GC26148@htj.dyndns.org>
 <1391264157-2112-1-git-send-email-andrew@lunn.ch>
 <1391264157-2112-3-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:33486 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134AbaBCQDT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Feb 2014 11:03:19 -0500
Received: by mail-qc0-f171.google.com with SMTP id n7so11397111qcx.16
        for <linux-ide@vger.kernel.org>; Mon, 03 Feb 2014 08:03:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1391264157-2112-3-git-send-email-andrew@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: kishon@ti.com, linux-ide@vger.kernel.org

On Sat, Feb 01, 2014 at 03:15:57PM +0100, Andrew Lunn wrote:
> Make use of devm_phy_optional() in order to fix probe failures on
> Armada 370, XP and others, when there is no phy driver available.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Looks good to me from the ata side.  How should these be routed?  I
can take them through libata/for-3.14-fixes once phy people ack the
changes or the other way around is fine too.

Thanks.

-- 
tejun

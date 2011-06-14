From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ahci: enable pmp but connected to HDD issue fixed
Date: Tue, 14 Jun 2011 08:52:13 +0200
Message-ID: <20110614065213.GD8141@htj.dyndns.org>
References: <1308030504-3026-1-git-send-email-yuanlmm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53609 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234Ab1FNGwS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Jun 2011 02:52:18 -0400
Content-Disposition: inline
In-Reply-To: <1308030504-3026-1-git-send-email-yuanlmm@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yuan-Hsin Chen <yuanlmm@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Yuan-Hsin Chen <yhchen@faraday-tech.com>

On Tue, Jun 14, 2011 at 01:48:24PM +0800, Yuan-Hsin Chen wrote:
> From: Yuan-Hsin Chen <yhchen@faraday-tech.com>
> 
> When enabling both port multiplier and platform ahci sata, ahci
> times out while connecting to HDD directly. This is because soft
> reset fails with IPMS set. Do soft reset again to port 0.
> 
> The soft reset sequence is copied from ahci.c.

This is the same one as ahci_sb600_softreset(), right?  Please don't
copy & paste like that.  Rename and ahci_sb600_softreset() to
libahci.c, create a separate ata_port_operations for it and use the
ops for the affected controllers.

Thanks.

-- 
tejun

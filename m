From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] ide_tape: kill off use of the ->ioctl operation
Date: Tue, 12 Jan 2010 01:57:06 -0800 (PST)
Message-ID: <20100112.015706.201552401.davem@davemloft.net>
References: <20100104162354.17012.20586.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:51652
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753963Ab0ALJ45 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Jan 2010 04:56:57 -0500
In-Reply-To: <20100104162354.17012.20586.stgit@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: alan@linux.intel.com
Cc: linux-ide@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>
Date: Mon, 04 Jan 2010 16:24:00 +0000

> Ready to get everything using unlocked_ioctl()
> 
> For ide_tape we just push down as this is legacy code anyway
> 
> Signed-off-by: Alan Cox <alan@linux.intel.com>

Applied to ide-next-2.6, thanks Alan.

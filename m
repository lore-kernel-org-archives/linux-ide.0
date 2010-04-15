From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] <linux/ide.h>: fix comment typo
Date: Thu, 15 Apr 2010 02:17:33 -0700 (PDT)
Message-ID: <20100415.021733.52785840.davem@davemloft.net>
References: <201004121943.19556.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:36743
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756817Ab0DOJR3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Apr 2010 05:17:29 -0400
In-Reply-To: <201004121943.19556.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sshtylyov@ru.mvista.com
Cc: linux-ide@vger.kernel.org

From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Date: Mon, 12 Apr 2010 19:43:19 +0400

> Fix typo in the comment to the 'dma_mode' field of the 'struct ide_drive_s'
> introduced by the commit 3fccaa192b9501e79a57e02e62b6bf420d2b461e (ide: add
> drive->dma_mode field).
> 
> Whilt at it, convert spaces to a tab in the declaration of the neighbouring
> 'dn' field...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Applied, thanks.

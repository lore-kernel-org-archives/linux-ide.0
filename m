From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] IDE: pass IRQ flags to the IDE core
Date: Thu, 15 Apr 2010 02:16:12 -0700 (PDT)
Message-ID: <20100415.021612.213438899.davem@davemloft.net>
References: <q2rf69abfc31004080726scbf96429ub4d84a318835d53d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:36739
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756817Ab0DOJQI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Apr 2010 05:16:08 -0400
In-Reply-To: <q2rf69abfc31004080726scbf96429ub4d84a318835d53d@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: yegorslists@googlemail.com
Cc: linux-ide@vger.kernel.org

From: Yegor Yefremov <yegorslists@googlemail.com>
Date: Thu, 8 Apr 2010 16:26:29 +0200

> IDE: pass IRQ flags to the IDE core
> 
> This enables shared IRQs and other features to be used with platform devices
> 
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

If you need this for a new device, please use the ATA layer
instead of adding support for new features in IDE which is
in deep maintainence mode only.

Thanks.

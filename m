From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 1/2] pdc202xx_old: wire test_irq() method for PDC2026x
Date: Thu, 22 Apr 2010 19:12:09 -0700 (PDT)
Message-ID: <20100422.191209.112611436.davem@davemloft.net>
References: <201004141950.27083.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:40556
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755164Ab0DWCME (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Apr 2010 22:12:04 -0400
In-Reply-To: <201004141950.27083.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sshtylyov@ru.mvista.com
Cc: linux-ide@vger.kernel.org, rmk@arm.linux.org.uk

From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Date: Wed, 14 Apr 2010 19:50:26 +0400

> In the commit e0321fbe6d34b4bb514fb6daff9e0859e5d76001 (pdc202xx_old: implement
> test_irq() method (take 2)) I forgot to modify 'pdc2026x_port_ops'... :-/
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Applied.

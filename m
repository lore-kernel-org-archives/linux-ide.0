From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] cmd640: fix kernel oops in test_irq() method
Date: Tue, 11 May 2010 00:09:52 -0700 (PDT)
Message-ID: <20100511.000952.266105151.davem@davemloft.net>
References: <201005082207.14690.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:39036
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757015Ab0EKHJo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 May 2010 03:09:44 -0400
In-Reply-To: <201005082207.14690.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sshtylyov@ru.mvista.com
Cc: linux-ide@vger.kernel.org

From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Date: Sat, 8 May 2010 22:07:14 +0400

> When implementing the test_iqr() method, I forgot that this driver is not an
> ordinary PCI driver and also needs to support VLB variant of the chip. Moreover,
> 'hwif->dev' should be NULL, potentially causing oops in pci_read_config_byte().
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Applied, thanks a lot Sergei.

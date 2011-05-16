From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] ide/ide-scan-pci.c: Use for_each_pci_dev().
Date: Mon, 16 May 2011 14:25:04 -0700 (PDT)
Message-ID: <20110516.142504.115922083.davem@davemloft.net>
References: <1304287825-8023-1-git-send-email-tfransosi@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:38448
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754863Ab1EPVZg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 May 2011 17:25:36 -0400
In-Reply-To: <1304287825-8023-1-git-send-email-tfransosi@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tfransosi@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

From: Thiago Farina <tfransosi@gmail.com>
Date: Sun,  1 May 2011 19:10:25 -0300

> Use for_each_pci_dev() to simplify the code.
> 
> Signed-off-by: Thiago Farina <tfransosi@gmail.com>

Applied.

From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] ide: Use linux/mutex.h
Date: Sun, 08 May 2011 16:42:14 -0700 (PDT)
Message-ID: <20110508.164214.02290976.davem@davemloft.net>
References: <20110509093017.20f00c35@kryten>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:35939
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754391Ab1EHXmq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 8 May 2011 19:42:46 -0400
In-Reply-To: <20110509093017.20f00c35@kryten>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: anton@samba.org
Cc: linux-ide@vger.kernel.org

From: Anton Blanchard <anton@samba.org>
Date: Mon, 9 May 2011 09:30:17 +1000

> 
> The IDE code is still including asm/mutex.h instead of linux/mutex.h
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Applied, thanks Anton.

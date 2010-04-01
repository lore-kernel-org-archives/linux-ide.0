From: David Miller <davem@davemloft.net>
Subject: Re: ide: Requeue request after DMA timeout
Date: Thu, 01 Apr 2010 01:27:53 -0700 (PDT)
Message-ID: <20100401.012753.10921492.davem@davemloft.net>
References: <4BB43F3B.6000801@kernel.org>
	<20100401075454.GA22417@gondor.apana.org.au>
	<4BB458BD.20700@kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:44066
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754242Ab0DAI1w (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Apr 2010 04:27:52 -0400
In-Reply-To: <4BB458BD.20700@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: herbert@gondor.apana.org.au, linux-ide@vger.kernel.org

From: Tejun Heo <tj@kernel.org>
Date: Thu, 01 Apr 2010 17:26:37 +0900

> David, in the meantime, although I'm not quite sure the fix is
> comprehensive yet, the patches definitely fix some of the issues.  So,
> I have no objection to applying them.

Ok, thanks for reviewing.

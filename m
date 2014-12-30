From: David Miller <davem@davemloft.net>
Subject: Re: Question about FIXME in au1xxx-ide.c
Date: Tue, 30 Dec 2014 16:14:17 -0500 (EST)
Message-ID: <20141230.161417.1724826704176493969.davem@davemloft.net>
References: <54A2E158.9020407@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:35551 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321AbaL3VOX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Dec 2014 16:14:23 -0500
In-Reply-To: <54A2E158.9020407@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: xerofoify@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: nick <xerofoify@gmail.com>
Date: Tue, 30 Dec 2014 12:31:04 -0500

> Greetings David,
> I am wondering about the fix me in the file,au1xxx-ide.c for
> the function,auide_ddma_init. While it's obvious to check the
> return code of the function called below the FIXME comment,it
> seems to be that there is more to this issue and therefore I 
> have a few questions. The first being can this device fail and
> the system will function properly? The second question being don't
> we need to remove the device if the allocation fails in the creation
> of the data structures for it's use by the kernel as otherwise aren't
> we leaking memory?

I have no idea why the FIXME comment is there, I didn't write this
driver nor have I ever made any changes to it.

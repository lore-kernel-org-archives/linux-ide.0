From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Scary Intel SATA problem: "frozen"
Date: Tue, 28 Nov 2006 19:38:20 -0500
Message-ID: <456CD67C.8050909@garzik.org>
References: <456CB72A.3010004@local.se> <Pine.LNX.4.64.0611281444330.4244@woody.osdl.org> <456CC4C5.6090003@garzik.org> <Pine.LNX.4.64.0611281531550.4244@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:64926 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1757618AbWK2Ai0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Nov 2006 19:38:26 -0500
In-Reply-To: <Pine.LNX.4.64.0611281531550.4244@woody.osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jonas Lundgren <jonas@local.se>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Linus Torvalds wrote:
> How hard would it be to just force a shared spinlock between two sata 
> channels on the same "controller"? It sounds like Jonas has a very 
> repeatable setup, so even if I can't repeat my problem, if the performance 
> degradation on writes is related, he can check his thing..


ap->host (struct ata_host) already has a spinlock for precisely just 
that...  :)

	Jeff



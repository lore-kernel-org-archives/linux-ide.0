From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Scary Intel SATA problem: "frozen"
Date: Tue, 28 Nov 2006 17:18:08 -0500
Message-ID: <456CB5A0.9090802@garzik.org>
References: <20061114150454.GA11900@havoc.gtf.org> <Pine.LNX.4.64.0611280908320.4244@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:58522 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1755714AbWK1WSK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Nov 2006 17:18:10 -0500
In-Reply-To: <Pine.LNX.4.64.0611280908320.4244@woody.osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org

And FWIW, "frozen" in this context means that Tejun's libata error 
handling code has take ownership of the ATA port, after stopping all 
outstanding I/O transactions.

So when you see that, that's libata EH kicking in.

	Jeff




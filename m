From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH -mm] sata_nv: fix kfree ordering in remove
Date: Tue, 12 Dec 2006 06:35:23 -0500
Message-ID: <457E93FB.20204@garzik.org>
References: <456E3ED5.3090201@shaw.ca> <457D86F0.4020408@garzik.org> <457E3F6A.809@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54786 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751235AbWLLLf1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 12 Dec 2006 06:35:27 -0500
In-Reply-To: <457E3F6A.809@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Andrew Morton <akpm@osdl.org>

Robert Hancock wrote:
> Jeff Garzik wrote:
>> It is unwise to free the struct before the ports are even detached.
> 
> Right, theoretically something bad could happen here (though not 
> likely). Here's a fix. Sorry for attaching with something so trivial, 
> but Thunderbird isn't very cooperative..

You'll need to resend the entire patch, I dropped it due to that 
comment.  In general, before a patch is applied, the patch will go 
through several revisions.  I don't apply things piecemeal, only the 
last (hopefully perfect:)) revision.

Also, as your email already guessed, attachments are to be avoided :/

	Jeff




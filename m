From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2/4] libata: update ATAPI overflow draining
Date: Fri, 01 Feb 2008 15:34:09 -0500
Message-ID: <47A38241.9070602@garzik.org>
References: <11992723701811-git-send-email-htejun@gmail.com> <11992723711166-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46405 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753359AbYBAUeM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Feb 2008 15:34:12 -0500
In-Reply-To: <11992723711166-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, James Bottomley <James.Bottomley@HansenPartnership.com>

Tejun,

If you could explain your objection to James's patches in this area, I 
would really appreciate it.

We have several conflicting patches in this area, and we need to get the 
details sorted.

I think you mentioned a key objection that was we actually need to know 
/two/ sizes at the block layer:  (1) the size including all padding and 
drain buffers, and (2) the raw or "true" size.

	Jeff




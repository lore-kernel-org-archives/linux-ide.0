From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: Fix (hopefully) all the remaining problems with
 devices failing setup/identify
Date: Fri, 02 Feb 2007 11:54:44 -0500
Message-ID: <45C36CD4.1010809@garzik.org>
References: <20070131172605.2c5dfc78@localhost.localdomain>	<45C0D050.4030302@garzik.org> <20070131174724.7b17153a@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:49915 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945982AbXBBQyq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Feb 2007 11:54:46 -0500
In-Reply-To: <20070131174724.7b17153a@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Alan wrote:
>> Looks like you should use ata_busy_wait() here, rather than reproducing 
>> the same code again.
> 
> It waits in 10uS chunks while 1uS chunks were used in the workaround.
> Could indeed do that once I know the fix is right. While I'm at it the
> ata_busy_wait kerneldoc is borked so here's a fix
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied


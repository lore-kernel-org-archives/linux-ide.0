From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch] Add more device IDs for supporting ATI SB800 SATA controller
Date: Tue, 02 Oct 2007 10:44:28 -0400
Message-ID: <4702594C.3020003@garzik.org>
References: <c660f0910709302118q7e0e5f65k5d833781cc7e4d26@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44501 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752478AbXJBOob (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Oct 2007 10:44:31 -0400
In-Reply-To: <c660f0910709302118q7e0e5f65k5d833781cc7e4d26@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: su henry <henry.su.ati@gmail.com>
Cc: gregkh <gregkh@suse.de>, linux-ide <linux-ide@vger.kernel.org>, htejun <htejun@gmail.com>

su henry wrote:
> From: henry su<henry.su.ati@gmail.com>
> 
> ATI/AMD SB800 shares some device IDs with SB700,
> and SB800 adds two more device IDs:0x4394,0x4395.
> 
> Signed-off-by:  henry su<henry.su.ati@gmail.com>

This patch was already applied, on September 20th.

It's already "upstream" in the official Linux kernel, too:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

Regards,

	Jeff




From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] blacklist NCQ on Seagate Barracuda ST380817AS
Date: Tue, 02 Oct 2007 18:19:14 +0900
Message-ID: <47020D12.5090402@gmail.com>
References: <20070930160548.235be972@localhost>	<20070930152908.1f58d39d@the-village.bc.nu> <20070930164610.20818867@localhost> <46FFBB2D.6060004@garzik.org> <46FFDC5A.7070509@rtr.ca> <46FFDCE5.4060900@gmail.com> <46FFE047.7030102@rtr.ca> <46FFE218.5000607@gmail.com> <46FFF0F4.7040809@rtr.ca> <46FFF290.2090005@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.246]:61259 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149AbXJBJUu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Oct 2007 05:20:50 -0400
Received: by an-out-0708.google.com with SMTP id d31so596555and
        for <linux-ide@vger.kernel.org>; Tue, 02 Oct 2007 02:20:49 -0700 (PDT)
In-Reply-To: <46FFF290.2090005@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Mark Lord <lkml@rtr.ca>, Jeff Garzik <jeff@garzik.org>, Paolo Ornati <ornati@fastwebnet.it>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Hello,

Mark Lord wrote:
> Mmm.. $66 for "open box".  But the drive itself has been discontinued by
> Seagate,

Couldn't find any in SUSE and I don't think I can't find any vendor who
still carries the drive here.

> and once claimed to be "World's first SATA desktop drive with NCQ.".
> 
> Probably buggy firmware after all.

Yeah, "World's first" is a pretty good clue indicating "broken".
Blacklisting it seems like a good idea after all.

Thanks.

-- 
tejun

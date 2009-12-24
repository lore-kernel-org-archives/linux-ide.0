From: Tejun Heo <tj@kernel.org>
Subject: Re: 2.6.32.2 SATA link detect failed, 2.6.32.1 works fine
Date: Thu, 24 Dec 2009 16:51:47 +0900
Message-ID: <4B331D93.2010000@kernel.org>
References: <alpine.LNX.2.00.0912211855460.1689@darkstar.example.net> <4B30134C.1050609@gmail.com> <alpine.LNX.2.00.0912220859060.1686@darkstar.example.net> <51f3faa70912211708j200ab584wa835ffe50981415e@mail.gmail.com> <alpine.LNX.2.00.0912220955341.1696@darkstar.example.net> <4B31DB17.4050509@kernel.org> <alpine.LNX.2.00.0912231719440.1694@darkstar.example.net> <4B331957.7030906@kernel.org> <alpine.LNX.2.00.0912241535340.1682@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39589 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754803AbZLXHsR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 Dec 2009 02:48:17 -0500
In-Reply-To: <alpine.LNX.2.00.0912241535340.1682@darkstar.example.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: fengxiangjun <fengxiangjun@neusoft.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello,

On 12/24/2009 04:45 PM, fengxiangjun wrote:
> Hi, I can not capture the full failing boot log.
> The kernel panic, and shift + pageup does not work. 
> 
> With output to serial console, the problem goes away.

Ah... right, I forgot about this.

> I think with an initrd, I can reproduce the problem and capture the
> full failing boot log.  But with an initrd, there's no
> problem. Every thing works fine.

Hmmm.... can you please try netconsole?  Netconsole usually doesn't
introduce much delay and should be able to extract the log without
affecting timings.

Thanks.

-- 
tejun

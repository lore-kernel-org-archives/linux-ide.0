From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/3] libata: add missing PM callbacks
Date: Tue, 06 Mar 2007 17:13:31 +0900
Message-ID: <45ED22AB.4090901@gmail.com>
References: <20070302083001.GK20322@htj.dyndns.org> <45E8B3C8.2090009@garzik.org> <45E8E749.4030406@gmail.com> <20070306080509.GA2040@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.230]:10274 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752312AbXCFINc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Mar 2007 03:13:32 -0500
Received: by wr-out-0506.google.com with SMTP id 37so1794679wra
        for <linux-ide@vger.kernel.org>; Tue, 06 Mar 2007 00:13:32 -0800 (PST)
In-Reply-To: <20070306080509.GA2040@elf.ucw.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Alan <alan@lxorguk.ukuu.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Pavel Machek wrote:
> Much complexity for little gain. Who is running _without_ CONFIG_PM
> these days?

Embedded people, I guess.  The problem here is that if we are gonna
support !CONFIG_PM configuration and try to reduce the kernel/module
images size for such case, we end up sprinkling #ifdef's all over huge
number of device drivers.

If we determine to drop !CONFIG_PM configuration, I'm happy with that
too but we need to determine something here.  Alternatives...

1. drop !CONFIG_PM configuration
2. continue to sprinkle #ifdef's over device drivers
3. find out prettier way to mark PM functions

-- 
tejun

From: Tejun Heo <htejun@gmail.com>
Subject: Re: Flexible SFF interrupt handling
Date: Fri, 30 Nov 2007 10:11:12 +0900
Message-ID: <474F6330.8040400@gmail.com>
References: <474D70E0.4060709@garzik.org> <474D7C21.9000303@rtr.ca> <474D900B.8030408@garzik.org> <474F6280.8090403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.185]:7019 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752965AbXK3BLW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Nov 2007 20:11:22 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1756648rvb
        for <linux-ide@vger.kernel.org>; Thu, 29 Nov 2007 17:11:18 -0800 (PST)
In-Reply-To: <474F6280.8090403@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mark Lord <liml@rtr.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> And when reading off Status when idle, we'll need to return 0 from
> irq_handler.  That will prevent IRQ screaming IRQ lock and nobody cared

That sentence was "That will prevent IRQ screaming from causing IRQ live
lock..." in my mind.  Some packets were lost while transmitting it via
my neck, arms and finally through my fingertips and my fingers foolishly
didn't ask for retransmission.  :-P

-- 
tejun

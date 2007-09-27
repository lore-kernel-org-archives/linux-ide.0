From: Tejun Heo <htejun@gmail.com>
Subject: Re: Improper disk shutdown with 2.6.22.6?
Date: Thu, 27 Sep 2007 09:39:54 +0900
Message-ID: <46FAFBDA.4080509@gmail.com>
References: <20070919093306.GA2359@robos.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:19520 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322AbXI0EYA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Sep 2007 00:24:00 -0400
Received: by rv-out-0910.google.com with SMTP id k20so2202895rvb
        for <linux-ide@vger.kernel.org>; Wed, 26 Sep 2007 21:23:58 -0700 (PDT)
In-Reply-To: <20070919093306.GA2359@robos.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert <robert@robos.org>
Cc: linux-ide@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Jeff Garzik <jeff@garzik.org>

[cc'ing Henrique and Jeff]

Robert wrote:
> Hello,
> 
> When shutting down this system running Linux 2.6.22.6, I get a warning about
> the possibility that the disks are not properly shut down. When the power is
> turned off, it sounds like the disks aren't spun down (but I may be mistaken
> on that point).
> 
> http://linux-ata.org/shutdown.html claims that kernels newer than 2.6.21 will
> always spin down the disks, but is this really the case?
> The manage_start_stop files exist.
> 
> Tell me if you'd like more detailed information about configuration and
> hardware.

You're on debian, right?  You need to update your shutdown utilities.

Henrique, what information should we put into the faq page to properly
direct debian users to needed updates?

Thanks.

-- 
tejun


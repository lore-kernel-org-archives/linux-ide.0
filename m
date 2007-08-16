From: Bob Ham <rah@bash.sh>
Subject: Re: [PATCH] hpt366: fix PCI clock detection for HPT374 (take 4)
Date: Thu, 16 Aug 2007 08:40:40 +0100
Message-ID: <1187250040.6071.1.camel@localhost>
References: <200708112349.50483.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from waffl.ing.me.uk ([217.147.94.6]:37665 "EHLO waffl.ing.me.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752015AbXHPHle (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Aug 2007 03:41:34 -0400
In-Reply-To: <200708112349.50483.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org

On Sat, 2007-08-11 at 23:49 +0400, Sergei Shtylyov wrote:
> HPT374 BIOS seems to only save f_CNT register value for the function #0 before
> re-tuning DPLL (that causes the driver to report obviously distorted f_CNT for
> the function #1) -- fix this by always reading the saved f_CNT register value
> from the function #0 in the driver's init_chipset() method.

I'm assuming you don't need me to test these latest patches, and that
you'll explicitly ask if you do?

Bob



From: Phil Sutter <n0-1@freewrt.org>
Subject: Re: [patch 1/1] pata-rb532-cf: platform_get_irq() failure ignored
Date: Tue, 12 May 2009 23:17:44 +0200
Message-ID: <20090512211808.46AB74CE9E@orbit.nwl.cc>
References: <200905122104.n4CL4DDB008142@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from orbit.nwl.cc ([91.121.169.95]:56890 "EHLO orbit.nwl.cc"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750974AbZELV2o (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 12 May 2009 17:28:44 -0400
Content-Disposition: inline
In-Reply-To: <200905122104.n4CL4DDB008142@imap1.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, roel.kluin@gmail.com, alan@lxorguk.ukuu.org.uk, florian@openwrt.org

Hi!

On Tue, May 12, 2009 at 01:44:58PM -0700, akpm@linux-foundation.org wrote:
> From: Roel Kluin <roel.kluin@gmail.com>
> 
> platform_get_irq() can return -ENXIO, but since 'irq' is an unsigned int,
> it does not show when the IRQ resource wasn't found.

This no longer applies, as 'irq' is signed now. See Jeff's email to this
list (Message-ID: 49C9940B.5050704@garzik.org), in which he accepts an
appropriate patch by Florian Fainelli.

Greetings, Phil

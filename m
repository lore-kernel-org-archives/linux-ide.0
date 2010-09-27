From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 1/2] hpt366: add debounce delay to cable_detect() method
Date: Mon, 27 Sep 2010 11:00:50 -0700 (PDT)
Message-ID: <20100927.110050.232902423.davem@davemloft.net>
References: <201009271808.15710.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:53798
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759579Ab0I0SAa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Sep 2010 14:00:30 -0400
In-Reply-To: <201009271808.15710.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sshtylyov@ru.mvista.com
Cc: linux-ide@vger.kernel.org, stable@kernel.org, bzolnier@gmail.com, alan@lxorguk.ukuu.org.uk

From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Date: Mon, 27 Sep 2010 18:08:15 +0400

> Alan Cox reported that cable detection sometimes works unreliably
> for HPT3xxN and that the issue is fixed by adding debounce delay
> as used by the vendor drivers.
> 
> While at it, get rid of unneeded parens/space in the vicinity...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Applied.

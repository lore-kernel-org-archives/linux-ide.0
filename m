From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2/2] hpt366: fix clock turnaround
Date: Mon, 27 Sep 2010 11:01:42 -0700 (PDT)
Message-ID: <20100927.110142.71582292.davem@davemloft.net>
References: <201009271809.44135.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:33863
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752203Ab0I0SBX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Sep 2010 14:01:23 -0400
In-Reply-To: <201009271809.44135.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sshtylyov@ru.mvista.com
Cc: linux-ide@vger.kernel.org, stable@kernel.org, alan@lxorguk.ukuu.org.uk

From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Date: Mon, 27 Sep 2010 18:09:43 +0400

> DPLL clock (0x21) should be used for writes and PCI clock (0x23) for reads,
> not vice versa.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Also applied, thanks.

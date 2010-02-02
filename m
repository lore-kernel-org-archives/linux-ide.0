From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 00/68] ide2libata
Date: Tue, 2 Feb 2010 23:27:48 +0000
Message-ID: <20100202232748.61e29030@lxorguk.ukuu.org.uk>
References: <20100201125845.3f468363@lxorguk.ukuu.org.uk>
	<20100201.051432.226757615.davem@davemloft.net>
	<4B68B0CF.1040907@garzik.org>
	<20100202.151900.211475917.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:50411 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754373Ab0BBX1M (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Feb 2010 18:27:12 -0500
In-Reply-To: <20100202.151900.211475917.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: jeff@garzik.org, bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> If the drivers get truly shared between IDE and ATA, that
> presumption is entirely removed, the ATA testers will
> be hitting the same driver code that whatever remaining
> IDE users will be.

Assuming the data structures matching does that is a bit like assuming
you can test one TCP stack using another one because they use the same
packet format.


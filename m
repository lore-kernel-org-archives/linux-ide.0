From: Mark Lord <lkml@rtr.ca>
Subject: Re: SATA speed. Should be 150 or 133?
Date: Thu, 23 Jun 2005 23:08:59 -0400
Message-ID: <42BB794B.6080109@rtr.ca>
References: <Pine.LNX.4.62.0506240135340.29382@bizon.gios.gov.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:61712 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S263017AbVFXDJE
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Jun 2005 23:09:04 -0400
In-Reply-To: <Pine.LNX.4.62.0506240135340.29382@bizon.gios.gov.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Krzysztof Oledzki <olel@ans.pl>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

True SATA drives ignore the "transfer speed",
as it really is meaningless and does not apply.

But most (all?) first-gen SATA drives are really
PATA drives with a SATA bridge built-in.
Some of those drives require that Linux set the
DMA transfer speed for them to work reliably.

Last I looked, the highest valid PATA transfer
speed was still "UDMA/133".  150 just plain
doesn't exist for PATA (and the whole concept
doesn't exist for SATA, so ..)

Cheers

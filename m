From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] Re: 2.6.11-rc4 libata-core (irq 30: nobody cared!)
Date: Mon, 28 Feb 2005 11:10:33 -0500
Message-ID: <42234279.6030004@rtr.ca>
References: <20050224015859.55191.qmail@web40910.mail.yahoo.com> <421D3D33.9060707@pobox.com> <20050226193255.GA6256@ime.usp.br> <4220D9DE.10904@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:52371 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S261668AbVB1QLx
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Feb 2005 11:11:53 -0500
In-Reply-To: <4220D9DE.10904@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

 >"irq XX: nobody cared" is a screaming interrupt situation, which could have 1001 causes.

Speaking of which.  The 3ware drivers appear to have a bug
in their handling of this.  They *always* report "handled=1"
from their interrupt routines, regardless of whether it was
their hardware or not that was signalling for attention.

Cheers

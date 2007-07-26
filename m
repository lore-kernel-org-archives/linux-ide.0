From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_cmd64x: Correct the speed ranges
Date: Thu, 26 Jul 2007 18:06:16 -0400
Message-ID: <46A91AD8.40908@garzik.org>
References: <200707262101.l6QL1Iqk029149@harpo.it.uu.se> <46A90F23.8010907@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52451 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765977AbXGZWGY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 26 Jul 2007 18:06:24 -0400
In-Reply-To: <46A90F23.8010907@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Sergei Shtylyov wrote:
>    Note that the olde driver has MWDMA fixed, and the new one has it 
> still borken, yet MWDMA2 is the mode you're using.


What about MWDMA is broken?

	Jeff



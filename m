From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_hpt3xx: Updates to match work done by Sergei to
 old IDE
Date: Tue, 17 Apr 2007 10:47:09 -0400
Message-ID: <4624DDED.9080200@garzik.org>
References: <20070411001649.1abecf4b@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:39735 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030419AbXDQOrL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Apr 2007 10:47:11 -0400
In-Reply-To: <20070411001649.1abecf4b@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Alan Cox wrote:
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> Correct timing lists
> Use DPLL when appropriate
> Fix HPT372 UDMA 100 limit
> Add HPT371N support
> Reset the correct channel only not both when doing the pre_reset
> processing
> Pull DPLL clock from I/O not PCI space
> Correct DPLL failure error handling

Looks OK to me, but...  should I still apply this, given the recent 
regression reports that hit LKML less than 48 hours ago?



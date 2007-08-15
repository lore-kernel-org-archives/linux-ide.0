From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: Correct IORDY handling
Date: Wed, 15 Aug 2007 03:09:19 -0400
Message-ID: <46C2A69F.6020004@garzik.org>
References: <20070731140148.4cb780de@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:43365 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752595AbXHOHJX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Aug 2007 03:09:23 -0400
In-Reply-To: <20070731140148.4cb780de@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Alan Cox wrote:
> Debugging a report of a problem with an ancient solid state disk showed
> up some problems in the IORDY handling
> 
> 1.	We check the wrong bit to see if the device has IORDY
> 2.	Even then some ancient creaking piles of crap don't support
> 	SETXFER at all.
> 
> I think this should go via -mm for a bit. The cases it fixes are obscure
> and the risk of side effects is slight but possible. This also moves us
> slightly closer to supporting original MFM/RLL disks with libata but
> before Jeff panics I have no plans to do that....
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied



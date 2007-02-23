From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: IORDY handling, quiet handling
Date: Fri, 23 Feb 2007 05:27:56 -0500
Message-ID: <45DEC1AC.7020700@garzik.org>
References: <20070205162544.5e55cff0@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44851 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932142AbXBWK17 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Feb 2007 05:27:59 -0500
In-Reply-To: <20070205162544.5e55cff0@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Alan wrote:
> For further review
> 
> Turn on the IORDY handling logic.
> 
> If a controller doesnt support IORDY don't try and use it
> If a device doesn't support IORDY don't try and use it
> Otherwise use it whenever possible.
> Always use IORDY for PIO3 and higher (it's mandatory)
> 
> Send the correct set_features command if operating without IORDY
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

modulo TFLAG_QUIET mentioned in previous email, this seems OK to me.



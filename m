From: Jeff Garzik <jeff@garzik.org>
Subject: Re: sata_mv driver
Date: Tue, 22 May 2007 22:21:01 -0400
Message-ID: <4653A50D.1000902@garzik.org>
References: <20070523012124.GA17463@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:57858 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756530AbXEWCVE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 22 May 2007 22:21:04 -0400
In-Reply-To: <20070523012124.GA17463@animx.eu.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Wakko Warner <wakko@animx.eu.org>
Cc: linux-ide@vger.kernel.org

Wakko Warner wrote:
> In kernel 2.6.20, this driver is marked as experimental.  How well does this
> driver work?  I was concidering a supermicro 8 port sata controller and it
> appears to use this driver.  I really do not wish to use anything that is
> experimental.

It's still beta.  It needs error handling improvements.

	Jeff




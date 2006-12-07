From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] pata_it8213: Add new driver for the IT8213 card.
Date: Thu, 07 Dec 2006 07:19:08 -0500
Message-ID: <457806BC.5070109@pobox.com>
References: <20061204164931.7d36d744@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37286 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032099AbWLGMTM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 7 Dec 2006 07:19:12 -0500
In-Reply-To: <20061204164931.7d36d744@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Alan wrote:
> Add a driver for the IT8213 which is a single channel ICH-ish PATA
> controller. As it is very different to the IT8211/2 it gets its own
> driver. There is a legacy drivers/ide driver also available and I'll post
> that once I get time to test it all out (probably early January). If
> anyone else needs the drivers/ide driver and wants to do the merge for
> drivers/ide (Bart ??) then I'll forward it.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

ACK.  I believe Andrew added some cleanups which I should want?



From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: IORDY handling
Date: Fri, 23 Nov 2007 19:43:49 -0500
Message-ID: <474773C5.5000305@garzik.org>
References: <20071119143311.606d88fd@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56681 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751790AbXKXAnw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Nov 2007 19:43:52 -0500
In-Reply-To: <20071119143311.606d88fd@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> I believe this version meets all Sergei's objections
> 
> Correct the logic for when we issue a set features for transfer mode
> 
> - If the device has IORDY and the controller has IORDY - set the mode
> - If the device has IORDY and the controller does not - turn IORDY off
> - If neither has IORDY do nothing
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied #upstream



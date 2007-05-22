From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ata_piix: clean up
Date: Mon, 21 May 2007 20:02:57 -0400
Message-ID: <46523331.5050909@garzik.org>
References: <20070521151551.651e3836@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46683 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758931AbXEVADA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 21 May 2007 20:03:00 -0400
In-Reply-To: <20070521151551.651e3836@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> With cable methods in place we don't need a custom error handler for SATA
> so get rid of it
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied



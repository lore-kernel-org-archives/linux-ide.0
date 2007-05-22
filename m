From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_hpt366: Enable bits are unreliable so don't use
 them
Date: Mon, 21 May 2007 20:02:51 -0400
Message-ID: <4652332B.9010709@garzik.org>
References: <20070521145249.67bf910b@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46674 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757282AbXEVACx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 21 May 2007 20:02:53 -0400
In-Reply-To: <20070521145249.67bf910b@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> Various people had problems with both old and new IDE when hpt366 enable
> bits started getting honoured. It turns out they are not reliable so
> don't rely on them
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied



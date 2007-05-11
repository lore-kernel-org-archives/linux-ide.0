From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 13/20] Use menuconfig objects: libata
Date: Fri, 11 May 2007 18:16:39 -0400
Message-ID: <4644EB47.5080707@garzik.org>
References: <200705110548.l4B5ms5x007651@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:43704 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756781AbXEKWQl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 11 May 2007 18:16:41 -0400
In-Reply-To: <200705110548.l4B5ms5x007651@shell0.pdx.osdl.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-ide@vger.kernel.org, jengelh@linux01.gwdg.de, jengelh@gmx.de

akpm@linux-foundation.org wrote:
> From: Jan Engelhardt <jengelh@linux01.gwdg.de>
> 
> Use menuconfigs instead of menus, so the whole menu can be disabled at once
> instead of going through all options.
> 
> Signed-off-by: Jan Engelhardt <jengelh@gmx.de>
> Cc: Jeff Garzik <jeff@garzik.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/ata/Kconfig |   10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)

applied



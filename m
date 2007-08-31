From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: Spot bridge chips
Date: Fri, 31 Aug 2007 05:35:20 -0400
Message-ID: <46D7E0D8.60707@garzik.org>
References: <20070822232245.043267d3@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45095 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932129AbXHaJfW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 31 Aug 2007 05:35:22 -0400
In-Reply-To: <20070822232245.043267d3@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> If we have a PATA cable with a SATA drive on it then we've found a
> bridge and we can flip the cable type. This fixes some cable detect
> problems with SATA bridges on chipsets and misdetected cable types.
> 
> In theory cable detection and mode limiting is needed if you put a
> SATA/PATA bridge on a 40 wire cable, but I see no way to deal with
> that other than to point out its not a good idea anyway.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied



From: Jeff Garzik <jeff@garzik.org>
Subject: Re: -mm merge plans for 2.6.20
Date: Wed, 06 Dec 2006 14:40:21 -0500
Message-ID: <45771CA5.30106@garzik.org>
References: <20061204204024.2401148d.akpm@osdl.org>	 <4574FC0A.8090607@garzik.org>  <20061204214114.433485fc.akpm@osdl.org> <1165432780.21881.20.camel@linux-qmhe.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:58643 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937559AbWLFTk0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 6 Dec 2006 14:40:26 -0500
In-Reply-To: <1165432780.21881.20.camel@linux-qmhe.site>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: conke.hu@gmail.com
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Conke Hu wrote:
>     The following patch is ATI's final solution. It was ACKed by Alan.
>     Jeff, you're the maintainer of libata, but this patch is based on
> pci/quirks.c, so I don't know who will apply this patch? You or somebody
> else?
>     Andrew, could you please drop ATI's previous patch and add this one
> in next -mm patch? The previous patch I sent
> (ahci-ati-sb600-sata-support-for-various-modes.patch) is not as good as
> this one :)


I ACK'd it as well, though probably Andrew or Greg should push it.

	Jeff



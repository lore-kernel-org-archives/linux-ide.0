From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.23-rc3] pata_pdc2027x: PLL detection fixes
Date: Sat, 18 Aug 2007 20:53:31 -0400
Message-ID: <46C7948B.1080107@garzik.org>
References: <200708182058.l7IKwrcJ016820@harpo.it.uu.se> <46C763D1.7060801@garzik.org> <46C78B57.5070808@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47776 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752370AbXHSAxf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 18 Aug 2007 20:53:35 -0400
In-Reply-To: <46C78B57.5070808@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Albert Lee wrote:
> The first rmb() is to make sure bccrl is read before bccrlv for later
> (bccrl >= bccrlv) check since both reading the same memory address.

That's already guaranteed without the rmb(), AFAICS.

	Jeff



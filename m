From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata: Add a horkage entry for DRQ mishandling (atapi
 tapes)
Date: Fri, 21 Sep 2007 20:33:58 -0400
Message-ID: <46F462F6.4000105@rtr.ca>
References: <20070920152751.6b707705@the-village.bc.nu>	<46F2E04A.2000201@garzik.org> <20070920224217.1c89dda9@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1177 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754678AbXIVAd5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 21 Sep 2007 20:33:57 -0400
In-Reply-To: <20070920224217.1c89dda9@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, akpm@osdl.org, linux-ide@vger.kernel.org, Albert Lee <albertcc@tw.ibm.com>

Alan Cox wrote:
>..
> The other possibility is to whine but accept it happens - on the other
> hand being lax about HSM errors is asking for corruption and it seems
> to be unique to this tape device.

s/this tape device/several tape devices/

Or possibly even "all" tape devices.

Cheers

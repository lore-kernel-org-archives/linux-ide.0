From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: Early CFA adapters are not required to support
 mode setting
Date: Tue, 06 Feb 2007 20:04:42 -0500
Message-ID: <45C925AA.9050807@garzik.org>
References: <20070205162830.5f9cff4a@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:57153 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965616AbXBGBEq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Feb 2007 20:04:46 -0500
In-Reply-To: <20070205162830.5f9cff4a@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

Alan wrote:
> If we are doing a PIO setup for a CFA card and it blows up with a device
> error then assume it is an older CFA card which doesn't support this
> rather than failing the device out of existance.
> 
> Stands seperate to the quieting patch but that is obviously useful with
> this change.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied



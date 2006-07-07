From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 23/24] libata: Enable per device speed setting
Date: Fri, 07 Jul 2006 12:39:27 -0400
Message-ID: <44AE8E3F.7060206@pobox.com>
References: <1152036108346-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361141196-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361153194-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361162763-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361161279-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361173710-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361183634-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036119810-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361203144-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361212843-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036122125! 0-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361233826-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361232889-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361243147-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361254139-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361251284-git-send-email-al
 an@lxorguk.ukuu.org.uk> <11520361272182-git-send-email-alan@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45288 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932220AbWGGQjb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Jul 2006 12:39:31 -0400
In-Reply-To: <11520361272182-git-send-email-alan@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: alan@lxorguk.ukuu.org.uk
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, Alan Cox <alan@redhat.com>

alan@lxorguk.ukuu.org.uk wrote:
> From: Alan Cox <alan@redhat.com>
> 
> Testing says that nothing seems to break when we do this.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

Tested with ata_piix?

Evaluated to ensure that it matches up with Intel ICH and all other PATA 
controller timing register setups?

If yes to both... ACK.



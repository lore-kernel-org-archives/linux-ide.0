From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 23/24] libata: Enable per device speed setting
Date: Fri, 07 Jul 2006 18:06:59 +0100
Message-ID: <1152292019.20883.44.camel@localhost.localdomain>
References: <1152036108346-git-send-email-alan@lxorguk.ukuu.org.uk>
	 <11520361141196-git-send-email-alan@lxorguk.ukuu.org.uk>
	 <11520361153194-git-send-email-alan@lxorguk.ukuu.org.uk>
	 <11520361162763-git-send-email-alan@lxorguk.ukuu.org.uk>
	 <11520361161279-git-send-email-alan@lxorguk.ukuu.org.uk>
	 <11520361173710-git-send-email-alan@lxorguk.ukuu.org.uk>
	 <11520361183634-git-send-email-alan@lxorguk.ukuu.org.uk>
	 <1152036119810-git-send-email-alan@lxorguk.ukuu.org.uk>
	 <11520361203144-git-send-email-alan@lxorguk.ukuu.org.uk>
	 <11520361212843-git-send-email-alan@lxorguk.ukuu.org.uk>
	 <1152036122125! 0-git-send-email-alan@lxorguk.ukuu.org.uk>
	 <11520361233826-git-send-email-alan@lxorguk.ukuu.org.uk>
	 <11520361232889-git-send-email-alan@lxorguk.ukuu.org.uk>
	 <11520361243147-git-send-email-alan@lxorguk.ukuu.org.uk>
	 <11520361254139-git-send-email-alan@lxorguk.ukuu.org.uk>
	 <11520361251284-git-send-email-alan@lxorguk.ukuu.org.uk>
	 <11520361272182-git-send-email-alan@lxorguk.ukuu.org.uk>
	 <44AE8E3F.7060206@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:12714 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932179AbWGGQuk
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 7 Jul 2006 12:50:40 -0400
In-Reply-To: <44AE8E3F.7060206@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, Alan Cox <alan@redhat.com>

Ar Gwe, 2006-07-07 am 12:39 -0400, ysgrifennodd Jeff Garzik:
> Tested with ata_piix?
> 
> Evaluated to ensure that it matches up with Intel ICH and all other PATA 
> controller timing register setups?
> 
> If yes to both... ACK.

Yes, tested and double checked. The one bug I found with this was the
secondary slave timing bug and that was fixed some time ago.

Alan


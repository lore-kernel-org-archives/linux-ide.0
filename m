From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 11/24] jmicron: Add quirks to force the device into a
	sane mode
Date: Fri, 07 Jul 2006 17:51:21 +0100
Message-ID: <1152291082.20883.34.camel@localhost.localdomain>
References: <1152036108346-git-send-email-alan@lxorguk.ukuu.org.uk>
	 <1152036109145-git-send-email-alan@lxorguk.ukuu.org.uk>
	 <1152036109888-git-send-email-alan@lxorguk.ukuu.org.uk>
	 <11520361102106-git-send-email-alan@lxorguk.ukuu.org.uk>
	 <1152036111326-git-send-email-alan@lxorguk.ukuu.org.uk>
	 <11520361121401-git-send-email-alan@lxorguk.ukuu.org.uk>
	 <11520361123190-git-send-email-alan@lxorguk.ukuu.org.uk>
	 <1152036113264-git-send-email-alan@lxorguk.ukuu.org.uk>
	 <11520361141196-git-send-email-alan@lxorguk.ukuu.org.uk>
	 <11520361153194-git-send-email-alan@lxorguk.ukuu.org.uk>
	 <11520361162763-git-send-email-alan@lxorguk.ukuu.org.uk>
	 <11520361161279-git-send-email-alan@lxorguk.ukuu.org.uk>
	 <44AE8A83.8070704@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:61856 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932214AbWGGQfJ
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 7 Jul 2006 12:35:09 -0400
In-Reply-To: <44AE8A83.8070704@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, Alan Cox <alan@redhat.com>

Ar Gwe, 2006-07-07 am 12:23 -0400, ysgrifennodd Jeff Garzik:
> > +MODULE_DESCRIPTION("SCSI low-level driver for Netcell PATA RAID");
> 
> obviously wrong :)

Alread fixed by the end of the jmicron diffs in the queue.


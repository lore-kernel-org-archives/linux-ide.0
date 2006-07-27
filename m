From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: Add full Compact Flash support to libata
Date: Thu, 27 Jul 2006 19:04:08 +0100
Message-ID: <1154023449.13509.71.camel@localhost.localdomain>
References: <1154016810.13509.61.camel@localhost.localdomain>
	 <44C8FAE5.1000400@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:8602 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750976AbWG0RrA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 27 Jul 2006 13:47:00 -0400
In-Reply-To: <44C8FAE5.1000400@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, akpm@osdl.org

Ar Iau, 2006-07-27 am 13:41 -0400, ysgrifennodd Mark Lord:
> Alan Cox wrote:
> > This is mostly interesting from the embedded end of the universe
> > where people use the CFA high speed non UDMA modes more. Some generic
> > controllers can do PIO5 and friends, that will follow later on.
> 
> Cool.  Do you have one to test with?

Controller or device ?

The VIA and ALi controllers can be persuaded to do PIO5 etc with a good
cable and CF adapter.

Alan


From: Alexey Dobriyan <adobriyan@mail.ru>
Subject: Re: [BK PATCHES] 2.6.x libata fixes (mostly)
Date: Wed, 23 Feb 2005 23:57:18 +0200
Message-ID: <200502232357.18723.adobriyan@mail.ru>
References: <421CE018.5030007@pobox.com> <200502232345.23666.adobriyan@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Received: from mx1.mail.ru ([194.67.23.121]:65081 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S261581AbVBWU5Z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Feb 2005 15:57:25 -0500
In-Reply-To: <200502232345.23666.adobriyan@mail.ru>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Lord <mlord@pobox.com>

On Wednesday 23 February 2005 23:45, Alexey Dobriyan wrote:
> > +static void qs_ata_setup_port(struct ata_ioports *port, unsigned long base)
> > +{
> > +	port->cmd_addr		=
> 
> > +	port->error_addr	=
> 
> > +	port->status_addr	=
> 
> > +	port->altstatus_addr	=
> 
> Oo-oops...

Too much snipping and time to sleep for me, sorry. :-(

	Alexey

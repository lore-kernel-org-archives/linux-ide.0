From: Alan Cox <alan@redhat.com>
Subject: Re: PATCH: fixup incomplete ident blocks on ITE raid volumes
Date: Mon, 16 Aug 2004 11:28:16 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040816152816.GD10279@devserv.devel.redhat.com>
References: <20040815144527.GA7983@devserv.devel.redhat.com> <200408161716.35922.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:50922 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267783AbUHPP3Q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Aug 2004 11:29:16 -0400
Content-Disposition: inline
In-Reply-To: <200408161716.35922.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org

On Mon, Aug 16, 2004 at 05:16:35PM +0200, Bartlomiej Zolnierkiewicz wrote:
> This should be part of ITE driver patch and be compiled only when ITE driver 
> is going to be used or even better - there should be new callback for that.

Nice theory but doesn't work that way. The ITE drive will do this even if
you don't have the ITE driver compiled in because it'll be seen as the
mainboard legacy controller (or generic) in some systems.

Alan


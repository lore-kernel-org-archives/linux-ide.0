From: Wichert Akkerman <wichert@wiggy.net>
Subject: Re: 2.6.11rc4: irq 5, nobody cared
Date: Mon, 21 Feb 2005 20:42:27 +0100
Message-ID: <20050221194227.GH6722@wiggy.net>
References: <20050220155600.GD5049@vanheusden.com> <4218C692.9040106@tiscali.de> <20050220180550.GA18606@ime.usp.br> <200502211943.59887.bzolnier@elka.pw.edu.pl> <421A2D8F.3050704@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from levante.wiggy.net ([195.85.225.139]:58060 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S262085AbVBUTmc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Feb 2005 14:42:32 -0500
Content-Disposition: inline
In-Reply-To: <421A2D8F.3050704@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>, Matthias-Christian Ott <matthias.christian@tiscali.de>, =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Previously Jeff Garzik wrote:
> You should add this to your procmailrc :)
> 
> # Nuke duplicate messages
> :0 Wh: msgid.lock
> | $FORMAIL -D 32768 msgid.cache

That has the nasty side-effect of spreading messages for a single
discussion amongst many different mailboxes depending on which path
happens to be the first to deliver an email to you.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.

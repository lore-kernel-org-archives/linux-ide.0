From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: broken ide-tape
Date: Sun, 31 May 2009 18:17:41 +0200
Message-ID: <20090531161740.GA7975@liondog.tnic>
References: <4A229998.6070808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f168.google.com ([209.85.220.168]:59163 "EHLO
	mail-fx0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756698AbZEaQRn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 31 May 2009 12:17:43 -0400
Content-Disposition: inline
In-Reply-To: <4A229998.6070808@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Sun, May 31, 2009 at 04:52:08PM +0200, Jiri Slaby wrote:
> Hi,
> 
> ide-tape is broken since commit 346331f82823682fb5c2df6e827db25d95cc2e92
> (ide-tape: remove atomic test/set macros for packet commands)
> from Apr 18 2008.
> 
> The commit introduced flags which are defined as (1 << nr) and uses them
> in {clear,set,test}_bit. And hence it must oops on each do_request.

/me ducks behind the couch.

Ouch, that _is_ dumb, sorry. This is because we wanted to keep the
atomic ops for the pipeline handling (which got removed) and use
simple flags for the rest. And so the flags got mixed up and the mess
unleashed...

> Is it worth fixing (something like ilog2 added to each bit operation) or
> is a complete removal of the driver better "fix"?

Actually, the driver needs to be reaudited and fixed properly - we still
have some users left. I'm looking into it.

Thanks for catching that.

-- 
Regards/Gruss,
    Boris.

From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: Re: [PATCH] ide.c: microscopic size and readability optimization
Date: Fri, 18 May 2007 10:28:06 +0200 (CEST)
Message-ID: <50515.61115.qm@web86902.mail.ukl.yahoo.com>
References: <20070517130643.39fbfe29@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web86902.mail.ukl.yahoo.com ([217.12.13.54]:44022 "HELO
	web86902.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755085AbXERIet (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 May 2007 04:34:49 -0400
In-Reply-To: <20070517130643.39fbfe29@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>


--- Alan Cox <alan@lxorguk.ukuu.org.uk> schrieb:

> On Thu, 17 May 2007 13:25:54 +0200
> Borislav Petkov <bbpetkov@yahoo.de> wrote:
> 
> > -----
> > From: bbpetkov@yahoo.de
> > 
> > A very small size (object file 432 bytes smaller)
> and readability optimization of ide.c
> > 
> > Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>
> 
> Bad idea. Now you won't know which of the conditions
> caused the BUG() to
> occur.

Ups, sorry, that I hadn't considered. Nevermind the
noise.

Boris. 



		
___________________________________________________________ 
Telefonate ohne weitere Kosten vom PC zum PC: http://messenger.yahoo.de

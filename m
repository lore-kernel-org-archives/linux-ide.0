From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: floppy vs late kernels
Date: Tue, 22 Jul 2008 00:44:30 +0100
Message-ID: <20080722004430.7dd9ba09@lxorguk.ukuu.org.uk>
References: <200807211944.38029.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:48640 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752685AbYGVABk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jul 2008 20:01:40 -0400
In-Reply-To: <200807211944.38029.gene.heskett@verizon.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-ide@vger.kernel.org

On Mon, 21 Jul 2008 19:44:37 -0400
Gene Heskett <gene.heskett@verizon.net> wrote:

> Greetings all;
> 
> I was just contacted off-list by someone who saw my message about the failed 
> floppy on 2.6.26-rc2, who had a copy of DSL with a 2.4 kernel in it.
> 
> His floppy drive worked flawlessly when booted to DSL.  But like mine, dd bails 
> out with an error, no such device, when booted to a recent 2.6 kernel. 
> 
> So possibly this needs looked at a little closer?

What sort of floppy - if its a standard 34pin PC floppy this is still
true but the linux-ide list is the wrong place to report it


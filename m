From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2.6.20-rc1] Toshiba TC86C001 IDE driver (take 2)
Date: Wed, 13 Dec 2006 21:14:36 +0000
Message-ID: <20061213211436.50917a26@localhost.localdomain>
References: <200612132319.33588.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53309 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750960AbWLMVGh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Dec 2006 16:06:37 -0500
In-Reply-To: <200612132319.33588.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: akpm@osdl.org, bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 13 Dec 2006 23:19:33 +0300
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> Behold!  This is the driver for the Toshiba TC86C001 GOKU-S PCI IDE controller,
> completely reworked from the original brain-damaged Toshiba's 2.4 version.
> 
> This single channel UltraDMA/66 controller is very simple in programming, yet
> Toshiba managed to plant many interesting bugs in it.  The particularly nasty
> "limitation 5" (as they call the errata) caused me to abuse the IDE core in a
> possibly most interesting way so far.  However, this is still better than the
> #ifdef mess in drivers/ide/ide-io.c that the original version included  (well,
> it had much more mess)...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Acked-by: Alan Cox <alan@redhat.com>

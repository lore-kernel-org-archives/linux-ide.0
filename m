From: Rogier Wolff <R.E.Wolff@Harddisk-recovery.com>
Subject: Re: [PATCH] prevent module unloading for legacy IDE chipset drivers
Date: Mon, 26 Apr 2004 08:31:37 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040426063137.GB11567@bitwizard.nl>
References: <200404212219.24622.bzolnier@elka.pw.edu.pl> <20040422004104.GA19969@codepoet.org> <200404220250.15078.bzolnier@elka.pw.edu.pl> <20040422103355.GC15176@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from users.linvision.com ([62.58.92.114]:51094 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S262956AbUDZGbk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Apr 2004 02:31:40 -0400
Content-Disposition: inline
In-Reply-To: <20040422103355.GC15176@harddisk-recovery.com>
List-Id: linux-ide@vger.kernel.org
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, andersen@codepoet.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Apr 22, 2004 at 12:33:55PM +0200, Erik Mouw wrote:
> On Thu, Apr 22, 2004 at 02:50:15AM +0200, Bartlomiej Zolnierkiewicz wrote:
> > On Thursday 22 of April 2004 02:41, Erik Andersen wrote:
> > > Out of curiosity, what would be needed to make it safe to unload
> > > all ide modules from a system with a scsi rootfs?
> > 
> > It doesn't matter - you still may end up unloading modules which are in use.
> 
> FWIW, with the old IDE code I've been unloading IDE modules for years
> without a single problem.

Hmm. Not completely true: It crashes on our VIA EPIA board. Would 
anybody have an idea why it works on most systems, but crashes
hard on the VIA EPIA? (I'm not sure wether it crashes the hardware
or the software). 

			Roger. 

-- 
+-- Rogier Wolff -- www.harddisk-recovery.nl -- 0800 220 20 20 --
| Files foetsie, bestanden kwijt, alle data weg?!
| Blijf kalm en neem contact op met Harddisk-recovery.nl!

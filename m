From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [git patches] libata fixes
Date: Fri, 5 Jun 2009 21:16:47 +0100
Message-ID: <20090605211647.2f118a5c@lxorguk.ukuu.org.uk>
References: <20090605184608.GA29250@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:53324 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750876AbZFEUQh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Jun 2009 16:16:37 -0400
In-Reply-To: <20090605184608.GA29250@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Fri, 5 Jun 2009 14:46:08 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> 
> Please pull from 'upstream-linus' branch of
> master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-linus

Missing

    libata: Use IGN_SIMPLEX for ALi

which you said you'd kick upstream and without which lots of ALi users
now get no DMA on half their devices due to PM changes.


From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [git patch] libata fix
Date: Mon, 25 Sep 2006 21:30:57 +0100
Message-ID: <1159216257.11049.137.camel@localhost.localdomain>
References: <20060925193511.GA6129@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:16031 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750816AbWIYUGZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 25 Sep 2006 16:06:25 -0400
In-Reply-To: <20060925193511.GA6129@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Ar Llu, 2006-09-25 am 15:35 -0400, ysgrifennodd Jeff Garzik:
> [hey Linus, your git summary hint helped, thanks]
> 
> Please pull from 'upstream-linus' branch of
> master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-linus

Btw this one doesn't actually solve the FRV case. That's going to need
some more work and thinking. Look for patches tomorrow.

Alan


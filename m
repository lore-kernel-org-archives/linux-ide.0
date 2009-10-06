From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/2] two ide fixes for -rc4
Date: Tue, 6 Oct 2009 15:35:24 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0910061534040.3432@localhost.localdomain>
References: <200910070027.30377.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933543AbZJFWgN@vger.kernel.org>
In-Reply-To: <200910070027.30377.bzolnier@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Joao Ramos <joao.ramos@inov.pt>, David Fries <david@fries.net>, d.stussy@yahoo.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


David, can you test these on the sis5513 system that had problems with the 
original pio0 mode setting?

	Thanks,
		Linus

On Wed, 7 Oct 2009, Bartlomiej Zolnierkiewicz wrote:
> 
> patch #1 fixes old bug in sis5513 (uncovered by 2.6.30 device probing
> changes but it could be also triggered in earlier kernels on warm-plug
> operation)
> 
> patch #2 reverts the recent incorrect revert
> 

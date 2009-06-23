From: David Miller <davem@davemloft.net>
Subject: Re: cmd64x: irq 14: nobody cared - system is dreadfully slow
Date: Tue, 23 Jun 2009 03:47:43 -0700 (PDT)
Message-ID: <20090623.034743.158192924.davem@davemloft.net>
References: <200906221716.05983.elendil@planet.nl>
	<200906221938.27574.bzolnier@gmail.com>
	<200906222101.38586.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <200906222101.38586.elendil@planet.nl>
Sender: sparclinux-owner@vger.kernel.org
To: elendil@planet.nl
Cc: bzolnier@gmail.com, sparclinux@vger.kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Frans Pop <elendil@planet.nl>
Date: Mon, 22 Jun 2009 21:01:37 +0200

> The question is maybe: are there other devices that currently have dma 
> disabled because of the (old) code and would stop working with 
> ide_id_dma_bug() completely removed? The conservative thing to do I guess 
> would be to reverse 8d64fcd9.

For this specific situation I would likely avoid a revert at least
with how things currently stand.

Right now we are not yet certain what introduced the problem.

We are also not certain what might break by reverting this commit,
either.  There are portions of that commit other than the one
changing the logic of ide_id_dma_bug().

That's a "fix" based upon two large unknowns, which is not wise I
think :)

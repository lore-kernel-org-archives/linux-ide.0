From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: linux-next: Tree for October 24 - powerpc - build failure with
 !CONFIG_BLK_DEV_IDEDMA_PMAC
Date: Tue, 09 Dec 2008 08:54:29 +1100
Message-ID: <1228773269.7101.40.camel@pasglop>
References: <20081024171932.1e8131d0.sfr@canb.auug.org.au>
	 <1224889818.7654.466.camel@pasglop> <200810251519.57543.bzolnier@gmail.com>
	 <200812071527.52886.bzolnier@gmail.com>
	 <20081208090549.GA16544@linux.vnet.ibm.com>
	 <1228773216.7101.39.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <1228773216.7101.39.camel@pasglop>
Sender: linux-next-owner@vger.kernel.org
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, 2008-12-09 at 08:53 +1100, Benjamin Herrenschmidt wrote:
> > > Seems like ppc people are either very busy or don't care...  Oh well...
> 
> Very busy will do it :-) Among others, having a second child is a hit on
> the hacking time !
> 
> In any case, I think we should contemplate removing the config option
> alltogether and make DMA support built unconditionally to simplify the
> mess, don't you think ?

Which is just what the patch does .. :-)

So Ack.

Cheers,
Ben.

From: Andre Hedrick <andre@linux-ide.org>
Subject: Re: ide-2.4.20-pre4-ac2.patch
Date: Thu, 29 Aug 2002 20:36:14 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.10.10208292034210.24156-100000@master.linux-ide.org>
References: <1030661741.1326.7.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <1030661741.1326.7.camel@irongate.swansea.linux.org.uk>
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org


Deal, undoing the moves.

Parsing out all the summitted stuff first for send.
Then the breakdown of the rest.

Gemme a bit to catch on to your request, Viro is trying to teach the ways
of mad patcher and not the patch bomber.

Cheers,

On 29 Aug 2002, Alan Cox wrote:

> On Tue, 2002-08-27 at 23:17, Andre Hedrick wrote:
> > 
> > This is out and has been forwarded to AC for review.
> 
> Rejected. I found several errors, a couple of strange reverts and some
> files being moved to clearly wrong places. It also mixes up multiple
> changes.
> 
> Andre to make this work I need
> 	- One change per patch (within reason)
> 	- An explanation of what it does
> 
> For example I've got files you moved and changed, looking at that in
> diff is a right pita. I've got a big diff with errors in it (eg gayle in
> ppc) I can't easily be sure I can cleanly drop parts of.
> 
> Lets start with the file moving. Send me a diff for the Config/Makefile
> and a lit of the files to move and where. Gayle I think should be m68k
> not ppc (actually Im pretty sure), CMD640 is PCI so why file it in
> legacy. "legacy" I took to mean pre PCI rather than "I think its junk"
> 8)
> 
> 

Andre Hedrick
LAD Storage Consulting Group


From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ide-2.4.20-pre4-ac2.patch
Date: Fri, 30 Aug 2002 11:40:52 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20020830094052.26359@192.168.4.1>
References: <1030661741.1326.7.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <1030661741.1326.7.camel@irongate.swansea.linux.org.uk>
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

>Rejected. I found several errors, a couple of strange reverts and some
>files being moved to clearly wrong places. It also mixes up multiple
>changes.
>
>Andre to make this work I need
>	- One change per patch (within reason)
>	- An explanation of what it does
>
>For example I've got files you moved and changed, looking at that in
>diff is a right pita. I've got a big diff with errors in it (eg gayle in
>ppc) I can't easily be sure I can cleanly drop parts of.
>
>Lets start with the file moving. Send me a diff for the Config/Makefile
>and a lit of the files to move and where. Gayle I think should be m68k
>not ppc (actually Im pretty sure), CMD640 is PCI so why file it in
>legacy. "legacy" I took to mean pre PCI rather than "I think its junk"
>8)

Andre, you should probably remove my "patch0" from your patch
(the very first one I sent you to fix PPC compile on -ac so
you could test on your PPC). Alan already have it, I sent it
more for your own tests on PPC than for inclusion in your
patch, which is why I sent it separately from the other IDE
related patches.

Ben.



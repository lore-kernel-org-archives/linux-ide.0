From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ide-2.4.20-pre4-ac2.patch
Date: 29 Aug 2002 23:55:41 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1030661741.1326.7.camel@irongate.swansea.linux.org.uk>
References: <Pine.LNX.4.10.10208271503530.24156-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10208271503530.24156-100000@master.linux-ide.org>
List-Id: linux-ide@vger.kernel.org
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Tue, 2002-08-27 at 23:17, Andre Hedrick wrote:
> 
> This is out and has been forwarded to AC for review.

Rejected. I found several errors, a couple of strange reverts and some
files being moved to clearly wrong places. It also mixes up multiple
changes.

Andre to make this work I need
	- One change per patch (within reason)
	- An explanation of what it does

For example I've got files you moved and changed, looking at that in
diff is a right pita. I've got a big diff with errors in it (eg gayle in
ppc) I can't easily be sure I can cleanly drop parts of.

Lets start with the file moving. Send me a diff for the Config/Makefile
and a lit of the files to move and where. Gayle I think should be m68k
not ppc (actually Im pretty sure), CMD640 is PCI so why file it in
legacy. "legacy" I took to mean pre PCI rather than "I think its junk"
8)



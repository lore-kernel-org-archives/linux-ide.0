From: John Goerzen <jgoerzen@complete.org>
Subject: Re: Promise IDE controller crashes 2.4.22
Date: Thu, 27 Nov 2003 20:24:39 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20031128022439.GA8333@complete.org>
References: <slrnbsche8.2ir.jgoerzen@christoph.complete.org> <200311272042.19568.bzolnier@elka.pw.edu.pl> <20031127225508.GA5926@complete.org> <200311280016.48828.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from glockenspiel.complete.org ([69.10.152.57]:13470 "EHLO
	glockenspiel.complete.org") by vger.kernel.org with ESMTP
	id S261928AbTK1CYp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 27 Nov 2003 21:24:45 -0500
Content-Disposition: inline
In-Reply-To: <200311280016.48828.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org

On Fri, Nov 28, 2003 at 12:16:48AM +0100, Bartlomiej Zolnierkiewicz wrote:
> > > Can you try setting drive to use UDMA100 instead of UDMA133
> > > (by something like 'hdparm -Xudma100 /dev/hda')?

Tried that too, but I got: 

pi:~# hdparm -Xudma100 /dev/hde
-X: missing value


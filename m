From: John Goerzen <jgoerzen@complete.org>
Subject: Re: Promise IDE controller crashes 2.4.22
Date: Fri, 28 Nov 2003 19:52:30 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20031129015230.GA3124@complete.org>
References: <slrnbsche8.2ir.jgoerzen@christoph.complete.org> <20031128022439.GA8333@complete.org> <3FC6BF5A.6050204@stesmi.com> <200311281400.55500.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from glockenspiel.complete.org ([69.10.152.57]:30924 "EHLO
	glockenspiel.complete.org") by vger.kernel.org with ESMTP
	id S263598AbTK2Bwh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 28 Nov 2003 20:52:37 -0500
Content-Disposition: inline
In-Reply-To: <200311281400.55500.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Stefan Smietanowski <stesmi@stesmi.com>, linux-ide@vger.kernel.org

On Fri, Nov 28, 2003 at 02:00:55PM +0100, Bartlomiej Zolnierkiewicz wrote:
> 
> My mistake, it should have been -Xudma5 :-).

I tried the ide2=dma in the kernel and then:

hdparm -d 1 -u 1 -X 69 /dev/hde

That did seem to solve the problem.  Output of hdparm after that
command:

pi:~# hdparm /dev/hde

/dev/hde:
 multcount    = 16 (on)
 IO_support   =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 19929/255/63, sectors = 320173056, start = 0

What does that mean?



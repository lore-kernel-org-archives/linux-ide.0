From: Alan Cox <alan@redhat.com>
Subject: Re: PATCH: (Test) it8212 driver for 2.6.9rc3
Date: Thu, 30 Sep 2004 17:27:18 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040930212718.GE27138@devserv.devel.redhat.com>
References: <20040930184535.GA31197@devserv.devel.redhat.com> <200409302218.48115.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:39390 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269536AbUI3V1h (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Sep 2004 17:27:37 -0400
Content-Disposition: inline
In-Reply-To: <200409302218.48115.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>, y@redhat.com
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Thu, Sep 30, 2004 at 10:18:47PM +0200, Bartlomiej Zolnierkiewicz wrote:
> Why you are doing this instead of including needed core changes in the
> patch and describing them in the patch description is beyond my mind.

Because I'm dealing with real users who want it to work with real product 
and because I work for a vendor 8). Also because I need this to work on 2.4.x
eventually. I'm assuming the small IDE changes won't make 2.6.9 since Linus
is now close to a 2.6.9 proper. I've sent the IDE changes before, you didn't
pass them on to Linus so I'm now taking the neccessary alternative steps in
the short term.

> - add hook for hwif->ident_quirks (4 lines of code)

Do we need it given the existing iop hooks ?

> - add hook for hwif->raw_taskfile (8 lines of code)

Thats definitely the right approach although 

> - make ide-disk allow no geometry (3 lines of code)

Actually its a few more - the size check needs fixing

But this is really irrelevant, they aren't there today, they are not there
in 2.4.x, Linus isnt likely to take them in time for 2.6.9.

> - allow rmmod of it8212 module
>   (much more LOC but no trick for it present)

The rmmod is no big deal, its brilliant for debug but I know of no
hotswappable it8212 setup.

> And you say that you want real fixes to be included in the IDE core,
> so they should be tested and reviewed, not the tricky workarounds!

Well I've submitted various IDE changes, when they appear great, until then
the rest of the universe would like to use their IDE controller and its becoming
present as the secondary controller on some mainboards. This patch (plus
any testing bugs I find) solves the end user problem neatly.

Alan


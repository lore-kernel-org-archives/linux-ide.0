From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [BK PATCHES] ide-2.6 update
Date: Sun, 24 Oct 2004 22:15:26 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <58cb370e04102413156543b72e@mail.gmail.com>
References: <58cb370e04102405081d62bf40@mail.gmail.com>
	 <m3zn2boq1h.fsf@lugabout.cloos.reno.nv.us>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zeus.kernel.org ([204.152.189.113]:34553 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261621AbUJXUQ3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 24 Oct 2004 16:16:29 -0400
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.199])
	by zeus.kernel.org (8.12.11/8.11.6) with ESMTP id i9OKGRA1019504
	for <linux-ide@vger.kernel.org>; Sun, 24 Oct 2004 13:16:28 -0700
Received: by rproxy.gmail.com with SMTP id 77so355238rnk
        for <linux-ide@vger.kernel.org>; Sun, 24 Oct 2004 13:15:27 -0700 (PDT)
In-Reply-To: <m3zn2boq1h.fsf@lugabout.cloos.reno.nv.us>
List-Id: linux-ide@vger.kernel.org
To: James Cloos <cloos@jhcloos.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, 24 Oct 2004 12:48:58 -0700, James Cloos <cloos@jhcloos.com> wrote:
> Are all of the data displayed in /proc/ide/piix et al now available
> in sysfs?  If so, 'twould've been useful for a small utility -- a

All these data can be obtained from user-space,
no need for bloating sysfs.

> la lsscsi(8) -- that can format that data like the /proc/ide files
> to have been released before dropping the /proc files....
> It is a regression to loose convenient access to the controllers'
> current configs....

http://home.elka.pw.edu.pl/~bzolnier/atapci/

released > 2 years ago :)

works fine but probably needs some cut'n'paste updates

Most of these /proc files were buggy / inaccurate and keeping them
had real maintenance cost (hpt366 bug, triflex bug etc.) with absolutely no
added gain in debugging problems (raw PCI config gives much more info).

and yes, this should've been done 2 years ago...

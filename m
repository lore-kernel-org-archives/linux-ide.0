From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: straighten out the IDE layer locking and add hotplug
Date: Mon, 16 Aug 2004 18:36:05 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1092677759.21013.33.camel@localhost.localdomain>
References: <20040815151346.GA13761@devserv.devel.redhat.com>
	 <200408161923.19024.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from the-village.bc.nu ([81.2.110.252]:7909 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266128AbUHPSib (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Aug 2004 14:38:31 -0400
In-Reply-To: <200408161923.19024.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@redhat.com>, linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, torvalds@osdl.org

On Llu, 2004-08-16 at 18:23, Bartlomiej Zolnierkiewicz wrote:
> On Sunday 15 August 2004 17:13, Alan Cox wrote:
> > There really isnt any sane way to break this patch down because all the
> > changes are interlinked so closely.
> 
> at least /proc/ide/hd?/settings:ide-scsi removal and doc fixes are very easy 
> to separate, I also think that locking fixes should be separated from 
> hotplugging ones

I continue to believe splitting the locking and hotplugging ones are
essentially impossible without inventing a fake never written version.
The other stuff can probably be done.

If you can let me know which bits you are going to apply I can work on
sorting out the rest. In the meantime I'll keep a -ac patch for people
who want to work on the IDE bits or who need the fixes and driver
updates.

Alan


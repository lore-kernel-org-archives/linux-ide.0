From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] ide-taskfile.c fixups/cleanups part #2 [4/9]
Date: Wed, 30 Jun 2004 19:16:46 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200406301916.46181.bzolnier@elka.pw.edu.pl>
References: <200406301725.05181.bzolnier@elka.pw.edu.pl> <1088611825.1921.18.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:40904 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266790AbUF3RLo
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 30 Jun 2004 13:11:44 -0400
In-Reply-To: <1088611825.1921.18.camel@gaston>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>

On Wednesday 30 of June 2004 18:10, Benjamin Herrenschmidt wrote:
> On Wed, 2004-06-30 at 10:25, Bartlomiej Zolnierkiewicz wrote:
> > [PATCH] ide: remove BUSY check from task_in_intr()
> > (CONFIG_IDE_TASKFILE_IO=n)
> >
> > We shouldn't ever get there if drive is busy and we can't start transfer
> > in this case.  ide-disk.c:read_intr() also doesn't check for BUSY_STAT
> > bit.
>
> What if we have a shared interrupt with another device ?

drive_is_ready() in ide-io.c:ide_intr() handles that.


From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] ide-taskfile.c fixups/cleanups part #2 [4/9]
Date: Wed, 30 Jun 2004 11:10:25 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1088611825.1921.18.camel@gaston>
References: <200406301725.05181.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:27627 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266767AbUF3QNj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jun 2004 12:13:39 -0400
In-Reply-To: <200406301725.05181.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>

On Wed, 2004-06-30 at 10:25, Bartlomiej Zolnierkiewicz wrote:
> [PATCH] ide: remove BUSY check from task_in_intr() (CONFIG_IDE_TASKFILE_IO=n)
> 
> We shouldn't ever get there if drive is busy and we can't start transfer
> in this case.  ide-disk.c:read_intr() also doesn't check for BUSY_STAT bit.

What if we have a shared interrupt with another device ?

Ben.



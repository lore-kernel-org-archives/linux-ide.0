From: "Adam J. Richter" <adam@yggdrasil.com>
Subject: Re: 2.5.70-bk12+: ide pio scheduling while atomic
Date: Wed, 18 Jun 2003 01:19:53 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200306180819.h5I8JrB27040@freya.yggdrasil.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h-64-105-35-33.SNVACAID.covad.net ([64.105.35.33]:7552 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP id S265100AbTFRIF6
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Jun 2003 04:05:58 -0400
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-ide@vger.kernel.org

On Tue, 17 Jun 2003, Bartlomiej Zolnierkiewicz wrote:
>In 2.5.72 old PIO code is back, so you can turn off CONFIG_IDE_TASKFILE_IO
>just to see if this problem is specific to taskfile code.

	Although I have now observed the "bad: scheduling while atomic!"
problem with PIO mode IDE in 2.5.72, setting CONFIG_IDE_TASKFILE_IO=n
made the messages disappear.  Although this doesn't fix the bug,
and I may yet try to track it down, your suggestion makes the bug
a much smaller problem for me, and will make it easier to track
down.  Thank you!

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Miplitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

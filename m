From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: 2.5.70-bk12+: ide pio scheduling while atomic
Date: Tue, 17 Jun 2003 14:50:55 +0200 (MET DST)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <Pine.SOL.4.30.0306171444320.16043-100000@mion.elka.pw.edu.pl>
References: <200306171221.h5HCLfo02887@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:1783 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264689AbTFQMhi
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Jun 2003 08:37:38 -0400
In-Reply-To: <200306171221.h5HCLfo02887@adam.yggdrasil.com>
List-Id: linux-ide@vger.kernel.org
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-ide@vger.kernel.org


Hi Adam,

In 2.5.72 old PIO code is back, so you can turn off CONFIG_IDE_TASKFILE_IO
just to see if this problem is specific to taskfile code.

At the moment I do not have time to investigate it further,
but anyway please keep me informed.

Regards,
--
Bartlomiej

On Tue, 17 Jun 2003, Adam J. Richter wrote:

> 	In 2.5.70-bk13 (possibly 2.5.70-bk12) through 2.5.71 (haven't
> tried 2.5.72 or 2.5.71-bkN yet),
>
> 	When I use the vanilla IDE driver (PIO mode, I believe), I
> get a flood of "bad: scheduling while atomic!" messages.  These
> messages also print out a stack trace which basically just shows
> the idle thread calling schedule.  This is true even on the
> very first such message (I've verified this by making the
> kernel go into an infinite loop at that point).
>
> 	This behavior began in either 2.5.70-bk12 or 2.5.70-bk13 and has
> persisted through 2.5.71.  There were substantial changes to
> drivers/ide in the bk release where this behavior began.  I haven't
> tried the .71-bk releases or 2.5.72.  By the way, I'm building
> 2.5.72 now, but may not be able to fiddle with it until tomorrow.
>
> 	I've tried making some logs of recent acquisitions and
> releases of spinlocks, with results that suggest that I've
> somehow botched my own logging.  While I am continuing to dig
> into this problem, it looks like the time that I'll be able to
> put into it over the next few weeks will be very limited, so
> I thought I ought to at least report it now before the problem
> gets any more stale.
>
> Adam J. Richter     __     ______________   575 Oroville Road
> adam@yggdrasil.com     \ /                  Miplitas, California 95035
> +1 408 309-6081         | g g d r a s i l   United States of America
>                          "Free Software For The Rest Of Us."


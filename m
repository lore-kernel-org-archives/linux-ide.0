From: James Cloos <cloos@jhcloos.com>
Subject: Re: [BK PATCHES] ide-2.6 update
Date: Sun, 24 Oct 2004 12:48:58 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <m3zn2boq1h.fsf@lugabout.cloos.reno.nv.us>
References: <58cb370e04102405081d62bf40@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ore.jhcloos.com ([64.240.156.239]:18442 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S261186AbUJXTtL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 24 Oct 2004 15:49:11 -0400
In-Reply-To: <58cb370e04102405081d62bf40@mail.gmail.com> (Bartlomiej
 Zolnierkiewicz's message of "Sun, 24 Oct 2004 14:08:15 +0200")
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Are all of the data displayed in /proc/ide/piix et al now available
in sysfs?  If so, 'twould've been useful for a small utility -- a
la lsscsi(8) -- that can format that data like the /proc/ide files
to have been released before dropping the /proc files....

It is a regression to loose convenient access to the controllers'
current configs....

-JimC

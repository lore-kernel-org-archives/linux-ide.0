From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: [BUG 2.6.38.8] Bisected to commit 5fb46ae7b8c51b05a12c6a66108e8d398c20ee09
Date: Mon, 04 Jul 2011 15:06:40 +0200
Message-ID: <4E11BAE0.5020208@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout02.t-online.de ([194.25.134.17]:43102 "EHLO
	mailout02.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757402Ab1GDNZm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Jul 2011 09:25:42 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: gregkh@suse.de
Cc: axboe@kernel.dk, kay.sievers@vrfy.org, "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi everybody!

An openSuse 11.2 system reliably refused to boot properly with kernel 2.6.38.8
although the prior 2.6.38.y kernels worked fine.  After a few seconds booting
stopped. Several <ctrl-c> did help, but a lot of services were not started properly,
only the root partition was available. Nothing unusual could be found in the
kernel messages.

I bisected the problem to commit 5fb46ae7b8c51b05a12c6a66108e8d398c20ee09.

That gave me the idea to disconnect the Plextor PX-755A dvd drive  and to
try 2.6.38.8 again. It booted without problem.

As I do use the dvd drive only once or twice a year on that system I checked the
hardware - it seems that the drive has a mechanical or optical problem.

No kernel can repair a broken dvd drive, but I strongly believe that at least
error handling should be restored to something more reasonable.

cu,
  Knut

knut@linux:~/git/linux-2.6.38.y> git bisect bad
5fb46ae7b8c51b05a12c6a66108e8d398c20ee09 is the first bad commit
commit 5fb46ae7b8c51b05a12c6a66108e8d398c20ee09
Author: Tejun Heo <tj@kernel.org>
Date:   Wed Mar 9 19:54:27 2011 +0100

    ide: Convert to bdops->check_events()

    commit 5b03a1b140e13a28ff6be1526892a9dc538ddef6 upstream.

    Convert ->media_changed() to the new ->check_events() method.  The
    conversion is mostly mechanical.  The only notable change is that
    cdrom now doesn't generate any event if @slot_nr isn't CDSL_CURRENT.
    It used to return -EINVAL which would be treated as media changed.  As
    media changer isn't supported anyway, this doesn't make any
    difference.

    This makes ide emit the standard disk events and allows kernel event
    polling.  Currently, only MEDIA_CHANGE event is implemented.  Adding
    support for EJECT_REQUEST shouldn't be difficult; however, given that
    ide driver is already deprecated, it probably is best to leave it
    alone.

    Signed-off-by: Tejun Heo <tj@kernel.org>
    Acked-by: Jens Axboe <axboe@kernel.dk>
    Cc: Kay Sievers <kay.sievers@vrfy.org>
    Cc: "David S. Miller" <davem@davemloft.net>
    Cc: linux-ide@vger.kernel.org
    Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


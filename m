From: Mark Lord <liml@rtr.ca>
Subject: Re: libata total system lockup fix
Date: Sat, 03 Sep 2005 18:58:44 -0400
Message-ID: <431A2AA4.5010003@rtr.ca>
References: <42E4ED70.1050501@pobox.com> <42E4FC75.70006@pobox.com> <42E50AE9.3000207@rtr.ca> <42F2E267.50402@gmail.com> <42FA70A9.6080608@pobox.com> <43052C03.7060306@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:24245 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S1751282AbVICW6o
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 Sep 2005 18:58:44 -0400
In-Reply-To: <43052C03.7060306@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, hare@suse.de

Another data point on the current libata EH:

I have now been running 2.6.13 for a week now
with no crashes attributable to libata.

This is stock 2.6.13, plus:

   -- libata passthru patch (needed for laptop-mode, etc..)
   -- libata atapi DMA patch (needed for modern laptop)
   -- libata suspend patch (needed for swsusp)
   -- Jeff's libata 2.6.13+ updates from LKML (just on principles)

So the system is no longer crashing due to libata EH.

Now to await the day when I no longer have to patch libata
at all just to have my laptop work properly.

Cheers

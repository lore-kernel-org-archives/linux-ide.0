From: Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: Re: [PATCH] support for PMP used in TT BlackX Duet drive dock
Date: Thu, 7 Apr 2011 21:40:59 +0200
Message-ID: <201104072140.59548.morpheus.ibis@gmail.com>
References: <201104071854.10911.morpheus.ibis@gmail.com> <201104071908.10852.morpheus.ibis@gmail.com> <20110407190300.GA8841@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43745 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756565Ab1DGTlD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Apr 2011 15:41:03 -0400
Received: by fxm17 with SMTP id 17so1905250fxm.19
        for <linux-ide@vger.kernel.org>; Thu, 07 Apr 2011 12:41:02 -0700 (PDT)
In-Reply-To: <20110407190300.GA8841@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On Thursday 07 of April 2011 21:03:00 Tejun Heo wrote:
> I'm confused.  Against which version is the patch generated?  Upstream
> already has quirks for 4726.
> 
> Thakns.

this is what you get from running and editing a different tree (and being 
lazy), sorry for messing it up.

the correct (tested) code, without beautifications/comments:

        } else if (vendor == 0x197b && devid == 0x2352) {
                ata_for_each_link(link, ap, EDGE) {
                        link->flags |= ATA_LFLAG_NO_LPM |
                                       ATA_LFLAG_NO_SRST |
                                       ATA_LFLAG_ASSUME_ATA;
                }
        }

third time's the charm

Thanks
Pavel Herrmann

PS: just to be on the safe side, this is the device detection from dmesg
ata8.15: Port Multiplier 1.1, 0x197b:0x2352 r0, 2 ports, feat 0x0/0x0

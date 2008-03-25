From: Andreas Mohr <andi@lisas.de>
Subject: linux/libata.h/ata_busy_wait() inefficiencies?
Date: Tue, 25 Mar 2008 21:59:04 +0100
Message-ID: <20080325205904.GA19388@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:47848 "EHLO
	rhlx01.hs-esslingen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752944AbYCYVFm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Mar 2008 17:05:42 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello all,

originally I just intended to prepare a patch (to -mm),
but it seems better to discuss this first.

Currently (2.6.25-rc6) we have:

static inline u8 ata_busy_wait(struct ata_port *ap, unsigned int bits,
                               unsigned int max)
{
        u8 status;

        do {
                udelay(10);
                status = ata_chk_status(ap);
                max--;
        } while (status != 0xff && (status & bits) && (max > 0));

        return status;
}

This can easily be improved to have merged max handling
by doing a single (--max > 0) instead, without any change in behaviour.
Building this on i386 showed combined image savings of almost 100 bytes,
most likely due to not having to re-fetch max again for the duplicate
max access.

However we're not finished yet:
Since status != 0xff is most certainly a check for the "unplugged hotplug"
case, it's a bit wasteful to check this as the very first abort condition.
By moving this more towards the end one should be able to improve exit latency
of this loop, without altering behaviour here as well (- right??).
Since the "(status != 0xff && (status & bits)" part is being used verbatim
(ICK, COPY&PASTE!! ;) many times (e.g. also in libata-core.c),
IMHO the best way going forward would be to create another fittingly named
inline header helper for this combined check which could then have its
check order swapped for better exit latency.

Those two tweaks alone may already be able to deliver a noticeable speedup
of ata operations given that this is frequently used inner libata code.

Thoughts on this?

Thanks,

Andreas Mohr

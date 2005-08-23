From: "Timothy Thelin" <Timothy.Thelin@wdc.com>
Subject: libata passthru: implementation of protocol "soft reset" questions / discussion
Date: Mon, 22 Aug 2005 17:13:53 -0700
Message-ID: <CA45571DE57E1C45BF3552118BA92C9D060AE0@WDSCEXBECL03.sc.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wdscexfe02.sc.wdc.com ([129.253.170.52]:42308 "EHLO
	wdscexfe02.sc.wdc.com") by vger.kernel.org with ESMTP
	id S1751130AbVHWANy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Aug 2005 20:13:54 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Hi all,

I've been implementing various peices of missing passthru functionality (for
future review and submission) and I hit a bump, so I'm wondering what you
all think.

For implementing various missing cdb protocols, I'm attempting to merge them
into the normal libata protocols.  So for instance I have a
ATA_PROT_RETURN_RESPONSE (cdb "Return Response Information") and
ATA_PROT_SOFT_RESET (cdb "Soft reset").  This worked well until I needed to
restore xfer modes after the soft reset.

Since the soft reset can reset various volatile settings (pio xfer, dma
xfer, etc), they should get restored before another normal libata command
has a chance to procede.  I thought of simply using ata_setxfer right after
doing the soft reset, but the problem is that doing this invovles launching
a new queued command (inside ata_dev_set_xfermode) from within a queued
command (the original ATA_PROT_SOFT_RESET).  I also thought about
translating the soft reset cdb into 2 sequential queued commands, but the
code path for creating / translating queued commands seems to want a 1-1
relationship between cdb and command.

So anyone have ideas / is there a better way to do this?  There doesn't seem
to be a trivial way to solve this so I figured I'd ask what people wanted as
the solution.

(Note that this same issue will come up with doing the cdb "Hard Reset")

Thanks,
Tim Thelin


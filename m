From: linux@horizon.com
Subject: Re: sata_sil24 corruption details
Date: 10 Nov 2005 02:17:36 -0500
Message-ID: <20051110071736.23747.qmail@science.horizon.com>
References: <20051107095956.27387.qmail@science.horizon.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from science.horizon.com ([192.35.100.1]:24636 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751265AbVKJHSG
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Nov 2005 02:18:06 -0500
In-Reply-To: <20051107095956.27387.qmail@science.horizon.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux@horizon.com

Three days ago, I wrote:
> I finished "badblocks -b 4096 -c 65536 -s -v -w -t random" run on 350
> G of one drive without seeing problems, and am working on the other 5.
> (In parallel, just to stress the driver.)

My parallel -p1 badblocks runs (I shrunk the chunk size to -c 16384)
finished on 3 of the 5 drives, but after 69 hours and I don't know how
many passes, it's still running on one pair of drives.  Interestingly,
the pair (sdc4 & sdd4) is connected to a single controller.

Thus, it might not be a multiple-controller issue (I don't know how
many other people have 3 Sil3132s in a system), but perhaps an issue
with simultaneous activity on the 2 ports of a single controller.

Is there anything else I could do to help debug this problem?  Any additional
debugging I can enable?

It would take me a while to clean the backups off the system and move
it outside the firewall to allow remote access if someone wants access
to that particular hardware, but it's just an expensive bit bucket at
the moment, so ask if it would help...

Thanks!

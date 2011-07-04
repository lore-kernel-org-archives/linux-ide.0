From: David Lamparter <equinox@diac24.net>
Subject: Re: 2.6.39.1: SMART causing random timeouts / "Emask 0x4 (timeout)"
 / "Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen"
Date: Tue, 5 Jul 2011 01:25:01 +0200
Message-ID: <20110704232501.GB1517885@jupiter.n2.diac24.net>
References: <20110704231202.GA1517885@jupiter.n2.diac24.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from spaceboyz.net ([87.106.131.203]:39280 "EHLO spaceboyz.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752560Ab1GDXZJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Jul 2011 19:25:09 -0400
Received: from [2001:8d8:81:5c2::] (helo=jupiter.n2.diac24.net)
	by spaceboyz.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.72)
	(envelope-from <equinox@diac24.net>)
	id 1QdsVo-0000UN-0F
	for linux-ide@vger.kernel.org; Tue, 05 Jul 2011 01:25:08 +0200
Content-Disposition: inline
In-Reply-To: <20110704231202.GA1517885@jupiter.n2.diac24.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Lamparter <equinox@diac24.net>
Cc: linux-ide@vger.kernel.org

On Tue, Jul 05, 2011 at 01:12:02AM +0200, David Lamparter wrote:
> Hi,
> 
> 
> since updating from some 2.6.35 (or 2.6.37?**) stable version to 2.6.39.1,
> i can't seem to run extended SMART diagnostics reliably anymore. When I
> try to run a test, it starts fine but after a while (seems random, note
> the timestamps - tests started simultaneously) I get:
> 
> [464527.840069] ata8.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
> [464527.840083] ata8.00: failed command: SMART
> [464527.840100] ata8.00: cmd b0/d5:01:09:4f:c2/00:00:00:00:00/00 tag 0 pio 512 in
> [464527.840103]          res 40/00:00:06:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
> [464527.840111] ata8.00: status: { DRDY }
> [464527.840125] ata8: hard resetting link
> [464527.840131] ata8: nv: skipping hardreset on occupied port
> [464528.308061] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [464528.348422] ata8.00: configured for UDMA/133
> [464528.348481] ata8: EH complete
> ... later ...
> [472205.856077] ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
> [472205.856091] ata4.00: failed command: SMART
> (+ same as above)
> [477245.856074] ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
> [477245.856089] ata5.00: failed command: SMART
> (+ same as above)
> 
> Of 6 identical disks,
> - 3 completed the test successfully
> - one reports "Extended offline    Interrupted (host reset)" w/ 90% left
> - one reports same w/ 40% left
> - one reports same w/ 10% left
> (matches up with the times, they're all WDC WD10EACS-00D6B1 that take
> 255 minutes = 15300 sec to complete the extended test routine.)
> 
> There are no problems in regular operation, no other exceptions in my
> current dmesg either. SMART info from the disks looks okay as well.
> 
> Any ideas? Known regression? Sadly I'm not sure whether it worked on
> 2.6.37, I think I last ran extended tests on 2.6.35 and that went OK.

Forgot link to hardware info - http://nopaste.info/7d79ff3679.html in
case it's relevant...


-David (Cc please, not subscribed)


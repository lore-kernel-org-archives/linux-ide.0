From: Tomas Lund <tlund@nxs.se>
Subject: Re: Need help understanding SATA error message.
Date: Thu, 3 Apr 2008 12:39:09 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0804031237420.5510@envy.nxs.se>
References: <Pine.LNX.4.61.0803271554050.5510@envy.nxs.se> <47ED136F.9010501@rtr.ca>
 <47ED15D2.3080403@rtr.ca> <Pine.LNX.4.61.0803282315330.5510@envy.nxs.se>
 <47EDBC87.8090109@rtr.ca> <Pine.LNX.4.61.0803301659300.5510@envy.nxs.se>
 <47F0376F.2090000@gmail.com> <47F0FAD3.9060001@rtr.ca> <47F18127.8070509@gmail.com>
 <47F19764.9080705@rtr.ca> <Pine.LNX.4.61.0804010834280.5510@envy.nxs.se>
 <47F224F9.40906@rtr.ca> <47F25FAD.1090200@gmail.com>
 <Pine.LNX.4.61.0804020705120.5510@envy.nxs.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from envy.nxs.se ([212.247.200.182]:51157 "EHLO envy.nxs.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752536AbYDCKjY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 3 Apr 2008 06:39:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by envy.nxs.se (Postfix) with ESMTP id BDEA22BF2E
	for <linux-ide@vger.kernel.org>; Thu,  3 Apr 2008 12:39:09 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.61.0804020705120.5510@envy.nxs.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Wed, 2 Apr 2008, Tomas Lund wrote:

> Apr  2 04:14:17 envy kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
> Apr  2 04:14:17 envy kernel: ata2.00: irq_stat 0x40000001
> Apr  2 04:14:17 envy kernel: ata2.00: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 0
> Apr  2 04:14:17 envy kernel:          res 51/04:00:0a:24:f9/00:00:00:00:00/a9 Emask 0x1 (device error)
> Apr  2 04:14:17 envy kernel: ata2.00: status: { DRDY ERR }
> Apr  2 04:14:17 envy kernel: ata2.00: error: { ABRT }
> Apr  2 04:14:17 envy kernel: ata2.00: configured for UDMA/133
> Apr  2 04:14:18 envy kernel: ata2: EH complete
> Apr  2 04:14:18 envy kernel: sd 1:0:0:0: [sdb] 1953525168 512-byte hardware sectors (1000205 MB)
> Apr  2 04:14:18 envy kernel: sd 1:0:0:0: [sdb] Write Protect is off
> Apr  2 04:14:18 envy kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
> Apr  2 04:14:18 envy kernel: sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA

The errors continue to occur at random interval, even after i stoped the 
copy-alot-of-files-and-sync stresstest.

Any other ideas or things to try?

//tlund

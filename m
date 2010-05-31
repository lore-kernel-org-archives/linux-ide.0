From: Panard <panard@backzone.net>
Subject: ahci issue on MCP89 with Macbookpro7,1
Date: Mon, 31 May 2010 21:17:39 +0200
Message-ID: <201005312117.39590.panard@backzone.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp4-g21.free.fr ([212.27.42.4]:35007 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753093Ab0EaTRz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 31 May 2010 15:17:55 -0400
Received: from banquise.localnet (banquise.backzone.net [88.160.158.19])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 361CD4C8037
	for <linux-ide@vger.kernel.org>; Mon, 31 May 2010 21:17:46 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Dear all,

it seems that the ahci drivers fails with the (apparently supported) MCP89 
chipset on Macbookpro7,1 machines.

Typical error messages are :
[   12.520091] ata2: COMRESET failed (errno=-16)
[   12.520102] ata1: COMRESET failed (errno=-16)
[   17.910090] ata2: link is slow to respond, please be patient (ready=0)
[   17.910095] ata1: link is slow to respond, please be patient (ready=0)
[   22.530090] ata2: COMRESET failed (errno=-16)
[   22.530097] ata1: COMRESET failed (errno=-16)
[   27.920090] ata1: link is slow to respond, please be patient (ready=0)
[   27.920094] ata2: link is slow to respond, please be patient (ready=0)
[   57.560090] ata1: COMRESET failed (errno=-16)
[   57.560095] ata1: limiting SATA link speed to 1.5 Gbps
[   57.560102] ata2: COMRESET failed (errno=-16)
[   57.560105] ata2: limiting SATA link speed to 1.5 Gbps
[   62.590090] ata1: COMRESET failed (errno=-16)
[   62.590094] ata1: reset failed, giving up
[   62.590105] ata2: COMRESET failed (errno=-16)
[   62.590108] ata2: reset failed, giving up

Hence, no disk nor cdrom work on macbookpro7,1.
Full dmesgs, etc. can be found at 
https://bugzilla.kernel.org/show_bug.cgi?id=15923 .

I wonder if there may be any parameters to tune in kernel command line to 
overcome this issue? Or is this a strong issue with the current driver?

I can provide supplementary debug messages if needed.

Thanks,

Panard

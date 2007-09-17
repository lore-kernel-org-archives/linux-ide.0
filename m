From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.22.6 sata_sil device errors & timeouts
Date: Mon, 17 Sep 2007 11:18:49 +0200
Message-ID: <46EE4679.7030600@gmail.com>
References: <76366b180709170135v6c46f3d6qd3586ea79f9abc2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:10939 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753310AbXIQJUo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Sep 2007 05:20:44 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1254850rvb
        for <linux-ide@vger.kernel.org>; Mon, 17 Sep 2007 02:20:44 -0700 (PDT)
In-Reply-To: <76366b180709170135v6c46f3d6qd3586ea79f9abc2@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Paprocki <andrew@ishiboo.com>
Cc: linux-ide@vger.kernel.org

Andrew Paprocki wrote:
> 1) When built with modules disabled, and libata handling the sata +
> pata (AMD CS5536) connections, the pata drives come _after_ the sata
> drives (i.e. w/ 2 sata drives, the first IDE drive is sdc). This makes
> boot configuration more complicated if booting off the pata drive. Is
> there any way to control which order the drives are assigned when not
> building w/ modules?

Please use mount-by-LABEL or UUID.

> 2) The drives display that they support udma6 in hdparm -I, but only
> udma5 is being used. And hdparm -i only shows up to udma2.. ?

For SATA, UDMA mode doesn't matter at all.  As long as you're in DMA
mode, the only thing that matters is PHY link speed and whether NCQ is
enabled.

> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x2400000 action 0x2 frozen

> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x280000 action 0x0

In both cases, SError is indicating transmission problem. Handshake
error and Unrecognized FIS type in the first case, 10b to 8b decode
error and CRC error on the second case.  I can't tell why but signals
flying through those redish cables are getting corrupted.

There have been quite a few cases of bad PSU causing transmission
failures on SATA or you might have a bad controller and/or cables.  The
best way to debug this kind of problem is by elimination - by swapping
hardware piece by piece you can find out which one is causing the problem.

-- 
tejun

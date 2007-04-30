From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_via (pata): problems when write cache is disabled
Date: Mon, 30 Apr 2007 11:52:02 +0200
Message-ID: <4635BC42.6020201@gmail.com>
References: <20070429105001.GA4530@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.234]:6541 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030939AbXD3TuX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Apr 2007 15:50:23 -0400
Received: by nz-out-0506.google.com with SMTP id o1so2031854nzf
        for <linux-ide@vger.kernel.org>; Mon, 30 Apr 2007 12:50:22 -0700 (PDT)
In-Reply-To: <20070429105001.GA4530@deprecation.cyrius.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Michlmayr <tbm@cyrius.com>
Cc: linux-ide@vger.kernel.org, "Williams, Dan J" <dan.j.williams@intel.com>

Martin Michlmayr wrote:
> Is this a bug in the VIA driver?
> 
> Sample errors:
> 
> ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
> ata3.00: (BMDMA stat 0x4)
> ata3.00: cmd ca/00:08:08:80:04/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 out
>          res 53/84:00:0f:80:04/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)

I doubt it's the driver's fault.  It's more likely actual wiring
problem.  In the first two dmesgs, even UDMA/25 doesn't work.  Errors
stop only after it drops speed down to PIO4.  The only thing driver can
do to cause this PATA transmission errors I can think of is
misprogramming the timing registers but transfer mode programming on
vt6421 is as simple as telling the controller the index of the mode, so
it's pretty hard to screw up there.

The difference between the first two and the last one might be that the
last one is just more tolerant about degraded signals.  (e.g. some of
latest PATA drives can do UDMA/100 on 40c cable w/o any problem).

-- 
tejun


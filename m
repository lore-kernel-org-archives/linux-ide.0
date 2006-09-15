From: Tejun Heo <htejun@gmail.com>
Subject: Re: How to make SATA hotplug path tight?
Date: Sat, 16 Sep 2006 03:09:03 +0900
Message-ID: <20060915180903.GC25800@htj.dyndns.org>
References: <8202f4270609150812r654c1319r511b18aadf7e1f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:32117 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751332AbWIOSJI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 15 Sep 2006 14:09:08 -0400
Received: by py-out-1112.google.com with SMTP id n25so4171204pyg
        for <linux-ide@vger.kernel.org>; Fri, 15 Sep 2006 11:09:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <8202f4270609150812r654c1319r511b18aadf7e1f7@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fajun Chen <fajunchen@gmail.com>
Cc: linux-ide@vger.kernel.org

On Fri, Sep 15, 2006 at 09:12:33AM -0600, Fajun Chen wrote:
> Hi,
> 
> I'm trying to speed up the SATA hotplug sequence so I can measure the
> disk spinup time more accurately.  I noticed two delays which may be
> unnecessary in SATA hotplug:
> 1. About 4-5 seconds delay during power cycle (power down then power
> up) as shown below (detail log at the end):
> [65642.680000] ata_eh_prep_resume: ENTER
> [65642.680000] ata_eh_prep_resume: EXIT
> [65642.680000] __ata_port_freeze: ata2 port frozen
> [65646.970000] ata2: soft resetting port
> [65646.970000] sil24_softreset: ENTER
> Question: where is the delay introduced and can we eliminate this delay?

It's probably waiting for ATA_BUSY to clear in prereset.

> 2. Soft reset fails sometimes then followed by a successful hard reset.
> Question: may I do hard reset to start with and where is the best
> place to change this? I know sata spec recommend attempting less
> intrusive recovery procedure first, but I need to eliminate as much
> unnecessary delay as possible.

ATA_FLAG_HRST_TO_RESUME.  You probably also want to tweak
ATA_SPINUP_WAIT.

> Is there any other place in new eh where SATA hotplug can be optimized?

Too many to point out.  :-)

-- 
tejun

From: Justin Maggard <jmaggard10@gmail.com>
Subject: Writing PMP GSCRs at runtime
Date: Fri, 4 Mar 2016 14:17:42 -0800
Message-ID: <CAKgsxVT+cOBR4ut5MHVRQzhY99WDTN6ZiEwPU8-P+z08QAomxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:38212 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759107AbcCDWRn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Mar 2016 17:17:43 -0500
Received: by mail-ig0-f178.google.com with SMTP id y8so5098549igp.1
        for <linux-ide@vger.kernel.org>; Fri, 04 Mar 2016 14:17:42 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I've got an eSATA disk enclosure behind a SATA PMP, which uses a
SiI3826 chip.  This particular enclosure exposes control of some LEDs
and fan speed via the SiI3826 GPIO GSCR [130].

I tried bringing out a sysfs file to read/write GSCRs at runtime using
sata_pmp_write().  This generally works well when the enclosure is
idle.  But if I put the PMP under load (say, creating a MD RAID array
across all the disks and start a resync), every time I read or write a
GSCR, I get an "illegal qc_active transition" message and the PMP
resets.  This occurs at or near 100% of the time.

So then I cobbled together a new function similar to sata_pmp_write(),
but based on the old ahci_pmp_write() function that did polling using
ahci_exec_polled_cmd().  Using this method reduced the odds of causing
a PMP reset from ~100% to ~3%.  But occasionally I still do see
resets.

Does anyone have any ideas on what's going on here, or how to resolve this?

Thanks,
-Justin

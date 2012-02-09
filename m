From: Matt Sealey <matt@genesi-usa.com>
Subject: Timing computation, values missing from table (in spec though)
Date: Thu, 9 Feb 2012 14:19:06 -0600
Message-ID: <CAKGA1bmiocDOg0Li8bA+v8MUuze1Z6yOfWx2kTh76OdJwDVg4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from exprod7og121.obsmtp.com ([64.18.2.20]:58130 "EHLO
	exprod7og121.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757900Ab2BIUT1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Feb 2012 15:19:27 -0500
Received: by mail-tul01m020-f170.google.com with SMTP id up3so3047243obb.29
        for <linux-ide@vger.kernel.org>; Thu, 09 Feb 2012 12:19:26 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>

A question so I can see if I can use ata_timing_compute or possibly improve it..

The current mode timings list seems to be missing a few timings we
need that cannot possibly (and don't seem to be attempted) to be
resolved from the ata_timings table in libata-core.c.

We have a bank of registers in our ATA controller where these values
need setting; is it that the timings table is missing the values (and
the same true of the one in ide-timings.c) no
other drive controller actually needed such fine timings and would
implement them as per the spec minimums by itself? We need to actually
set the specific time in ATA clocks in those
registers, and there is a register for every timing reference in the
ATA spec tables and diagrams.. specifically t4 and t9 are missing for
PIO (and tA would be derived for iordy by the current code, right? But
we also need to set tRD which seems not to be) and for DMA, several
others (tM for MWDMA) and I am really confused where the values for
UDMA are meant to be derived for the controller since none of them are
listed in the comments for struct ata_timing.

Is it a good or bad idea to expand the table to include the extra
timings, or should we just include a custom table of timings and
manage the situation ourselves? Part of my reason for wanting to use
the libata core timings is because of all the safety checks which I
don't get with a custom blob of numbers pulled from some older source
code that I have no idea how they were derived..

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.

From: Greg Freemyer <greg.freemyer@gmail.com>
Subject: Re: strange hdparm results with serverworks and pata-serverworks
Date: Mon, 23 Feb 2009 15:49:43 -0500
Message-ID: <87f94c370902231249of8c9dc3p80ae280ef09b0b94@mail.gmail.com>
References: <49A30901.1@wpkg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:31477 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751888AbZBWUtq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Feb 2009 15:49:46 -0500
Received: by qw-out-2122.google.com with SMTP id 5so1349736qwi.37
        for <linux-ide@vger.kernel.org>; Mon, 23 Feb 2009 12:49:44 -0800 (PST)
In-Reply-To: <49A30901.1@wpkg.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tomasz Chmielewski <mangoo@wpkg.org>
Cc: linux-ide@vger.kernel.org

On Mon, Feb 23, 2009 at 3:37 PM, Tomasz Chmielewski <mangoo@wpkg.org> wrote:
> I have a ProLiant BL30p G1 machine running Debian Lenny (2.6.26 kernel).
>
> It also has two identical, 2.5 inch WDC WD2500BEVE-00WZT0 IDE drives (new
> drives, no smart/badblock errors). Both drives are connected to a single IDE
> channel this machine has.
>
> "hdparm -t" gives me different results for these drives: ~10 MB/s for hda,
> and ~20 MB/s for hdb with "serverworks" driver on Debian's 2.6.26 kernel.
> When using "pata-serverworks" with 2.6.28.7 kernel, hdparm shows the same
> results (~10 MB/s for sda, ~20 MB/s for sdb).
>
>
> However, when I run "dd if=/dev/sda of=/dev/null bs=64k", I can see with
> iostat that for the first 7-8 seconds, reads are with ~10 MB/s speed. Then,
> reads from sda are with ~20 MB/s or more and are on par with sdb.
>
> Similar dd test for sdb shows that it delivers with speed of ~20 MB/s from
> the first second.
>
> Is there an explanation for that?

Just a guess, but I would bet you have some sector remapping going on
in the early portion of the 10/MB/sec drive.

Thus once dd gets based the area that has remapped sectors, it speeds up.

When reading the slow LBA sectors, the head is actually having to seek
back and forth from the primary sector area out to the spares area.
I've seen that before.

FYI: I saw a drive last week that had over 10% of the first 200
sectors bad.  After that all was good.  The drive I was looking at was
several years old and remapping had not been triggered, so it was
obvious what was going on when I ran dd to try and read the entire
drive.

Greg
-- 
Greg Freemyer
Litigation Triage Solutions Specialist
http://www.linkedin.com/in/gregfreemyer
First 99 Days Litigation White Paper -
http://www.norcrossgroup.com/forms/whitepapers/99%20Days%20whitepaper.pdf

The Norcross Group
The Intersection of Evidence & Technology
http://www.norcrossgroup.com

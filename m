Return-Path: <SRS0=z20e=XV=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00796C4360C
	for <linux-ide@archiver.kernel.org>; Thu, 26 Sep 2019 13:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81B1A222BE
	for <linux-ide@archiver.kernel.org>; Thu, 26 Sep 2019 13:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=technikum-wien.at header.i=@technikum-wien.at header.b="vjzXltW6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbfIZNKY (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 26 Sep 2019 09:10:24 -0400
Received: from polyxena.technikum-wien.at ([195.245.225.21]:52348 "EHLO
        polyxena.technikum-wien.at" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725836AbfIZNKX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 26 Sep 2019 09:10:23 -0400
X-Greylist: delayed 379 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Sep 2019 09:10:21 EDT
Received: from legacy (unknown [128.130.40.151])
        by bifrost2.technikum-wien.at (Postfix) with ESMTPSA id 46fFVn2CTFzC1
        for <linux-ide@vger.kernel.org>; Thu, 26 Sep 2019 15:04:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=technikum-wien.at;
        s=bifrost-2017; t=1569503041;
        bh=wYNr+CMOg7y2T8acgcQHIjPzSkXCWlUzeu8yyDXu1ME=;
        h=Date:From:To:Subject:From;
        b=vjzXltW6ZAsiE48euepyuLo7+KF1xwPKfOSR/Ejj2qVP6kCT3UWz+UBIab6e5EtcU
         Vg6EYU/tC4r2/zMjqFgM84IOe8S8MCuNZBI1eKgQVzgV+5LJrV1wd/DopfWqx0d6iL
         JfnYili9QN5geWUuEyh3AW3dKB6X6/ZeXkWvAxFwO0FTknjjKJGVx9uzJiSN8OWBJm
         6jz3nBUOUdeI3R5lFAeu1crXeXAhJHYWZyDWCO4K1SBOaXe9daSKQuz6+mcnvkJnP7
         iDBvCivtxmkRyCvAL4rlh5cF0EeNnNuyu1TEfaIUYl296WwP2w/Pp63p+MsQpGQ9UK
         aj6Fa9mVN4XbQ==
Date:   Thu, 26 Sep 2019 15:04:00 +0200
From:   Stefan Tauner <tauner@technikum-wien.at>
To:     linux-ide@vger.kernel.org
Subject: Questions (and a possible bug) regarding the ata_device_blacklist
 and ATA_HORKAGE_ZERO_AFTER_TRIM
Message-ID: <20190926150400.2524a63b@legacy>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi,

I am running an MD RAID5 with 3 SSDs (2x Crucial CT500MX500 (FW
M3CR022), 1x Samsung 860 EVO (because it was/is the only decent SSD
with msata; FW RVT41B6Q)) on Debian Buster (with an ancient^Wstable
4.19 kernel). Before this setup I was using a RAID1 and weekly fstrim
runs to issue discards.

Today I became aware of the RAID5 discard issue that led to trim being
disabled on such arrays:
https://github.com/torvalds/linux/commit/8e0e99ba64c7ba46133a7c8a3e3f7de01f23bd93

In my research to verify that my drives work fine and if I should
enable it I came across the black (actually white) list in the libata
code. My question is regarding the matching of the model_num field in
the black list. The name and the use of ATA_ID_PROD seem to indicate
that a single ATA "property" is used as the string to match. I don't
know the technical details how this is communicated by the drive but I
assume it's the same thing that smartctl and hdparm output as "Model
Number" and "Device Model" respectively.

If this is correct (is it?) then there is a problem with the list
AFAICT because the Crucial SSD I have reports this field simply as
"CT500MX500SSD4" but the kernel expects "Crucial" at the beginning of
almost all Crucial drives (line 4523+) including the vendor wildcard at
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/ata/libata-core.c#n4586
Interestingly, in line 4520 there is an entry for the CT500BX100SSD1
that does not start with "Crucial".

After looking into smartctl's drive database I guess the MX500 [2] (as
well as BX100, BX200, BX300 and BX500 [1]) series stand out in this
regard. This means that all of them do *not* get the
ATA_HORKAGE_ZERO_AFTER_TRIM flag set because they are not matched by
any of the model-specific entries nor the cumulative "Crucial*" vendor
entry.

I have not tested my drive to actually return zeros after trimming but
from the kernel code I would assume that its intent is to match all
Crucial SSDs and thus it is a bug mine is not matched. If someone
tells me to the preferred method to test it I am happy to do this. If
need be I can also submit a patch (just for MX500? all of the above?).

Is there any way to see which flags the kernel applies to a drive?
Interestingly, "lsblk -D" does only show "0" for the Samsung device
(although AFAICT it is matched by the white list AND reports
"Deterministic read ZEROs after TRIM" according to hdparm. But I don't
know what lsblk actually looks at...?

[1] https://www.smartmontools.org/changeset/4776
[2] https://www.smartmontools.org/browser/trunk/smartmontools/drivedb.h?#L1906

(Please CC since I am not subscribed)

KR
-- 
Dipl.-Ing. Stefan Tauner
Lecturer and former researcher
Embedded Systems Department

University of Applied Sciences Technikum Wien
Hoechstaedtplatz 6, 1200 Vienna, Austria
E: stefan.tauner@technikum-wien.at
I: embsys.technikum-wien.at
I: www.technikum-wien.at

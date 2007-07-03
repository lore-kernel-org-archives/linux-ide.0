From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil, writing bug with multiple cards?
Date: Tue, 03 Jul 2007 17:51:48 +0900
Message-ID: <468A0E24.7020000@gmail.com>
References: <courier.4689EFD9.0000589A@blargh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:24297 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755532AbXGCIxG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 04:53:06 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2675360wah
        for <linux-ide@vger.kernel.org>; Tue, 03 Jul 2007 01:53:06 -0700 (PDT)
In-Reply-To: <courier.4689EFD9.0000589A@blargh.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 7091@blargh.com
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

7091@blargh.com wrote:
> Greetings,
> I have been troubleshooting a problem for over a year now, and to make a
> long story short, I think the sata_sil driver has a bug during writing when
> there are multiple cards that are using different models of SiI chips in
> the
> system.
> I will be watching the list, although cc'ing me over email will be useful
> for speeding up replies.
> Longer version:
> I've been having problems with my Linux server corrupting data.  Not just a
> little - it can't copy a 700 meg ISO file and end up with the same checksum
> (and usually corrupts the filesystem in the process).
> Hardware:
> Asus A7N8X-Deluxe motherboard.  This has 2 parallel IDE connectors, each
> with a 40 gig IDE HD hanging off it, and 2 SATA connectors (driven by a SiI
> 3112 chip) with (right now) 1 300G SATA HD and 1 250G SATA HD.  All of

Sounds awfully similar to the recent nvidia data corruption issue.  It
was involving the IOMMU and one of the workarounds was not using IOMMU,
IIRC.  Please turn off IOMMU and see what happens.  You can turn IOMMU
off by passing "iommu=off" as kernel parameter.

-- 
tejun

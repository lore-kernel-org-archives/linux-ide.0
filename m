From: Tejun Heo <tj@kernel.org>
Subject: Re: Unexpected _GTF length (8)
Date: Sun, 22 Sep 2013 11:59:57 -0400
Message-ID: <20130922155957.GC28571@htj.dyndns.org>
References: <CAMeQTsby_CoGq1xAKUEVg_yWyqSSMjfSf6gWWzFRR+-znpPVbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:64270 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752061Ab3IVQAA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Sep 2013 12:00:00 -0400
Received: by mail-qc0-f171.google.com with SMTP id x19so1477723qcw.30
        for <linux-ide@vger.kernel.org>; Sun, 22 Sep 2013 08:59:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMeQTsby_CoGq1xAKUEVg_yWyqSSMjfSf6gWWzFRR+-znpPVbw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: linux-ide@vger.kernel.org

On Sun, Sep 22, 2013 at 03:56:35AM +0200, Patrik Jakobsson wrote:
> Where REGS_PER_GTF is defined as 7 which is correct according to ACPI specs.
> Since I'm getting a length of 8 I started digging in the ACPI code and found
> that the length is rounded up to acpi_size (u32 or u64 depending on arch). I
> cannot find any commits that recently touched this though I didn't really dig
> through it all.

It means your bios is buggy.

> I've disassembled the SSDT for the "SataAhci" and everything looks ok. That
> code returns a 56 bit buffer. I also tried calling the _GTF method manually
> which returned the following (padded to 8 bytes by the ACPI code ofc).
> 
> {0x10, 0x03, 0x00, 0x00, 0x00, 0xa0, 0xef, 0x00}
> 
> Doing a quick google search gives me a few of these _GTF length errors dating
> back to at least 2011. What's going on here? Is this a known error?

Failing to execute _GTF is usally fine to the point where I sometimes
wonder why we bother with it at all.  The above command is SET
FEATURES / Enable SATA Feature / DIPM, which enables device side link
powersaving and is a weird thing to do from _GTF anyway as host side
needs configuration too.  You can properly configure it using libata
link PM.

Thanks.

-- 
tejun

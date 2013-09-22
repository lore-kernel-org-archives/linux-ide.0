From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Subject: Unexpected _GTF length (8)
Date: Sun, 22 Sep 2013 03:56:35 +0200
Message-ID: <CAMeQTsby_CoGq1xAKUEVg_yWyqSSMjfSf6gWWzFRR+-znpPVbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:54938 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173Ab3IVB4g (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 21 Sep 2013 21:56:36 -0400
Received: by mail-lb0-f177.google.com with SMTP id w7so1652747lbi.8
        for <linux-ide@vger.kernel.org>; Sat, 21 Sep 2013 18:56:35 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: tj@kernel.org

Hi,

I've just got myself a MacBook Air 2013 and started looking at the dmesg output
for 3.12-rc1 where I found this:

ata1.00: unexpected _GTF length (8)

The condition in libata-acpi.c that triggers this is:

if (out_obj->buffer.length % REGS_PER_GTF)

Where REGS_PER_GTF is defined as 7 which is correct according to ACPI specs.
Since I'm getting a length of 8 I started digging in the ACPI code and found
that the length is rounded up to acpi_size (u32 or u64 depending on arch). I
cannot find any commits that recently touched this though I didn't really dig
through it all.

I've disassembled the SSDT for the "SataAhci" and everything looks ok. That
code returns a 56 bit buffer. I also tried calling the _GTF method manually
which returned the following (padded to 8 bytes by the ACPI code ofc).

{0x10, 0x03, 0x00, 0x00, 0x00, 0xa0, 0xef, 0x00}

Doing a quick google search gives me a few of these _GTF length errors dating
back to at least 2011. What's going on here? Is this a known error?

Thanks
Patrik Jakobsson

From: Tejun Heo <htejun@gmail.com>
Subject: Re: possibly a dumb question about sb600/700
Date: Mon, 12 Nov 2007 22:24:58 +0900
Message-ID: <4738542A.5050706@gmail.com>
References: <47381768.2060803@gmail.com> <20071112131640.3bf0073c@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:61007 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758376AbXKLNZI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Nov 2007 08:25:08 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1167061rvb
        for <linux-ide@vger.kernel.org>; Mon, 12 Nov 2007 05:25:08 -0800 (PST)
In-Reply-To: <20071112131640.3bf0073c@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: conke.hu@gmail.com, IDE/ATA development list <linux-ide@vger.kernel.org>

Alan Cox wrote:
> On Mon, 12 Nov 2007 18:05:44 +0900
> Tejun Heo <htejun@gmail.com> wrote:
> 
>> Hello,
>>
>> I've been looking at PATA support for sb600 and 700 and found something
>> weird.
>>
>> * IDE atiixp.c has a separate entry for sb600 such that it only probes
>> the first port but sb700 doesn't use the entry.  So, does sb600 has one
>> PATA channel but sb700 has two?
>>
>> * libata pata_atiixp.c doesn't have special handling for sb600's
>> single-channeldness.  Is this okay?
> 
> Should be just fine as I understand it all anyway - the second channel
> will have no resources assigned if absent which is handled by libata core
> already.

Alright, then.  I was just worried about the asymmetry.  Oh, this
_reminds me of another problem regarding enable bits.  There's a system
(wyse thin client) with pata_amd controller where the enable bit isn't
set by the BIOS and there's no reliable way to identify the system (no
DMI).  Do you know how important is the enabled bits test for these
controllers?

-- 
tejun

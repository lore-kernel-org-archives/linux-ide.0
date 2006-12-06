From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.19 2/3] sata_promise: new EH conversion
Date: Wed, 06 Dec 2006 18:19:18 +0900
Message-ID: <45768B16.5020603@gmail.com>
References: <200612060853.kB68r0Gg024641@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.234]:31837 "EHLO
	nz-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760365AbWLFJTZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Dec 2006 04:19:25 -0500
Received: by nz-out-0102.google.com with SMTP id s1so89063nze
        for <linux-ide@vger.kernel.org>; Wed, 06 Dec 2006 01:19:24 -0800 (PST)
In-Reply-To: <200612060853.kB68r0Gg024641@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
>> Don't freeze port unconditionally.  You'll end up hardresetting on every
>> error.  Just make sure DMA engine is stopped and the controller is in a
>> sane state.  If that fails, then, the port should be frozen.

Sorry, s/hardresetting/resetting/

> I'm looking into this now, but so far it seems only a reset
> (what Promise calls software reset, I don't know if libata
> considers it a soft or hard reset) of the ATA channel will do.

Errors properly reported by the device shouldn't cause resets.  Think
about ATAPI check condition.

>>> +	hardreset = NULL;
>>> +	if (sata_scr_valid(ap)) {
>>> +		ehc->i.action |= ATA_EH_HARDRESET;
>> Why always force HARDRESET?
> 
> I based that on sata_sil24:
> 
> 	if (sil24_init_port(ap)) {
> 		ata_eh_freeze_port(ap);
> 		ehc->i.action |= ATA_EH_HARDRESET;
> 	}
> 
> I interpreted the ATA_EH_HARDRESET as being required due to
> the ata_eh_freeze_port(), but perhaps it's only there because
> sil24_init_port() returned failure?

Yeap, that's right.

> A different issue, but of practical importance, is which
> libata branch I should base the EH conversion on: #upstream
> or #ALL? Andrew Morton's -mm kernels include the ALL patches,
> but they in turn include the promise-sata-pata patches, and
> there is a conflict between the PATA patch and the EH conversion.
> Currently my EH conversion is based on #upstream, and I've ported
> the PATA patch to apply on top of it.

#upstream, It is.  #ALL is merge of all libata-dev devel branches and no
development work occurs there directly.

Thanks.

-- 
tejun

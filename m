From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata NCQ blacklist entry
Date: Wed, 07 Nov 2007 21:55:57 +0900
Message-ID: <4731B5DD.1060203@gmail.com>
References: <20071107111813.GA9064@dudweiler.stuttgart.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:2863 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753574AbXKGM4E (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Nov 2007 07:56:04 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2042374rvb
        for <linux-ide@vger.kernel.org>; Wed, 07 Nov 2007 04:56:03 -0800 (PST)
In-Reply-To: <20071107111813.GA9064@dudweiler.stuttgart.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com, jeff@garzik.org, linux-kernel@vger.kernel.org
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Florian La Roche wrote:
> Hello all,
> 
> I've taking email addresses from the last NCQ blacklist changes going
> into the kernel.
> This Fujitsu drive also gives me spurious command completions. Detailed
> output also available at https://bugzilla.redhat.com/show_bug.cgi?id=366181.
> 
> Let me know if you need more info or anything else.
> 
> --- drivers/ata/libata-core.c
> +++ drivers/ata/libata-core.c
> @@ -4222,6 +4222,7 @@
>  	{ "WDC WD740ADFD-00NLR1", NULL,		ATA_HORKAGE_NONCQ, },
>  	{ "WDC WD3200AAJS-00RYA0", "12.01B01",	ATA_HORKAGE_NONCQ, },
>  	{ "FUJITSU MHV2080BH",	"00840028",	ATA_HORKAGE_NONCQ, },
> +	{ "FUJITSU MHW2160BJ G2",       NULL,           ATA_HORKAGE_NONCQ },
>  	{ "ST9120822AS",	"3.CLF",	ATA_HORKAGE_NONCQ, },
>  	{ "ST9160821AS",	"3.CLF",	ATA_HORKAGE_NONCQ, },
>  	{ "ST9160821AS",	"3.ALD",	ATA_HORKAGE_NONCQ, },

Thanks.  We're currently trying to find out what's actually going on
with all these drives.  At first, drives which got blacklisted aren't
many and made sense (had other problems with NCQ, etc..) but with new
generation drives from many vendors showing the same symptom, we aren't
too sure now.

I'll keep your email in my todo list and add the drive to the blacklist
once the problem is verified.

Thanks.

-- 
tejun

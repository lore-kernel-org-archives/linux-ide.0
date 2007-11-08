From: "Luca Tettamanti" <kronos.it@gmail.com>
Subject: Re: sata NCQ blacklist entry
Date: Thu, 8 Nov 2007 21:25:49 +0100
Message-ID: <68676e00711081225n6230538w30bf38d359ddd447@mail.gmail.com>
References: <20071107111813.GA9064@dudweiler.stuttgart.redhat.com>
	 <4731B5DD.1060203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.188]:26013 "EHLO
	rn-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761135AbXKHUZv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Nov 2007 15:25:51 -0500
Received: by rn-out-0102.google.com with SMTP id s46so455581rnb
        for <linux-ide@vger.kernel.org>; Thu, 08 Nov 2007 12:25:50 -0800 (PST)
In-Reply-To: <4731B5DD.1060203@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jeff@garzik.org, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>

On Nov 7, 2007 1:55 PM, Tejun Heo <htejun@gmail.com> wrote:
> Florian La Roche wrote:
> > Hello all,
> >
> > I've taking email addresses from the last NCQ blacklist changes going
> > into the kernel.
> > This Fujitsu drive also gives me spurious command completions. Detailed
> > output also available at https://bugzilla.redhat.com/show_bug.cgi?id=366181.
> >
> > Let me know if you need more info or anything else.
> >
> > --- drivers/ata/libata-core.c
> > +++ drivers/ata/libata-core.c
> > @@ -4222,6 +4222,7 @@
> >       { "WDC WD740ADFD-00NLR1", NULL,         ATA_HORKAGE_NONCQ, },
> >       { "WDC WD3200AAJS-00RYA0", "12.01B01",  ATA_HORKAGE_NONCQ, },
> >       { "FUJITSU MHV2080BH",  "00840028",     ATA_HORKAGE_NONCQ, },
> > +     { "FUJITSU MHW2160BJ G2",       NULL,           ATA_HORKAGE_NONCQ },
> >       { "ST9120822AS",        "3.CLF",        ATA_HORKAGE_NONCQ, },
> >       { "ST9160821AS",        "3.CLF",        ATA_HORKAGE_NONCQ, },
> >       { "ST9160821AS",        "3.ALD",        ATA_HORKAGE_NONCQ, },
>
> Thanks.  We're currently trying to find out what's actually going on
> with all these drives.  At first, drives which got blacklisted aren't
> many and made sense (had other problems with NCQ, etc..) but with new
> generation drives from many vendors showing the same symptom, we aren't
> too sure now.

Is there a way to tell whether Windows is using NCQ or not? I checked
the system log (or whatever it's called) on my notebook and is clean
but I'm not sure it's using NCQ (I don't even know if it'd log
spurious completions somewhere).

Luca

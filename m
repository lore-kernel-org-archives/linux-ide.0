From: "Grant Grundler" <grundler@google.com>
Subject: Re: [PATCH 12/12] sata_mv NCQ-EH for FIS-based switching
Date: Fri, 2 May 2008 09:54:29 -0700
Message-ID: <da824cf30805020954md3c3450qe22edff7f037994a@mail.gmail.com>
References: <481AAF84.40501@rtr.ca> <481AB0A1.3040009@rtr.ca>
	 <481AB0D2.3070103@rtr.ca> <481AB107.701@rtr.ca>
	 <481AB12A.3030102@rtr.ca> <481AB15D.5020201@rtr.ca>
	 <481AB189.3070705@rtr.ca> <481AB1B4.7050508@rtr.ca>
	 <481B0C9E.80008@rtr.ca>
	 <da824cf30805020952g73ce5eabqdd5cd769286a90a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:24634 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757426AbYEBQyi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 May 2008 12:54:38 -0400
Received: from zps78.corp.google.com (zps78.corp.google.com [172.25.146.78])
	by smtp-out.google.com with ESMTP id m42GsVCX027991
	for <linux-ide@vger.kernel.org>; Fri, 2 May 2008 17:54:32 +0100
Received: from rn-out-0910.google.com (rnei50.prod.google.com [10.38.160.50])
	by zps78.corp.google.com with ESMTP id m42GsUm1008487
	for <linux-ide@vger.kernel.org>; Fri, 2 May 2008 09:54:30 -0700
Received: by rn-out-0910.google.com with SMTP id i50so706994rne.11
        for <linux-ide@vger.kernel.org>; Fri, 02 May 2008 09:54:29 -0700 (PDT)
In-Reply-To: <da824cf30805020952g73ce5eabqdd5cd769286a90a6@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@redhat.com>

On Fri, May 2, 2008 at 9:52 AM, Grant Grundler <grundler@google.com> wrote:
...
>  >  I grepped for one, but didn't find one.
>
>  include/asm-ia64/bitops.h:hweight64()
>
>  grundler <2186>fgrep hweight include/asm/*
>  include/asm/bitops_32.h:#include <asm-generic/bitops/hweight.h>
>  include/asm/bitops_64.h:#include <asm-generic/bitops/hweight.h>

Sorry - forgot to include this part:

grundler <2189>fgrep hweight64 lib/*
Binary file lib/bitmap.o matches
Binary file lib/built-in.o matches
lib/hweight.c:unsigned long hweight64(__u64 w)
lib/hweight.c:EXPORT_SYMBOL(hweight64);
Binary file lib/hweight.o matches

thanks,
grant

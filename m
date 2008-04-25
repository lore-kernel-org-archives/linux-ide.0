From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata-eh/pmp command sequence on NCQ media error
Date: Sat, 26 Apr 2008 01:10:17 +0900
Message-ID: <48120269.8020101@gmail.com>
References: <480F9D29.4070603@rtr.ca> <480FF229.2060808@rtr.ca> <481168FA.5020709@pobox.com> <4811E2FB.4040100@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:58024 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757440AbYDYQK0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Apr 2008 12:10:26 -0400
Received: by wf-out-1314.google.com with SMTP id 28so2962941wff.4
        for <linux-ide@vger.kernel.org>; Fri, 25 Apr 2008 09:10:26 -0700 (PDT)
In-Reply-To: <4811E2FB.4040100@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Tejun,
> 
> During testing of my internal version of sata_mv.c here,
> I noticed the following:
> 
> With no port-multiplier attached, a media error during NCQ
> results in an immediate READ_LOG_EXT_10H to retrieve the
> task file for the failed I/O.
> 
> With a port-multiplier, there is instead a flurry of sata_pmp_read()
> attempts.  I'm guessing that the READ_LOG_EXT_10H would normally
> then follow those ?
> 
> The problem is, on most of the Marvell chips, non-data commands
> cannot succeed after any kind of error (until after the port is reset),
> so they fail, and we never then get to the READ_LOG_EXT_10H stage.
> Oddly, the READ_LOG_EXT_10H command itself is okay (with some errata
> goodness tossed in).
> 
> So, for sata_mv at least, I'd kinda like to have libata-eh attempt
> the READ_LOG_EXT_10H before it tries to (unsuccessfully) access the
> per-port SCRs on the PMP.
> 
> For now, I'll try and hack something into my local tree to ensure
> that things will actually work that way around without any other
> unforseen complications.
> 
> But for upstream, I'm thinking maybe a HORKAGE flag or something?
> I'm still trying to avoid having to pull a lot of libata-eh/pmp code
> into sata_mv for local customizations.

w00t w00t I thought about that when I wrote NCQ EH.  All you have to do 
is to export ata_eh_analyze_ncq_error() can call it right after 
error_handler starts and put the controller into a working state (so 
that SCR accesses work again).  After it finishes, call the generic 
handler.  The second time around ata_eh_analyze_ncq_error() will be 
no-op and you should get what you want.

-- 
tejun

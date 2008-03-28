From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET #upstream] libata: improve FLUSH error handling
Date: Fri, 28 Mar 2008 23:52:15 +0900
Message-ID: <47ED061F.2070701@gmail.com>
References: <12066128663306-git-send-email-htejun@gmail.com> <47EBAE2B.8070102@rtr.ca> <47EBB09F.9070607@rtr.ca> <47EC5079.5020105@gmail.com> <47EC58F6.3070601@rtr.ca> <47ECF47A.2040508@emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.191]:59865 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753476AbYC1O7B (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Mar 2008 10:59:01 -0400
Received: by rn-out-0910.google.com with SMTP id e24so133010rng.1
        for <linux-ide@vger.kernel.org>; Fri, 28 Mar 2008 07:59:00 -0700 (PDT)
In-Reply-To: <47ECF47A.2040508@emc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ric@emc.com
Cc: Mark Lord <liml@rtr.ca>, jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Ric Wheeler wrote:
> I think that is a really important knob to have. Not just for RAID
> systems, but we use the FLUSH_CACHE on systems without barriers mainly
> when we power down & do the unmounts, etc.
> 
> If you hit a bad block during power down of a laptop, I can image that
> have a worst case of (30?) seconds is infinitely better than multiple
> minutes ;-)

Fully finishing FLUSH CACHE requires command repetition.  Not fully
finishing FLUSH CACHE on shutdown means sure data loss.  Given that
FLUSH CACHE failure is very rare and it's repeatedly retried if and only
if the device actively indicates failure, I'm not too sure.  Also note
that if FLUSH CACHE fails, you cannot even trust the FS journal.  Things
can get silently corrupt.

-- 
tejun

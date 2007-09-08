From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] Asynchronous scan support for libata
Date: Sat, 08 Sep 2007 19:40:27 +0200
Message-ID: <46E2DE8B.5040708@gmail.com>
References: <20070906210505.GF27404@parisc-linux.org> <46E258F3.20805@gmail.com> <20070908171917.GC6809@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:44701 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754281AbXIHRmJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Sep 2007 13:42:09 -0400
Received: by wa-out-1112.google.com with SMTP id v27so948063wah
        for <linux-ide@vger.kernel.org>; Sat, 08 Sep 2007 10:42:08 -0700 (PDT)
In-Reply-To: <20070908171917.GC6809@parisc-linux.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Matthew Wilcox wrote:
> On Sat, Sep 08, 2007 at 05:10:27PM +0900, Tejun Heo wrote:
>> I think it's generally okay although it would need to spend quite some
>> time in -mm and we'll need to exclude several drivers which require
>> host-wide silence for mode programming (the current code is buggy but
>> sequential probing hides it pretty well) till host-wide exclusion is
>> implemented.
> 
> Can you tell me a bit more about these drivers?  Would it be possible to
> convert them to one host/many channels, which would give us the exclusion
> we want?

IIRC, sata_promise is of this type and there probably are a few old PATA
ones.  Ports on the host are mostly independent.  There's no need for
cross-port synchronization for most of the time but configuring transfer
mode requires host-wide quiescence.  Currently, the planned way to fix
the problem is to implement host-wide exclusion mechanism in the error
handler (summon EH of all other threads and wait till all of them are
parked) and it's on top of the TODO list, so I don't think it will take
too long.

Thanks.

-- 
tejun

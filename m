From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH RFC] sata_promise: make pdc_atapi_pkt() use values from
 qc->tf
Date: Mon, 03 Dec 2007 13:49:36 +0900
Message-ID: <47538AE0.10309@gmail.com>
References: <200712021706.lB2H6GJd025895@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.185]:35990 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204AbXLCEto (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Dec 2007 23:49:44 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2535203rvb
        for <linux-ide@vger.kernel.org>; Sun, 02 Dec 2007 20:49:44 -0800 (PST)
In-Reply-To: <200712021706.lB2H6GJd025895@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

Mikael Pettersson wrote:
>> what was the outcome of this discussion?
>>
>> I haven't looked over the Promise datasheet nor checked my brain for 
>> details, hoping Mikael would do that for me ;-)
> 
> I've now tested this on top of 2.6.24-rc3, with no observable
> regressions. Blanking, writing, and mounting/reading CD-RWs
> on both SATAPI and PATAPI works (tested on a 300 TX2plus card).
> 
> I can't find anything in Promise's public docs or reference driver
> about non-standard requirements on lbam/lbah in ATAPI packets.

The values set by core layer should be good enough.  The only thing I'm
worried about is setting transfer chunk size when protocol is DMA.  As
setting this value hasn't caused any problem for other controllers and
it seems sata_promise doesn't seem to have problem with it either, I'm
leaning toward keeping this value but if setting this value to zero is
the right thing to do, we can definitely change that in the core layer.
 One way or the other, I'd really like to keep sata_promise's behavior
in line with other libata drivers.

So, Mikael, do you think it would be okay to include the patch for
#upstream and see how it works in -mm?

Thanks.

-- 
tejun

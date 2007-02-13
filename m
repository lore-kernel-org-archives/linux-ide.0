From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata FUA revisited
Date: Tue, 13 Feb 2007 07:20:13 -0800
Message-ID: <45D1D72D.9020509@gmail.com>
References: <fa.S80SRyQbD/hm4SxliPUKU88BaCo@ifi.uio.no> <fa.Q/csgyCHkAsD84yi+bN78H1WNNM@ifi.uio.no> <45D104F3.7040602@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.235]:58826 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbXBMPVN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Feb 2007 10:21:13 -0500
Received: by nz-out-0506.google.com with SMTP id s1so2018928nze
        for <linux-ide@vger.kernel.org>; Tue, 13 Feb 2007 07:21:12 -0800 (PST)
In-Reply-To: <45D104F3.7040602@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, edmudama@gmail.com, Nicolas.Mailhot@LaPoste.net

Hello, Robert.

Robert Hancock wrote:
[--snip--]
> On the NCQ side, I think it's pretty safe to assume that all controllers 
> will handle it. Obviously I've verified it with sata_nv (at least that 
> it doesn't blow up obviously), and the other two NCQ drivers we have, 
> ahci and sata_sil24 just feed raw FIS data into the controller so there 
> should be no issue with not supporting it.

FWIW, ICH6/7/8 ahci's clear PMP field when transmitting FIS.  The reason 
why I'm hesitant is because there is no way to tell whether the FUA bit 
got honored or ignored.  With extra opcode, it's okay because barrier 
explicitly fails but if NCQ FUA is not supported, it will succeed 
silently as normal write.  Everything will be okay generally but the 
barrier is done incorrectly and on a really bad day it will lead to 
journal corruption.

So, actually, I was thinking about *always* using the non-NCQ FUA 
opcode.  As currently implemented, FUA request is always issued by 
itself, so NCQ doesn't make any difference there.  So, I think it would 
be better to turn on FUA on driver-by-driver basis whether the 
controller supports NCQ or not.

Well, I might be being too paranoid but silent FUA failure would be 
really hard to diagnose if that ever happens (and I'm fairly certain 
that it will on some firmwares).

-- 
tejun

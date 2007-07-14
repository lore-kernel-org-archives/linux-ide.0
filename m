From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] Unbreak build of PMP with ACPI disabled
Date: Sat, 14 Jul 2007 11:31:09 +0900
Message-ID: <4698356D.60605@gmail.com>
References: <20070713065600.GB8320@vana.vc.cvut.cz> <46972519.80703@gmail.com> <46980AFD.3000503@shaw.ca> <6.2.0.14.2.20070713175627.031aada0@linux.sysreset.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:3035 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759170AbXGNCbQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Jul 2007 22:31:16 -0400
Received: by py-out-1112.google.com with SMTP id d32so1130816pye
        for <linux-ide@vger.kernel.org>; Fri, 13 Jul 2007 19:31:15 -0700 (PDT)
In-Reply-To: <6.2.0.14.2.20070713175627.031aada0@linux.sysreset.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ryan Power <rpower@sysreset.com>
Cc: Robert Hancock <hancockr@shaw.ca>, Petr Vandrovec <petr@vandrovec.name>, linux-ide@vger.kernel.org

Ryan Power wrote:
> I'm also experiencing this problem on a with the sata_nv module.  I
> suspect that it may at least not be controller dependant, as it's also
> occurring on my silicon image controller (sata_sil, SiI3512).  It looks
> like something is zeroing out part of the return registers for the
> overall smart status.
> 
> Tested with Maxtor 6L300S0 and Western Digital WD3200JS drives on both
> the sil and nv controllers.  This was working in 2.6.21.6, but I haven't
> had a chance to try and isolate the problem any further.

Hmmm... Incidentally, Jeff told me yesterday he was seeing the same
problem on sil.  Maybe it's something in the core.  I'll investigate.

Thanks.

-- 
tejun

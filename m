From: Tejun Heo <htejun@gmail.com>
Subject: Re: Linux AHCI still broken with ICH8
Date: Fri, 01 Dec 2006 09:42:30 +0900
Message-ID: <456F7A76.4050009@gmail.com>
References: <20061130191153.GA26351@mail.majes.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:17857 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1031654AbWLAAmj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 30 Nov 2006 19:42:39 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2286164uga
        for <linux-ide@vger.kernel.org>; Thu, 30 Nov 2006 16:42:38 -0800 (PST)
In-Reply-To: <20061130191153.GA26351@mail.majes.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mathias Jeschke <jeschke@informatik.hu-berlin.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

[cc'ing linux-ide and Jeff]

Mathias Jeschke wrote:
> Hello Tejun,
> 
> I've tested the kernel release of 2.6.19 and noticed,
> that the AHCI drivers is still broken and detects
> only 2 of 4 ports from my ASUS P5B (ICH8).
> 
> Do you have any news about the AHCI driver?

We have the fix merged in libata devel tree.  Jeff, I think this should
go into stable tree.  ICH8 is very popular these days and the patch
doesn't affect other chipsets.

-- 
tejun

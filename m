From: Tejun Heo <htejun@gmail.com>
Subject: Re: excess timeouts accessing pci-sata card both ports
Date: Sat, 02 Feb 2008 14:11:43 +0900
Message-ID: <47A3FB8F.4060103@gmail.com>
References: 00801240919.2173@centrum.cz> <200801240919.2173@centrum.cz> <200801242359.10655@centrum.cz> <200801250037.4195@centrum.cz> <200801250055.9430@centrum.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1250
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:62818 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932129AbYBBFLw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 Feb 2008 00:11:52 -0500
Received: by rv-out-0910.google.com with SMTP id k20so966753rvb.1
        for <linux-ide@vger.kernel.org>; Fri, 01 Feb 2008 21:11:51 -0800 (PST)
In-Reply-To: <200801250055.9430@centrum.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: drtyc@centrum.cz
Cc: linux-ide@vger.kernel.org

drtyc@centrum.cz wrote:
> Removed 3 drives. Both data and power.
> Left only port1 connected
> It's the drive and power cable that in the first test was port2 failing
> and in second test was port1 and ok
> both cards plugged in and initialized.
> third test it's the port1 alone sda working ok
> fourth test it's the port2 alone sda failing.
> 
> any idea what's wrong as this does not seem to be power related problem.
> 
> vanilla 2.6.23.14
> sata_via module... details in the inlined emails.
> 
> (4th test config)
> ata1: SATA link down (SStatus 0 SControl 310)
> ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> ata4: SATA link down (SStatus 0 SControl 310)
> ata5: SATA link down (SStatus 0 SControl 310)
> 
> Faulty card? Both cards? Driver bug? Or design bug/incompatibility on second port?

It seems like you're experiencing transmission problems on reads.
SError value of 0x3000400 is Protocol Error, Link Sequence Error and
Transport State Transition Error.  Hardresetting the link should usually
recover from such conditions but error handling on via has never been
reliable.  How easily can you trigger the problem?

Thanks.

-- 
tejun

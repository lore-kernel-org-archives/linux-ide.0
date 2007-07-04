From: 7091@blargh.com
Subject: Re: sata_sil, writing bug with multiple cards?
Date: Tue, 03 Jul 2007 18:40:56 -0700
Message-ID: <courier.468AFAA8.00000F2D@blargh.com>
References: <courier.4689EFD9.0000589A@blargh.com>
            <468A0E24.7020000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from blargh.com ([24.234.115.147]:48194 "EHLO blargh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754293AbXGDBk5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Jul 2007 21:40:57 -0400
In-Reply-To: <468A0E24.7020000@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: 7091@blargh.com, linux-ide@vger.kernel.org, jgarzik@pobox.com

Tejun Heo writes: 

> Sounds awfully similar to the recent nvidia data corruption issue.  It
> was involving the IOMMU and one of the workarounds was not using IOMMU,
> IIRC.  Please turn off IOMMU and see what happens.  You can turn IOMMU
> off by passing "iommu=off" as kernel parameter. 
> 
> -- 
> tejun

That indeed seems to have fixed the problem - I've been pulling my hair out 
forever about this! 

Is this something I'll need to leave in forever, is it supposed to get 
fixed, etc.? 

I'm going to continue doing testing and really try to thrash it tonight (I 
just did the 'copy an ISO 5 times' test that always failed before - it 
succeeds now). 

Thanks for the help.

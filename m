From: "J. Ryan Earl" <heretic@clanhk.org>
Subject: Re: libata and md issues with 2.9.1-rc1
Date: Tue, 24 Aug 2004 17:31:32 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <412BC1C4.2060506@clanhk.org>
References: <412B79DF.2000705@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:8403 "EHLO
	ms-smtp-01-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S268995AbUHXWbf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 Aug 2004 18:31:35 -0400
In-Reply-To: <412B79DF.2000705@wasp.net.au>
List-Id: linux-ide@vger.kernel.org
To: Brad Campbell <brad@wasp.net.au>
Cc: linux-ide@vger.kernel.org, RAID Linux <linux-raid@vger.kernel.org>

Brad Campbell wrote:

> Just a heads up. I'm experiencing "issues" with 2.6.9-rc1 that don't 
> occur with 2.6.5.
>
> I run a 10 disk raid-5 on 3xPromise SATA150 cards and a 2 disk raid-0 
> on the on-board VIA chipset.
> The 10 disks are Maxtor Maxline-II SATA drives and the raid-0 is a 
> pair of WD2000JB drives with
> Addonics SATA->PATA converters. 

Did you try RAID-0 with the pair of Western Digital drives on the two 
free Promise slots?  If that fails similarly, it might not be a libata 
issue.

-ryan

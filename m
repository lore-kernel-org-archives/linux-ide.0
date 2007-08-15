From: Tejun Heo <htejun@gmail.com>
Subject: Re: Still having problems with sata_promise on all late kernels
Date: Wed, 15 Aug 2007 16:54:52 +0900
Message-ID: <46C2B14C.5020004@gmail.com>
References: <46C11BBE.6010802@wasp.net.au> <46C181FD.8040708@gmail.com> <46C1B3B5.1090303@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:26584 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612AbXHOHzK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Aug 2007 03:55:10 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1661963rvb
        for <linux-ide@vger.kernel.org>; Wed, 15 Aug 2007 00:55:10 -0700 (PDT)
In-Reply-To: <46C1B3B5.1090303@wasp.net.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brad Campbell <brad@wasp.net.au>
Cc: linux-ide@vger.kernel.org, Mikael Pettersson <mikpe@it.uu.se>

[cc'ing Mikael Pettersson]

Brad Campbell wrote:
> Tejun Heo wrote:
> 
>> ATA bus error is a strong indicator for hardware problem.  Please get a
>> separate power supply (doesn't have to be an expensive one), power it up
>> [1], and connect some of the drives to the power supply and see whether
>> errors persist on those drives.
>>
> 
> 2 separate tests with the 2 troublesome drives, each time with both
> drives on a different power supply unit. Also tried new cables from a
> different manufacturer.
> 
> It ain't the cables and it ain't the power.

I see.  Thanks.  I'm pretty much out of ideas at this point.  Mikael?

-- 
tejun

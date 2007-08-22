From: Tejun Heo <htejun@gmail.com>
Subject: Re: Resets on sil3124 & sil3726 PMP
Date: Wed, 22 Aug 2007 14:43:52 +0900
Message-ID: <46CBCD18.7070507@gmail.com>
References: <EA70552E-75C2-451D-BF58-A73482FBB14D@infogears.com> <46C5E3A6.9020907@gmail.com> <DFEB0E31-D017-4527-85A4-8D18D379CB0B@infogears.com> <98147300-A282-4909-A393-079365833BD8@infogears.com> <46CBA78D.2070405@gmail.com> <F3FDFA8B-A2EF-4EEE-ACE2-E67776650CF4@infogears.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:2377 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753836AbXHVFn7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Aug 2007 01:43:59 -0400
Received: by rv-out-0910.google.com with SMTP id k20so59912rvb
        for <linux-ide@vger.kernel.org>; Tue, 21 Aug 2007 22:43:59 -0700 (PDT)
In-Reply-To: <F3FDFA8B-A2EF-4EEE-ACE2-E67776650CF4@infogears.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rusty Conover <rconover@infogears.com>
Cc: linux-ide@vger.kernel.org

Rusty Conover wrote:
> Putting just one hard disk into the PMP slots, works great all by
> itself. I created an ext3 fs on it, used dd to dump lots of data to it,
> no problems in all of my testing.

Hmmmm..

> One hard disk in a PMP slot and another hard disk in a native slot on a
> different SATA port work great together.

Okay.

> Two hard disks in the same PMP slot range (slots 1-2), timeout right away.
> 
> Could it be a problem with timing the PMP requests?

Very unlikely.

> I've tested this on a second separate machine and I'm seeing the same
> timeout errors.

Can you try different combinations (e.g. use different slots of the same
 PMP, use the slots from the other PMP)?  I still think it's some sort
of hardware issue.

-- 
tejun

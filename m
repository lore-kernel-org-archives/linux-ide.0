From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil, writing bug with multiple cards?
Date: Wed, 04 Jul 2007 17:52:13 +0900
Message-ID: <468B5FBD.3040104@gmail.com>
References: <courier.4689EFD9.0000589A@blargh.com> <200707040908.21512.ak@suse.de> <courier.468B579E.00002ECF@blargh.com> <200707041038.57677.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:17119 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757409AbXGDIwU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Jul 2007 04:52:20 -0400
Received: by wa-out-1112.google.com with SMTP id v27so3170291wah
        for <linux-ide@vger.kernel.org>; Wed, 04 Jul 2007 01:52:19 -0700 (PDT)
In-Reply-To: <200707041038.57677.ak@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: 7091@blargh.com, linux-ide@vger.kernel.org, jgarzik@pobox.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Andi Kleen wrote:
> On Wednesday 04 July 2007 10:17:34 7091@blargh.com wrote:
> 
>>> Most likely it is some sort of hardware bug that we might
>>> not be able to do much about. Have you tried contacting SIL or VIA? 
>> No, I haven't.  Like I mentioned above, the OpenBSD drivers seemed to work, 
>> or at least did with similar tests.  I would need to run the more extensive 
>> checks to be positive, but those take a lot of time, obviously.  And 
>> downtime for the box, a lot of which isn't really manageable, at the moment. 
> 
> Perhaps the OpenBSD drivers program the SIL chip in a different way
> that avoids this problem. 
> 
>>> e.g. if you have some other system with a different chipset it might
>>> be useful to test the SIL controllers in those.
>> The previous motherboard was an AMD 760 chipset, and it had the same 
>> problem. 
> 
> Ok this means it's likely a SIL issue, not a chipset issue.

Hmmmm... okay.  I'll take look at the openBSD driver.  I still have no
idea what it can be tho.  Maybe, FIFO setup?

Thanks.

-- 
tejun

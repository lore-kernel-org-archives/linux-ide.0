From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] sata_svw: 0x0241 has 8 ports not 4
Date: Thu, 10 Apr 2008 10:46:06 +0900
Message-ID: <47FD715E.30808@gmail.com>
References: <47FD6574.8020202@gmail.com> <1207790498.12357.25.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.235]:10299 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268AbYDJBqZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Apr 2008 21:46:25 -0400
Received: by wx-out-0506.google.com with SMTP id h31so2873992wxd.4
        for <linux-ide@vger.kernel.org>; Wed, 09 Apr 2008 18:46:24 -0700 (PDT)
In-Reply-To: <1207790498.12357.25.camel@pasglop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: benh@kernel.crashing.org
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, y_honda_@d1.dion.ne.jp

Benjamin Herrenschmidt wrote:
> On Thu, 2008-04-10 at 09:55 +0900, Tejun Heo wrote:
>> From: Yohei Honda <y_honda_@d1.dion.ne.jp>
>>
>> 0x0241 has 8 ports not 4.
>>
>> Reported by Yohei Honda on kernel bz 10424.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> ---
>> Benjamin, can you please verify this is correct?
> 
> I can't as I don't have any spec for these... All I can say is that the
> Apple one has 4 ports and is is 0x0240.
> 
> So If you are reasonably confident the 0x0241 has 8, then feel free to
> apply the patch.

Hmmm.. Honda apparently has the hardware and this change works for him. 
  I think that should be good enough.  Jeff, can you please merge this?

Thanks.

-- 
tejun

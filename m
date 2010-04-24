From: Tejun Heo <tj@kernel.org>
Subject: Re: Working around bogus HPAs in libata
Date: Sat, 24 Apr 2010 07:35:03 +0200
Message-ID: <4BD28307.3090003@kernel.org>
References: <1269192318.18314.218.camel@localhost>	 <4BB5637E.4050604@kernel.org> <1270245450.12516.187.camel@localhost>	 <4BBA95F8.7070909@kernel.org> <1270520930.24287.102.camel@localhost>	 <4BBA9D83.2040909@kernel.org> <1272075995.11697.41.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55175 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752050Ab0DXFfp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 24 Apr 2010 01:35:45 -0400
In-Reply-To: <1272075995.11697.41.camel@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ben Hutchings <ben@decadent.org.uk>
Cc: linux-ide@vger.kernel.org, debian-kernel@lists.debian.org

Hello,

On 04/24/2010 04:26 AM, Ben Hutchings wrote:
>> The patch I posted is rolled up version which contained currently
>> pending HPA unlock on shrink patch.
>>
>>   http://article.gmane.org/gmane.linux.ide/45662
> 
> It sounds like that should go to stable as well.

I think it's a bit too pervasive for -stable inclusion.  The number of
affected systems is very low after all.

>> Multiple messages are probably sd doing revalidation of the device.  I
>> don't think it will cause any problem but I'll look into it later
>> today and let you know.
> 
> What did you find?

Nothing yet.  I just moved and my stuff are still in transit, so I
couldn't test anything.  I'll get to it once my things arrive (they're
expected to next week).

Thanks.

-- 
tejun

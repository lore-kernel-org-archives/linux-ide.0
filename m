From: Tejun Heo <tj@kernel.org>
Subject: Re: Problems with >3 drives on an eSATA portmultiplier
Date: Thu, 02 Apr 2009 09:28:46 +0900
Message-ID: <49D406BE.3080103@kernel.org>
References: <Pine.LNX.4.63.0904011454020.3947@buttercup.gerph.org>	 <da824cf30904010945i5a33f049v15745c79293d22ad@mail.gmail.com>	 <Pine.LNX.4.63.0904011801160.3947@buttercup.gerph.org> <da824cf30904011046x46da9b69u28f00472a49ebc20@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58813 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753888AbZDBA25 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Apr 2009 20:28:57 -0400
In-Reply-To: <da824cf30904011046x46da9b69u28f00472a49ebc20@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: Justin Fletcher <gerph@gerph.org>, linux-ide@vger.kernel.org

Grant Grundler wrote:
>> I could drop down to 2.6.26 and rebuild my kernel with support for that
>> controller - I hadn't done this before because I cannot then use my DVB-S
>> card, but... I could live without that for the test.
> 
> If someone could comment on  2.6.28 or 2.6.29, you could avoid running
> this test.

Hmmm... I don't really remember changing much, so it should be fine.
Can you please give a shot at 2.6.26 anyway?  Also, kernel logs with
JMB controller would be helpful too as ahci tends to better show what's
really going on and failing during reset.

>> I've replaced the PSU once already - it was replaced on 6th Feb, with a
>> Sumvision 450W 20+4pin SATA PSU. Those 5 drives + the bridge board and fan
>> are the only things being powered by that PSU. I should have thought that
>> even during drive initialisation 5 drives wouldn't exceed 450W. Anyhow, this
>> was one of my first thoughts. I could get another PSU (I think I might be
>> able to find one around here), but having replaced it so recently, I'm
>> uncomfortable doing so.
>>
>> Is a 450W PSU going to be able to supply enough power for those drives ?
> 
> It's not just about how many watts. Both 12v and 5v "rails" need to
> provide enough power.  But if this worked before, I would assume the
> replacement is working too.
> 
> And in general, yes, a 450W should be plenty for 5 drives plus PMP
> board. Especially if the OS is "staggering" the spinup so only one
> or two drives are spinning up at the same time.  I know I've had to
> fix "staggered spinup" in the past (2.6.18) but don't recall if it's
> fixed in current 2.6.28 or .29 kernels.

libata never had proper provision for staggered spin up.  If it works,
it's just because they're being probed sequentially.  :-)

Anyways, 3132 + 3726 should work.  Both 3726 and 4726 pretty much
require its first port to be always occupied (or it's fake config
drive jumps arounds and freaks out) and hotplug is often flaky but
other than that it should generally work.

Thanks.

-- 
tejun

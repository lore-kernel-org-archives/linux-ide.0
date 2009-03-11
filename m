From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: Keep shadow last_ctl up to date during resets
Date: Wed, 11 Mar 2009 22:11:22 +0900
Message-ID: <49B7B87A.1020107@kernel.org>
References: <49B65125.7030201@st.com> <49B76B81.9000407@kernel.org> <49B7AE6E.4010704@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:38507 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753132AbZCKNMI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Mar 2009 09:12:08 -0400
In-Reply-To: <49B7AE6E.4010704@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Stuart MENEFY <stuart.menefy@st.com>, linux-ide@vger.kernel.org

Mark Lord wrote:
> Tejun Heo wrote:
>> Hello,
>>
>> Stuart MENEFY wrote:
>>> libata keeps a shadow copy of the ATA CTL register (which is write
>>> only),
>>> and only writes to the hardware when the required value doesn't match
>>> the shadow. However this copy wasn't being maintained when performing
>>> reset functions. This could cause problems for the first operation after
>>> a reset when the correct value might not be written to the CTL register.
>>>
>>> This problem was observed when hotplugging a drive: the identify command
>>> was being issued with interrupts enabled, when they should have been
>>> disabled.
>>>
>>> Signed-off-by: Stuart Menefy <stuart.menefy@st.com>
>>
>> Nice catch.  Maybe a nice addition would be a ata_sff_write_to_ctl()
>> or something which always does the right thing.
>>
>> Acked-by: Tejun Heo <tj@kernel.org>
> ..
> 
> Mmm.. I wonder if this is severe enough to warrant backporting
> to -stable for the past couple of releases?

Yeah, I think it can be responsible for at least some of runaway IRQs
during detection on ata_piix and is likely to be a good candidate for
-stable but I think it would be better to see how it does on -rc first
for a while before pushing this -stable.  sata_nv breakages very well
showed how messed up things can get with obvious fixes.  :-)

Thanks.

-- 
tejun

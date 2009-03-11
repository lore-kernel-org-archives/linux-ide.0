From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata: Keep shadow last_ctl up to date during resets
Date: Wed, 11 Mar 2009 08:28:30 -0400
Message-ID: <49B7AE6E.4010704@rtr.ca>
References: <49B65125.7030201@st.com> <49B76B81.9000407@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:57675 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754806AbZCKM2e (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Mar 2009 08:28:34 -0400
In-Reply-To: <49B76B81.9000407@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Stuart MENEFY <stuart.menefy@st.com>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Hello,
> 
> Stuart MENEFY wrote:
>> libata keeps a shadow copy of the ATA CTL register (which is write only),
>> and only writes to the hardware when the required value doesn't match
>> the shadow. However this copy wasn't being maintained when performing
>> reset functions. This could cause problems for the first operation after
>> a reset when the correct value might not be written to the CTL register.
>>
>> This problem was observed when hotplugging a drive: the identify command
>> was being issued with interrupts enabled, when they should have been
>> disabled.
>>
>> Signed-off-by: Stuart Menefy <stuart.menefy@st.com>
> 
> Nice catch.  Maybe a nice addition would be a ata_sff_write_to_ctl()
> or something which always does the right thing.
> 
> Acked-by: Tejun Heo <tj@kernel.org>
..

Mmm.. I wonder if this is severe enough to warrant backporting
to -stable for the past couple of releases? 


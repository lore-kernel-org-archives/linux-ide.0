From: Tejun Heo <tj@kernel.org>
Subject: Re: libata: Fix a potential race condition in ata_scsi_park_show()
Date: Fri, 31 Oct 2008 11:26:42 +0900
Message-ID: <490A6CE2.6080706@kernel.org>
References: <87prmgzohf.fsf@denkblock.local> <48E7CF64.4050206@kernel.org> <87r65x225w.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:52498 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752607AbYJaC06 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 30 Oct 2008 22:26:58 -0400
In-Reply-To: <87r65x225w.fsf@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Elias Oltmanns wrote:
> Tejun Heo <tj@kernel.org> wrote:
>> Elias Oltmanns wrote:
>>> Peter Moulder has pointed out that there is a slight chance that a
>>> negative value might be passed to jiffies_to_msecs() in
>>> ata_scsi_park_show(). This is fixed by saving the value of jiffies in a
>>> local variable, thus also reducing code since the volatile variable
>>> jiffies is accessed only once.
>>>
>>> Signed-off-by: Elias Oltmanns <eo@nebensachen.de>
>> added to #tj-upstream.  Thanks.
> 
> Has this branch been pulled in yet? My patch, for one, is not even in
> linux-next even though it had been intended for 2.6.28 at the time.

Jeff, have you pulled it or taken patches from it?

Thanks.

-- 
tejun

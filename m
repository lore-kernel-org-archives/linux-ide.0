From: Tejun Heo <tj@kernel.org>
Subject: Re: libata: Fix a potential race condition in ata_scsi_park_show()
Date: Mon, 03 Nov 2008 18:54:31 +0900
Message-ID: <490ECA57.8040209@kernel.org>
References: <87prmgzohf.fsf@denkblock.local> <48E7CF64.4050206@kernel.org> <87r65x225w.fsf@denkblock.local> <490A6CE2.6080706@kernel.org> <490A9A57.5040001@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56882 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754653AbYKCJys (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Nov 2008 04:54:48 -0500
In-Reply-To: <490A9A57.5040001@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Elias Oltmanns <eo@nebensachen.de>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Elias Oltmanns wrote:
>>> Tejun Heo <tj@kernel.org> wrote:
>>>> Elias Oltmanns wrote:
>>>>> Peter Moulder has pointed out that there is a slight chance that a
>>>>> negative value might be passed to jiffies_to_msecs() in
>>>>> ata_scsi_park_show(). This is fixed by saving the value of jiffies
>>>>> in a
>>>>> local variable, thus also reducing code since the volatile variable
>>>>> jiffies is accessed only once.
>>>>>
>>>>> Signed-off-by: Elias Oltmanns <eo@nebensachen.de>
>>>> added to #tj-upstream.  Thanks.
>>> Has this branch been pulled in yet? My patch, for one, is not even in
>>> linux-next even though it had been intended for 2.6.28 at the time.
>>
>> Jeff, have you pulled it or taken patches from it?
>>
>> Thanks.
> 
> I sent an email a couple days ago, asking what was pending (or thought I
> did...).  I haven't pulled from #tj-upstream but I ack'd a big patchset
> that I assume is included in there.

Eh... those are different ones.  #tj-upstream contained patches
scheduled for 2.6.28 (mostly fixes and stuff which were around for quite
some time).  I'll resend the patchset.

Thanks.

-- 
tejun

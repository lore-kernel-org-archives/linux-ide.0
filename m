From: Jeff Garzik <jeff@garzik.org>
Subject: Re: libata: Fix a potential race condition in ata_scsi_park_show()
Date: Fri, 31 Oct 2008 01:40:39 -0400
Message-ID: <490A9A57.5040001@garzik.org>
References: <87prmgzohf.fsf@denkblock.local> <48E7CF64.4050206@kernel.org> <87r65x225w.fsf@denkblock.local> <490A6CE2.6080706@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:34280 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750800AbYJaFkr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 31 Oct 2008 01:40:47 -0400
In-Reply-To: <490A6CE2.6080706@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Elias Oltmanns <eo@nebensachen.de>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Elias Oltmanns wrote:
>> Tejun Heo <tj@kernel.org> wrote:
>>> Elias Oltmanns wrote:
>>>> Peter Moulder has pointed out that there is a slight chance that a
>>>> negative value might be passed to jiffies_to_msecs() in
>>>> ata_scsi_park_show(). This is fixed by saving the value of jiffies in a
>>>> local variable, thus also reducing code since the volatile variable
>>>> jiffies is accessed only once.
>>>>
>>>> Signed-off-by: Elias Oltmanns <eo@nebensachen.de>
>>> added to #tj-upstream.  Thanks.
>> Has this branch been pulled in yet? My patch, for one, is not even in
>> linux-next even though it had been intended for 2.6.28 at the time.
> 
> Jeff, have you pulled it or taken patches from it?
> 
> Thanks.

I sent an email a couple days ago, asking what was pending (or thought I 
did...).  I haven't pulled from #tj-upstream but I ack'd a big patchset 
that I assume is included in there.

	Jeff




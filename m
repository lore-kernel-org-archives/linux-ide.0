From: Tejun Heo <htejun@gmail.com>
Subject: Re: Current qc_defer implementation may lead to infinite recursion
Date: Tue, 12 Feb 2008 18:05:15 +0900
Message-ID: <47B1614B.5020209@gmail.com>
References: <87ir0w4rzo.fsf@denkblock.local> <47AFD7C1.7070204@gmail.com>	<871w7k9b8y.fsf@denkblock.local> <47B00AA1.3010104@gmail.com>	<87r6fj2lsx.fsf@denkblock.local> <47B0F2E0.9020204@gmail.com> <877iha3621.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:37434 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761157AbYBLJFV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Feb 2008 04:05:21 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2661103wah.23
        for <linux-ide@vger.kernel.org>; Tue, 12 Feb 2008 01:05:21 -0800 (PST)
In-Reply-To: <877iha3621.fsf@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Elias Oltmanns wrote:
> Tejun Heo <htejun@gmail.com> wrote:
>> Elias Oltmanns wrote:
>>> +static int piix_qc_defer(struct ata_queued_cmd *qc)
>>> +{
>>> +	static struct ata_port *ap = NULL;
>>> +	struct ata_queued_cmd qcmd[ATA_MAX_QUEUE];
>> missing static?
> 
> Oh well, I must have been too tired already yesterday. There are a few
> more things I got wrong last time. Please see the new patch at the end
> of this email.
> 
> This time I applied the patch to 2.6.24.1 and performed a
> 
> # cat large-file > /dev/null &
> # tail -f /var/log/kern.log
> 
> and aborted once the output of dump_stack() had occurred. This proves
> that piix_qc_defer() has declined the same command 100 times in
> succession. However, this will only happen if the status of all the
> commands enqueued for one port hasn't changed in the meantime. This
> suggests to me that the threads scheduled for command execution and
> completion aren't served for some reason. Any ideas?

Blocked counts of 1 will cause busy looping because when blk_run_queue()
returns because it's recursing too deep, it schedules unplug work right
away, so it will easily loop 100 times.  Max blocked counts should be
adjusted to two (needs some testing before actually submitting the
change).  But that still shouldn't cause any lock up.  What happens if
you remove the 100 times limit?  Does the machine hang on IO?

Thanks.


-- 
tejun

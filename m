From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: libata: Fix a potential race condition in ata_scsi_park_show()
Date: Thu, 30 Oct 2008 22:39:23 +0100
Message-ID: <87r65x225w.fsf@denkblock.local>
References: <87prmgzohf.fsf@denkblock.local> <48E7CF64.4050206@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:36344 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752472AbYJ3Vji (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 30 Oct 2008 17:39:38 -0400
In-Reply-To: <48E7CF64.4050206@kernel.org> (Tejun Heo's message of "Sun, 05
	Oct 2008 05:17:40 +0900")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Tejun Heo <tj@kernel.org> wrote:
> Elias Oltmanns wrote:
>> Peter Moulder has pointed out that there is a slight chance that a
>
>> negative value might be passed to jiffies_to_msecs() in
>> ata_scsi_park_show(). This is fixed by saving the value of jiffies in a
>> local variable, thus also reducing code since the volatile variable
>> jiffies is accessed only once.
>> 
>> Signed-off-by: Elias Oltmanns <eo@nebensachen.de>
>
> added to #tj-upstream.  Thanks.

Has this branch been pulled in yet? My patch, for one, is not even in
linux-next even though it had been intended for 2.6.28 at the time.

Regards,

Elias

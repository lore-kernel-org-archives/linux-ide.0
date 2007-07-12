From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFT][PATCH v7] sata_mv: convert to new EH
Date: Thu, 12 Jul 2007 06:27:49 -0400
Message-ID: <46960225.5000502@garzik.org>
References: <20070711200538.GA7374@havoc.gtf.org> <Pine.LNX.4.64.0707120212210.25837@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51430 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752562AbXGLK16 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 12 Jul 2007 06:27:58 -0400
In-Reply-To: <Pine.LNX.4.64.0707120212210.25837@twinlark.arctic.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: dean gaudet <dean@arctic.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, dave@thedillows.org

dean gaudet wrote:
> On Wed, 11 Jul 2007, Jeff Garzik wrote:
> 
>> As before, this patch is against 2.6.22 with no other patches needed nor
>> applied.
>>
>> In this revision, interrupt handling was improved quite a bit,
>> particularly for EDMA.  The WARNING in mv_get_crpb_status() goes away,
>> because that routine went away.  Its EDMA handling was potentially racy
>> as well.  It was replaced with a loop in mv_intr_edma() that guarantees
>> it always clears responses out of the queue, not a single response.
>>
>> Here's hoping that the WARNING in mv_qc_issue() goes away as well, but I
>> am less than 50% confident that will happen.
>>
>> The driver is making substantial progress with all these improvements,
>> though, in searching for the cause of this hardware behavior :)
>>
>> Though if mv_qc_issue() still warns, I would be interested to know if
>> this driver works OK if the mv_qc_issue() warning is simply removed at
>> that point...
> 
> oh very nice... no warnings on boot, and no warnings while i "dd 
> if=/dev/sdX of=/dev/null" and i'm seeing 74MB/s+ from each disk on this 
> simple read test.
> 
> for lack of a better test i started an untar/diff stress test on the 
> disks... we'll see how it goes.  (it's based on doug ledford's 
> memtest.sh)

Thanks for the testing.  Looks like we might have hit on something good...

	Jeff




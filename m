From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream-fixes] libata: unbreak TPM filtering by reorganizing
 ata_scsi_pass_thru()
Date: Sun, 06 Sep 2009 10:34:23 +0900
Message-ID: <4AA3119F.6000208@kernel.org>
References: <4A9F6B5B.80701@kernel.org> <4AA30B79.5000308@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47962 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753708AbZIFBex (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 5 Sep 2009 21:34:53 -0400
In-Reply-To: <4AA30B79.5000308@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Thilo-Alexander Ginkel <thilo@ginkel.com>

Jeff Garzik wrote:
> On 09/03/2009 03:08 AM, Tejun Heo wrote:
>> ata_scsi_pass_thru() was checking for input sanity and disallowed
>> commands while initializaing qc from scmd.  TPM filtering was added
>> right after protocol check at which point tf wasn't initialized
>> properly.  This means that TPM filtering has never really worked.
>>
>> This patch fixes the bug by reorganizing ata_scsi_pass_thru() such
>> that qc is fully initialized before checking for invalid conditions
>> which is way less error prone.
>>
>> Discovered while Thilo-Alexander Ginkel was trying debug patches for
>> bko#13416.
>>
>> Signed-off-by: Tejun Heo<tj@kernel.org>
>> Cc: Thilo-Alexander Ginkel<thilo@ginkel.com>
> 
> If it has never really worked, I would prefer #upstream at this point...

Ummm... Yeap, agreed.  Far too deep into -rc cycle.

Thanks.

-- 
tejun

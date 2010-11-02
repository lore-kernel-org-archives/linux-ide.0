From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream-fixes] libata: fix NULL sdev dereference race
 in atapi_qc_complete()
Date: Tue, 02 Nov 2010 22:56:46 +0100
Message-ID: <4CD0891E.4010307@kernel.org>
References: <4CCE98D7.1030906@kernel.org> <4CD0832A.3070503@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59762 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750862Ab0KBVy0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Nov 2010 17:54:26 -0400
In-Reply-To: <4CD0832A.3070503@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, stable <stable@kernel.org>, James Bottomley <James.Bottomley@HansenPartnership.com>

Hello, Mark.

On 11/02/2010 10:31 PM, Mark Lord wrote:
> On 10-11-01 06:39 AM, Tejun Heo wrote:
>> SCSI commands may be issued between __scsi_add_device() and dev->sdev
>> assignment, so it's unsafe for ata_qc_complete() to dereference
>> dev->sdev->locked without checking whether it's NULL or not.  Fix it.
>>
>> Signed-off-by: Tejun Heo<tj@kernel.org>
>> Cc: stable@kernel.org
> 
> Mmmm.. for some reason, this just screams "band-aid" to me,
> and makes me worry deeply about the underlaying race condition
> it all suggests..

Yeah, the coupling between sdev and ata_dev may look somewhat
band-aidy but AFAICS all others are explicitly checking whether
dev->sdev is set.  It's somewhat inevitable given the current probing
sequence (ATA dev comes up first and then tells SCSI to probe itself).

Thanks.

-- 
tejun

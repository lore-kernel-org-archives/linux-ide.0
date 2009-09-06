From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata: unbreak TPM filtering by reorganizing
 ata_scsi_pass_thru()
Date: Sat, 05 Sep 2009 21:08:09 -0400
Message-ID: <4AA30B79.5000308@garzik.org>
References: <4A9F6B5B.80701@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:42405 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753693AbZIFBIK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 5 Sep 2009 21:08:10 -0400
In-Reply-To: <4A9F6B5B.80701@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Thilo-Alexander Ginkel <thilo@ginkel.com>

On 09/03/2009 03:08 AM, Tejun Heo wrote:
> ata_scsi_pass_thru() was checking for input sanity and disallowed
> commands while initializaing qc from scmd.  TPM filtering was added
> right after protocol check at which point tf wasn't initialized
> properly.  This means that TPM filtering has never really worked.
>
> This patch fixes the bug by reorganizing ata_scsi_pass_thru() such
> that qc is fully initialized before checking for invalid conditions
> which is way less error prone.
>
> Discovered while Thilo-Alexander Ginkel was trying debug patches for
> bko#13416.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> Cc: Thilo-Alexander Ginkel<thilo@ginkel.com>

If it has never really worked, I would prefer #upstream at this point...

	Jeff




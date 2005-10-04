From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH libata-dev-2.6:passthru] passthru fixes
Date: Tue, 04 Oct 2005 10:22:32 -0400
Message-ID: <43429028.5010901@pobox.com>
References: <20050913142636.GB5679@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:53417 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932462AbVJDOWi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Oct 2005 10:22:38 -0400
In-Reply-To: <20050913142636.GB5679@google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Raubitschek <jhr@google.com>
Cc: linux-ide@vger.kernel.org

Jeff Raubitschek wrote:
> Fix a few problems seen with the passthru branch:
> 
> - leaked scsi_request on buffer allocate failure

I applied this fix to the 'passthru' branch


> - passthru sense routines were refering to tf->command
>   which is not read in tf_read, instead use drv_stat for
>   status register.
> - passthru sense passed back to user on ata_task_ioctl

ISTR there were some reported problems after applying this?  Feel free 
to split up these changes into separate patches, and submit them 
individually.  That makes each change easier to review and test 
individually.

	Jeff




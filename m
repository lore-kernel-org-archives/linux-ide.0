From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] SATA NCQ support
Date: Fri, 27 May 2005 04:28:59 -0400
Message-ID: <4296DA4B.6040303@pobox.com>
References: <20050527070353.GL1435@suse.de> <4296CAA8.9060307@pobox.com> <20050527073016.GO1435@suse.de> <4296CE3B.3040504@pobox.com> <20050527074712.GQ1435@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:222 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262043AbVE0I3F (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 May 2005 04:29:05 -0400
In-Reply-To: <20050527074712.GQ1435@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Fri, May 27 2005, Jeff Garzik wrote:
>>I just noticed a bug -- When ata_scsi_qc_new() fails, the code should 
>>complete the command with queue-full, but does not.
>>
>>        qc = ata_scsi_qc_new(ap, dev, cmd, done);
>>        if (!qc)
>>                return;
> 
> 
> Indeed, looks like an old bug.

Yep.  If you are knocking around in that area, would you mind killing it 
for me?  :)

	Jeff



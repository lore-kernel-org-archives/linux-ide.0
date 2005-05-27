From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] SATA NCQ support
Date: Fri, 27 May 2005 19:47:52 -0400
Message-ID: <4297B1A8.6090902@pobox.com>
References: <20050527070353.GL1435@suse.de> <4296CAA8.9060307@pobox.com> <20050527073016.GO1435@suse.de> <4296CE3B.3040504@pobox.com> <20050527074712.GQ1435@suse.de> <4296DA4B.6040303@pobox.com> <20050527083509.GT1435@suse.de> <4296DC75.2020809@pobox.com> <20050527084254.GU1435@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:46049 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262663AbVE0Xry (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 May 2005 19:47:54 -0400
In-Reply-To: <20050527084254.GU1435@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Fri, May 27 2005, Jeff Garzik wrote:
> 
>>Jens Axboe wrote:
>>
>>>Actually, I didn't look far enough up - ata_scsi_qc_new() already
>>>completes the command with QUEUE_FULL if ata_qc_new_init() fails. So
>>>there's no bug, but perhaps it would be cleaner to move it to
>>>ata_scsi_translate instead?
>>
>>Ah, ok.
>>
>>Yes, if you are in a cleaning mood, that would be a better location.
> 
> 
> Always in a code cleaning mood - here it is against vanilla, I've
> integrated it in the ncq stuff as well.

Committed to 'ncq' branch of libata-dev.git.

	Jeff




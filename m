From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFT] major libata update
Date: Tue, 16 May 2006 20:31:09 -0400
Message-ID: <446A6ECD.7080104@garzik.org>
References: <20060515170006.GA29555@havoc.gtf.org> <4469B93E.6010201@emc.com> <4469E0DB.1040709@garzik.org> <4469EEC0.4060907@gmail.com> <446A1A21.80501@emc.com> <446A63F6.5030706@gmail.com> <446A6615.6050701@garzik.org> <446A678E.8030403@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:8860 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932391AbWEQAbO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 May 2006 20:31:14 -0400
In-Reply-To: <446A678E.8030403@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: ric@emc.com, linux-ide@vger.kernel.org, Mark Lord <mlord@pobox.com>, Jens Axboe <axboe@suse.de>

Actually, looking even more at the code, I think the entire "spurious 
interrupt" code block is bogus.

The device is free to send D2H or SDB FIS to clear Status bits, as well 
as SDB FIS's to update SActive.  The ata_qc_complete_multiple() call 
will do the right thing, even if there is no work to do.

As another side note, command coalescing is worth experimenting with.

	Jeff




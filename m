From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata vs ATAPI
Date: Fri, 15 Oct 2004 01:00:43 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <416F597B.5010801@pobox.com>
References: <58cb370e04101213215ce9a23c@mail.gmail.com>	 <416C438C.4010902@pobox.com>	 <58cb370e0410121417591ecff0@mail.gmail.com>	 <20041014071313.GF1454@suse.de>	 <58cb370e04101412196d5a5c87@mail.gmail.com> <58cb370e04101414157605d9a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25568 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266196AbUJOFA4
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 15 Oct 2004 01:00:56 -0400
In-Reply-To: <58cb370e04101414157605d9a@mail.gmail.com>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jens Axboe <axboe@suse.de>, Linux IDE <linux-ide@vger.kernel.org>

Bartlomiej Zolnierkiewicz wrote:
> [libata] fix INQUIRY command handling for ATAPI
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

applied to libata-dev-2.6.


> page = sg->page;
> 
> should be here
> 
> I also found the real bug (feature?): ata_scsi_rbuf_get() clears
> INQUIRY buffer for ATAPI when called from atapi_qc_complete().
> 
> With the patch below INQUIRY w/ DMA works just fine for me
> ("Vendor" and "Model" are correctly reported).

Can you please resend your first patch,

1) assuming that this "fix INQUIRY command handling" patch is applied

2) removing the following piece of code:

+	if (scsicmd[0] == INQUIRY)
+		using_pio = 1;

Thanks,

	Jeff



From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: libata vs ATAPI
Date: Tue, 12 Oct 2004 22:21:16 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <58cb370e04101213215ce9a23c@mail.gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.198]:35077 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267737AbUJLUVW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Oct 2004 16:21:22 -0400
Received: by mproxy.gmail.com with SMTP id 77so379760rnk
        for <linux-ide@vger.kernel.org>; Tue, 12 Oct 2004 13:21:18 -0700 (PDT)
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Linux IDE <linux-ide@vger.kernel.org>

Hi Jeff,

Is libata currently supposed to work with ATAPI
(I know about lack of REQUEST_SENSE support)?

With ATA_ENABLE_ATAPI defined INQUIRY seems to succeed for my
TOSHIBA ODD-DVD SD-R6372 but empty info is printed by SCSI layer.

Then REPORT_LUNS errors out (dev_stat = 0x51)...

I've noticed that DMA is used by default for all packet commands
which doesn't seem to be wise thing to do so I disabled it.
Unfortunately it doesn't help because atapi_pio_sector() assumes
transfer length to be % SECTOR_SIZE and transfer length for INQUIRY
is mere 36 bytes so this fails.

This comment in atapi_pio_sector():

	/* make sure byte count is multiple of sector size; not
	* required by standard (warning! warning!), but IDE driver
	* does this to simplify things a bit.  We are lazy, and
	* follow suit.
	*/
	if (bytes & (ATA_SECT_SIZE - 1))
		goto err_out;

looks very suspicious because ide-cd and ide-scsi seem
to be doing this but only for READ/WRITE commands.

Also ATAPI-SCSI emulation is still missing in libata-scsi.c.

I'm sure you know more about what needs to be done.
Could you make some nice, detailed TODO? :-)

Thanks,
Bartlomiej

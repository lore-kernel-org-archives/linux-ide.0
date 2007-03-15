From: Bob Stewart <bob@evoria.net>
Subject: Re: sata_inic162x driver for 2.6.19 timeouts etc
Date: Thu, 15 Mar 2007 13:43:36 -0700 (PDT)
Message-ID: <248173.18921.qm@web806.biz.mail.mud.yahoo.com>
References: <45F9851E.8000709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web806.biz.mail.mud.yahoo.com ([209.191.90.79]:43243 "HELO
	web806.biz.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753356AbXCOUnh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Mar 2007 16:43:37 -0400
In-Reply-To: <45F9851E.8000709@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

--- Tejun Heo <htejun@gmail.com> wrote:

> The driver is seriously broken regarding LBA48 support.  The timeout
> goes away if max_sectors is decreased to ATA_MAX_SECTORS - 1, doh.

Tejun,

I should have commented on this earlier.  I still get occasional timeouts
regardless of the max_sectors settings.  Yes, it's much much lower with
some settings vs others, but they're still there.

I was just messing around and did this.  I still got the occasional timeouts.

#define BOBSEGS 64
static int inic_slave_config(struct scsi_device *sdev)
{
        /* This controller is braindamaged.  dma_boundary is 0xffff
         * like others but it will lock up the whole machine HARD if
         * 65536 byte PRD entry is fed.  Reduce maximum segment size.
         */
        struct ata_port *ap = ata_shost_to_port(sdev->host);
        ata_sas_slave_configure(sdev,ap);
        blk_queue_max_phys_segments(sdev->request_queue, BOBSEGS);
        blk_queue_max_hw_segments(sdev->request_queue, BOBSEGS);
        blk_queue_max_sectors(sdev->request_queue, BOBSEGS);
        blk_queue_max_segment_size(sdev->request_queue, BOBSEGS*512);
        return 0;
}


static struct scsi_host_template inic_sht = {
        .sg_tablesize           = BOBSEGS,
...

static void inic_dev_config(struct ata_port *ap, struct ata_device *dev)
{
        /* inic can only handle upto LBA28 max sectors */
        dev->max_sectors = BOBSEGS;


Sorry this isn't in diff format, but I think you can see what I did,
nonetheless.
Eventually, maybe I'll learn enough about something to be able to contribute.

Bob

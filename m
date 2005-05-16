From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH libata-dev-2.6 1/2] ata_dev_identify() check status fix
Date: Mon, 16 May 2005 14:35:24 +0800
Message-ID: <42883F2C.4060403@tw.ibm.com>
References: <424CE03C.7020903@tw.ibm.com> <424EC07A.10505@tw.ibm.com> <4287D77F.4030306@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:24058 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261435AbVEPGgI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 May 2005 02:36:08 -0400
In-Reply-To: <4287D77F.4030306@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Linux IDE <linux-ide@vger.kernel.org>, bruss@alum.wpi.edu


Jeff Garzik wrote:
> Could we not pass the Status value via struct ata_taskfile ?
> 
> 

Jeff,

I'm worried about:

1. struct ata_taskfile is part of struct ata_queued_cmd. The lifecycle of ata_queued_cmd is over
    after __ata_qc_complete() is called. So, when wait_for_completion() returns,
    qc has already been recycled for next use.

2. The following code is seen in ata_pio_error():
      ata_qc_complete(qc, drv_stat | ATA_ERR);
    It looks a good design of libata to me: ata_qc_complete() gets both qc and an additional status parameter.
The status paramerter is mixed of real hardware status and error found by the software.
Instead put the software error to qc->tf.status, maybe we could keep this good design and leave
struct ata_taskfile for the hardware only?


Albert
=====================
(The code in context.)

	spin_lock_irqsave(&ap->host_set->lock, flags);
	rc = ata_qc_issue(qc);
	spin_unlock_irqrestore(&ap->host_set->lock, flags);

	if (rc)
		goto err_out;
	else
		wait_for_completion(&wait);

	// When wait_for_completion() returns,
	// the life cycle of qc was over and
	// qc->tag == ATA_TAG_POISON; here.
	// Maybe we should not access qc here.
	status = qc->tf.status;

	if (status & ATA_ERR) {
		/*
		 * arg!  EDD works for all test cases, but seems to return
		 * the ATA signature for some ATAPI devices.  Until the
		 * reason for this is found and fixed, we fix up the mess
		 * here.  If IDENTIFY DEVICE returns command aborted
		 * (as ATAPI devices do), then we issue an
		 * IDENTIFY PACKET DEVICE.
		 *
		 * ATA software reset (SRST, the default) does not appear
		 * to have this problem.
		 */
		if ((using_edd) && (qc->tf.command == ATA_CMD_ID_ATA)) {
			u8 err = ata_chk_err(ap);
			if (err & ATA_ABORTED) {
				dev->class = ATA_DEV_ATAPI;
				//
				// We should call ata_qc_new_init()
				// to revive qc here?
				//
				qc->cursg = 0;
				qc->cursg_ofs = 0;
				qc->cursect = 0;
				qc->nsect = 1;
				goto retry;
			}
		}
		goto err_out;
	}




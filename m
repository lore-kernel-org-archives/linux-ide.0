From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata new EH issue - ATAPI device error not properly reported
Date: Wed, 28 Jun 2006 19:27:22 +0900
Message-ID: <44A2598A.6040001@gmail.com>
References: <44A23D76.30307@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.199]:7181 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932504AbWF1K1D (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Jun 2006 06:27:03 -0400
Received: by wx-out-0102.google.com with SMTP id t5so933602wxc
        for <linux-ide@vger.kernel.org>; Wed, 28 Jun 2006 03:27:03 -0700 (PDT)
In-Reply-To: <44A23D76.30307@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jgarzik@pobox.com>, Linux IDE <linux-ide@vger.kernel.org>, Unicorn Chang <uchang@tw.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Doug Maxey <dwm@bebe.enoyolf.org>

Hello, Albert.

Albert Lee wrote:
> Hi Tejun,
> 
> Unicorn is doing some test with the current upstream branch and something
> looks strange in the log.
> 
> With the new EH, when the ATAPI device reports dev_status 0x51,
> the err_mask is reported as 0x0. This does not look right.
> Maybe we should report AC_ERR_DEV error back to the upper layers?
> (Test log attached for your review.)
>
[--snip--]
> Jun 27 18:10:57 xlinux19 kernel: atapi_qc_complete: ENTER, err_mask 0x0  <== Doesn't look right. Should report error.

The following code block follows the above VPRINTK.

	/* handle completion from new EH */
	if (unlikely(qc->ap->ops->error_handler &&
		     (err_mask || qc->flags & ATA_QCFLAG_SENSE_VALID))){

		if (!(qc->flags & ATA_QCFLAG_SENSE_VALID)) {
			/* FIXME: not quite right; we don't want the
			 * translation of taskfile registers into a
			 * sense descriptors, since that's only
			 * correct for ATA, not ATAPI
			 */
			ata_gen_ata_desc_sense(qc);
		}

		qc->scsicmd->result = SAM_STAT_CHECK_CONDITION;
		qc->scsidone(cmd);
		ata_qc_free(qc);
		return;
	}

As EH set ATA_QCFLAG_SENSE_VALID after reading sense data the above if 
block is executed thus reporting upper layer CHECK_CONDITION.  Overall, 
the control flow on ATAPI CC is like the following.

1. ATAPI CC occurs

2. AC_ERR_DEV set and EH invoked

3. EH requests sense.  sense is stored in the sense buffer and 
AC_ERR_DEV is cleared.

4. EH completes the qc and triggers above code block in atapi_qc_complete().

The logic behind clearing AC_ERR_DEV after reading sense data is that 
ATAPI CC doesn't always indicate device error.  It can indicate 
anything.  By clearing AC_ERR_DEV after sense data is read, libata EH 
considers the error condition is cleared and doesn't perform further 
action on the device.  If the sense data indicates actual error, upper 
layers will probably deal with it (sr driver or userland application).

It might be useful to interpret some of sense data and handle things 
like transmission error in libata EH, but I don't know.  ATAPI errors 
always have been handled by upper layers.

-- 
tejun

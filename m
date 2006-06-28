From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: libata new EH issue - ATAPI device error not properly reported
Date: Wed, 28 Jun 2006 19:03:12 +0800
Message-ID: <44A261F0.7030905@tw.ibm.com>
References: <44A23D76.30307@tw.ibm.com> <44A2598A.6040001@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:6815 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932195AbWF1LDQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Jun 2006 07:03:16 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k5SB3FXL006964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-ide@vger.kernel.org>; Wed, 28 Jun 2006 07:03:15 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k5SB3VvB162122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Wed, 28 Jun 2006 05:03:31 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k5SB3D4P028882
	for <linux-ide@vger.kernel.org>; Wed, 28 Jun 2006 05:03:14 -0600
In-Reply-To: <44A2598A.6040001@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertl@mail.com, Jeff Garzik <jgarzik@pobox.com>, Linux IDE <linux-ide@vger.kernel.org>, Unicorn Chang <uchang@tw.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Doug Maxey <dwm@bebe.enoyolf.org>

Tejun Heo wrote:
> Hello, Albert.
> 
> Albert Lee wrote:
> 
>> Hi Tejun,
>>
>> Unicorn is doing some test with the current upstream branch and something
>> looks strange in the log.
>>
>> With the new EH, when the ATAPI device reports dev_status 0x51,
>> the err_mask is reported as 0x0. This does not look right.
>> Maybe we should report AC_ERR_DEV error back to the upper layers?
>> (Test log attached for your review.)
>>
> [--snip--]
> 
>> Jun 27 18:10:57 xlinux19 kernel: atapi_qc_complete: ENTER, err_mask
>> 0x0  <== Doesn't look right. Should report error.
> 
> 
> The following code block follows the above VPRINTK.
> 
>     /* handle completion from new EH */
>     if (unlikely(qc->ap->ops->error_handler &&
>              (err_mask || qc->flags & ATA_QCFLAG_SENSE_VALID))){
> 
>         if (!(qc->flags & ATA_QCFLAG_SENSE_VALID)) {
>             /* FIXME: not quite right; we don't want the
>              * translation of taskfile registers into a
>              * sense descriptors, since that's only
>              * correct for ATA, not ATAPI
>              */
>             ata_gen_ata_desc_sense(qc);
>         }
> 
>         qc->scsicmd->result = SAM_STAT_CHECK_CONDITION;
>         qc->scsidone(cmd);
>         ata_qc_free(qc);
>         return;
>     }
> 
> As EH set ATA_QCFLAG_SENSE_VALID after reading sense data the above if
> block is executed thus reporting upper layer CHECK_CONDITION.  Overall,
> the control flow on ATAPI CC is like the following.
> 
> 1. ATAPI CC occurs
> 
> 2. AC_ERR_DEV set and EH invoked
> 
> 3. EH requests sense.  sense is stored in the sense buffer and
> AC_ERR_DEV is cleared.
> 
> 4. EH completes the qc and triggers above code block in
> atapi_qc_complete().
> 
> The logic behind clearing AC_ERR_DEV after reading sense data is that
> ATAPI CC doesn't always indicate device error.  It can indicate
> anything.  By clearing AC_ERR_DEV after sense data is read, libata EH
> considers the error condition is cleared and doesn't perform further
> action on the device.  If the sense data indicates actual error, upper
> layers will probably deal with it (sr driver or userland application).
> 
> It might be useful to interpret some of sense data and handle things
> like transmission error in libata EH, but I don't know.  ATAPI errors
> always have been handled by upper layers.
> 

Thanks for the detailed explanation. We are checking a strange problem
related to the GoVault drive: After the GoVault drive is ejected, a
flood of SCSI commands 0x1e are issued to libata upstream kernel.
(This is not reproducible with 2.6.17 kernel.) The GoVault drive
timeout at the eject command before the flood of command, so that
timeout might be the cause, not the ATAPI err_mask. Will check more
about the real cause.

--
albert



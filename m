From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH 2.6.21-rc7-mm2 2/2] sata_promise: move port reset from error intr to EH prereset
Date: Tue, 1 May 2007 22:29:48 +0200 (MEST)
Message-ID: <200705012029.l41KTmR5009121@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:48669 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422997AbXEAUaJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 May 2007 16:30:09 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com, mikpe@it.uu.se
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Mon, 30 Apr 2007 11:27:46 +0200, Tejun Heo wrote:
>Mikael Pettersson wrote:
>> @@ -647,12 +650,10 @@ static void pdc_error_intr(struct ata_po
>>  			   | PDC_PCI_SYS_ERR | PDC1_PCI_PARITY_ERR))
>>  		ac_err_mask |= AC_ERR_HOST_BUS;
>>  
>> -	if (sata_scr_valid(ap))
>> -		ehi->serror |= pdc_sata_scr_read(ap, SCR_ERROR);
>> -
>> +	ehi->action |= ATA_EH_SOFTRESET;
>>  	qc->err_mask |= ac_err_mask;
>>  
>> -	pdc_reset_port(ap);
>> +	ata_port_freeze(ap);
>>  }
>
>You really don't wanna schedule ATA_EH_SOFTRESET and freeze the port on
>every error.  If you do that, ATAPI devices will be reset after each
>CHECK CONDITION and it probably won't work properly.

Would that be hal polling to see if media has been inserted?

>  FWIW, libata EH
>automatically issues softreset if the port is frozen (as that's the only
>way to thaw the port), so setting EH_SOFTRESET is optional if you freeze
>the port.
>
>Another problem is that EH may issue other commands to while trying to
>recover - e.g. PACKET - REQUEST SENSE or READ LOG PAGE.  This only
>happens if the port is ready for commands, IOW, !frozen.  Before, the
>pdc_reset_port() used to be called on entry to EH if it's not frozen but
>it's not after this patch.  Is this safe?

Oh dear. I assumed EH would only want to inspect the standard
status registers, and that's why I wanted to delay the reset.
If EH wants to talk to the device then it's a very bad idea to
not have issued a pdc_reset_port() first.

Jeff, please toss this patch in the dust bin.

/Mikael

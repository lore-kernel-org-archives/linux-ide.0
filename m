From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/6] ata_piix: clean up port flags
Date: Wed, 01 Nov 2006 14:12:33 +0900
Message-ID: <45482CC1.9090301@gmail.com>
References: <1159598809262-git-send-email-htejun@gmail.com> <454828CA.1000806@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:5096 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1945969AbWKAFMn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Nov 2006 00:12:43 -0500
Received: by nf-out-0910.google.com with SMTP id c2so632515nfe
        for <linux-ide@vger.kernel.org>; Tue, 31 Oct 2006 21:12:42 -0800 (PST)
In-Reply-To: <454828CA.1000806@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: nabiki@teleline.es, kaos@ocs.com.au, stevenm@umd.edu, jfs@keytradebank.com, 0602@eq.cz, akpm@osdl.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> * move common flags into PIIX_PATA_FLAGS and PIIX_SATA_FLAGS
>> * kill unnecessary ATA_FLAG_SRST
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> AFAICS, SRST is quite necessary on PATA.  What's going on?  There isn't 
> much of any explanation for the SRST removal here :/

Both reset flags ATA_FLAG_SATA_RESET and ATA_FLAG_SRST are used to tell 
old EH how to reset and probe the port.  In new EH, those flags don't 
play any role.  What method to use and in what sequence is upto 
->error_handler() now.  For PATA piix, it only implements SRST, so 
that's gonna be used.  For SATA piix, ata_bmdma_drive_eh() always 
prefers SRST on boot probe.

Once sata_promise/mv/.. are converted to new EH, the above two reset 
flags can be removed.

Thanks.

-- 
tejun

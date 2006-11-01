From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/6] ata_piix: clean up port flags
Date: Wed, 01 Nov 2006 00:19:47 -0500
Message-ID: <45482E73.70004@pobox.com>
References: <1159598809262-git-send-email-htejun@gmail.com> <454828CA.1000806@pobox.com> <45482CC1.9090301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55515 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1946070AbWKAFT7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Nov 2006 00:19:59 -0500
In-Reply-To: <45482CC1.9090301@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: nabiki@teleline.es, kaos@ocs.com.au, stevenm@umd.edu, jfs@keytradebank.com, 0602@eq.cz, akpm@osdl.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Jeff Garzik wrote:
>> Tejun Heo wrote:
>>> * move common flags into PIIX_PATA_FLAGS and PIIX_SATA_FLAGS
>>> * kill unnecessary ATA_FLAG_SRST
>>>
>>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>>
>> AFAICS, SRST is quite necessary on PATA.  What's going on?  There 
>> isn't much of any explanation for the SRST removal here :/
> 
> Both reset flags ATA_FLAG_SATA_RESET and ATA_FLAG_SRST are used to tell 
> old EH how to reset and probe the port.  In new EH, those flags don't 
> play any role.  What method to use and in what sequence is upto 
> ->error_handler() now.  For PATA piix, it only implements SRST, so 
> that's gonna be used.  For SATA piix, ata_bmdma_drive_eh() always 
> prefers SRST on boot probe.
> 
> Once sata_promise/mv/.. are converted to new EH, the above two reset 
> flags can be removed.

Ah, duh.  I knew that, thanks for the clue-hammer :)

	Jeff




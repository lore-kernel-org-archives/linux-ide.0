From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [patch] scsi/libata: correct bug for ULi M5281
Date: Sat, 05 Feb 2005 23:43:33 -0500
Message-ID: <4205A075.8090405@pobox.com>
References: <OF72031848.8565651F-ON48256F6A.0025361E@uli.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45744 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S268914AbVBFEnu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 5 Feb 2005 23:43:50 -0500
In-Reply-To: <OF72031848.8565651F-ON48256F6A.0025361E@uli.com.tw>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Clear.Zhang@uli.com.tw
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, andrebalsa@mailingaddress.org, Peer.Chen@uli.com.tw, Emily.Jiang@uli.com.tw, Eric.Lo@uli.com.tw

Clear.Zhang@uli.com.tw wrote:
> Hi Jeff,
> 
> I've correct the patch according to your suggestion.
> But we need libata-core.c to export some functions.
> Here is the patch. Please check it and apply it to new kernels.
> Thanks a lot.


I'm afraid I cannot accept even the updated version of your patch.

Your second patch updates libata-core, and adds ULi-specific code to it.

What we need to do is

1) determine if your problem is ULi-specific, or applies to other
controllers

2a) If the problem is not ULi-specific, simply update libata to new
behavior.

2b) If the problem is ULi-specific, libata must be modified such that
all ULi-specific reset procedures are in sata_uli.c, and _no code is
duplicated from libata_.  This may require that we change the libata
API.  In Linux, it is OK to change the driver API when there is a problem :)

Regards,

	Jeff



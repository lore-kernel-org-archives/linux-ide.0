From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: PROBLEM: ICH7 SATA drive not detected.
Date: Fri, 25 Feb 2005 23:35:18 -0500
Message-ID: <421FFC86.7090802@pobox.com>
References: <e16ac85e050225153649939bed@mail.gmail.com>	 <421FBC0B.5070004@pobox.com> <e16ac85e05022517024beb5b38@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63367 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261158AbVBZEfh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Feb 2005 23:35:37 -0500
In-Reply-To: <e16ac85e05022517024beb5b38@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Felix <gregfelixlkml@gmail.com>
Cc: linux-kernel@vger.kernel.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Comment out the function call to piix_disable_ahci() and see what happens.

         if (port_info[0]->host_flags & PIIX_FLAG_AHCI) {
                 int rc = piix_disable_ahci(pdev);
                 if (rc)
                         return rc;
         }

Regards,

	Jeff



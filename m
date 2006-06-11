From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [git-patch] hotplug fix patches added
Date: Sun, 11 Jun 2006 09:35:26 -0400
Message-ID: <448C1C1E.7080109@pobox.com>
References: <448B7FFD.9050507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:39899 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751277AbWFKNf3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Jun 2006 09:35:29 -0400
In-Reply-To: <448B7FFD.9050507@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Hello,
> 
> Two hotplug fix patches have been added to libata-tj #for-jeff.
> 
> * libata: add missing finish_wait() call in ata_port_wait_eh()
> * libata: cosmetic change in struct ata_port
> 
> The following two patches have been dropped as it hasn't been acked yet.
> 
> * ata_piix: fix ghost device probing by honoring PCS present bits[1]

Seems vaguely OK to me...


> * libata: add ata_port->private_flags[2]

What's the justification for this?  Running out of room in flags?

If we are going to do this, I would move any such flags to the 
LLDD-allocated hpriv structure completely.  I wouldn't add hpriv_flags 
to struct ata_port.

	Jeff




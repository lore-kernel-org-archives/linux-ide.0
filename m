From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: hdregs.h puts csfo at word 129 - wrong, that's vendor specific
Date: Thu, 24 Mar 2005 22:03:20 -0500
Message-ID: <42437F78.8090703@pobox.com>
References: <4243693F.9090008@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9370 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261356AbVCYDDd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 Mar 2005 22:03:33 -0500
In-Reply-To: <4243693F.9090008@yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chris Hann <chann94501@yahoo.com>
Cc: linux-ide list <linux-ide@vger.kernel.org>

Chris Hann wrote:
> ide-disk.c checks csfo bit 0 to see if the cache is available on a device
> hdregs.h maps csfo to word 129 of the Identify Device information
> the latest ATA documentation, e00159r3 Mandatory IDENTIFY DEVICE 
> information, says words 129-159 are Vendor specific.
> 
> Why is the driver switching on cache operations based on a word that has 
> nothing to do with cache?

Good question...  I would guess that it's some pre-ATA4 legacy magic, 
but that's just a guess.

	Jeff




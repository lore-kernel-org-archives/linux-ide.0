From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [SATA] libata-dev queue updated
Date: Sat, 19 Feb 2005 12:09:06 -0500
Message-ID: <421772B2.7050100@pobox.com>
References: <4216FB7B.3030409@pobox.com> <4217703E.4070307@tomt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34699 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261741AbVBSRJ3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 19 Feb 2005 12:09:29 -0500
In-Reply-To: <4217703E.4070307@tomt.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andre Tomt <andre@tomt.net>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

Andre Tomt wrote:
> Jeff Garzik wrote:
> 
>> Patch URL, BK URL, and changelog attached.
>>
>> Recent changes:
>> * New sata_qstor driver.
>>
>> * Turn on ATAPI by default.
>>
>> * Change a couple unconditional use-the-hardware function calls to be 
>> callbacks instead.  Should have been this way originally.
>>
>> * Most of C/H/S support.
>>
>> * Fix bugs in ADMA driver.
>>
>> * Support PCI MSI in AHCI driver.
>> * Support ATAPI in AHCI driver.
>>
>> * Improve ATA passthru (a.k.a. SMART) support
>>
> 
> How is the Marvell driver coming along? Did it stall? :-)

Yeah, it's stalled...

	Jeff




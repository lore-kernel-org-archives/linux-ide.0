From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] Add AMD SB900 SATA/IDE controller device IDs
Date: Tue, 28 Jul 2009 22:42:14 -0400
Message-ID: <4A6FB706.3010304@pobox.com>
References: <1248762566.3437.7.camel@zm-desktop> <4A6F9E3E.30500@pobox.com> <C8E4BD7D001E44499280E0884BD9DB30D7D2CE@sshaexmb1.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50957 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751657AbZG2CmT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Jul 2009 22:42:19 -0400
In-Reply-To: <C8E4BD7D001E44499280E0884BD9DB30D7D2CE@sshaexmb1.amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Huang, Shane" <Shane.Huang@amd.com>
Cc: tj@kernel.org, linux-ide@vger.kernel.org

Huang, Shane wrote:
> Hi Jeff, 
> 
> 
>> -----Original Message-----
>> From: Jeff Garzik [mailto:jgarzik@pobox.com] 
>>>  
>>> +	/* AMD */
>>> +	{ PCI_VDEVICE(AMD, 0x7800), board_ahci }, /* AMD SB900 */
>>> +	{ PCI_VENDOR_ID_AMD, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
>>> +	  PCI_CLASS_STORAGE_RAID << 8, 0xffffff, board_ahci }, 
>> /* AMD RAID */
>>
>> Are you _absolutely_ certain that future AMD PCI_CLASS_STORAGE_RAID 
>> hardware will be compatible with AHCI?
>>
> 
> Yes, we discussed this issue in our team and do not see the risk,
> so we decided to submit the generic RAID support.
> 
> I will update this patch with Tejun's request to add one comment.

Sounds good, thanks...

	Jeff





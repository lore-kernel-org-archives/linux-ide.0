From: "Huang, Shane" <Shane.Huang@amd.com>
Subject: RE: [PATCH] Add AMD SB900 SATA/IDE controller device IDs
Date: Wed, 29 Jul 2009 10:32:56 +0800
Message-ID: <C8E4BD7D001E44499280E0884BD9DB30D7D2CE@sshaexmb1.amd.com>
References: <1248762566.3437.7.camel@zm-desktop> <4A6F9E3E.30500@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from va3ehsobe002.messaging.microsoft.com ([216.32.180.12]:49311
	"EHLO VA3EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752891AbZG2CdL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Jul 2009 22:33:11 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <4A6F9E3E.30500@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: tj@kernel.org, linux-ide@vger.kernel.org, "Huang, Shane" <Shane.Huang@amd.com>

Hi Jeff, 


> -----Original Message-----
> From: Jeff Garzik [mailto:jgarzik@pobox.com] 
> >  
> > +	/* AMD */
> > +	{ PCI_VDEVICE(AMD, 0x7800), board_ahci }, /* AMD SB900 */
> > +	{ PCI_VENDOR_ID_AMD, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
> > +	  PCI_CLASS_STORAGE_RAID << 8, 0xffffff, board_ahci }, 
> /* AMD RAID */
> 
> Are you _absolutely_ certain that future AMD PCI_CLASS_STORAGE_RAID 
> hardware will be compatible with AHCI?
> 

Yes, we discussed this issue in our team and do not see the risk,
so we decided to submit the generic RAID support.

I will update this patch with Tejun's request to add one comment.


Thanks
Shane


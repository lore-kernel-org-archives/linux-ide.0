From: "Huang, Shane" <Shane.Huang@amd.com>
Subject: RE: [PATCH #upstream-fixes] ata: rename AMD SB900 into Hudson-2
Date: Thu, 15 Oct 2009 10:25:46 +0800
Message-ID: <C8E4BD7D001E44499280E0884BD9DB30011C93F8@sshaexmb1.amd.com>
References: <1255403640.3625.6.camel@zm-desktop> <4AD5C6B8.3010703@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:36460 "EHLO
	TX2EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932510AbZJOC0o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Oct 2009 22:26:44 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <4AD5C6B8.3010703@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: tj@kernel.org, linux-ide@vger.kernel.org, "Huang, Shane" <Shane.Huang@amd.com>

Hi Jeff, 

> -----Original Message-----
> From: Jeff Garzik [mailto:jgarzik@pobox.com] 
> 
> The patch certainly seems obviously correct, but normally we 
> deal with 
> boring chip names, because marketing names change all the 
> time.  If we 
> applied "marketing patches" there would be a ton of patches 
> sent our way.
> 
> If the SB900 simply does not / will not exist, then I'm fine 
> applying this.
> 
> Otherwise, I would prefer the chip name over the marketing name...
 

"Hudson-2" is not only marketing name, it is the chip name for
both internal and external use. SB900 will not be used.

So please apply this patch.


Thanks,
Shane


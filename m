From: "James Spooner" <james@endace.com>
Subject: Re: Marvell 88SX[56]0[48]1 libata driver development.
Date: Wed, 4 Aug 2004 19:05:47 +1200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <081b01c479f1$7843e050$5440a8c0@zeus>
References: <20040803120504.A31838@florence.linkmargin.com> <20040803234709.GC25032@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from et.endace.com ([219.88.101.154]:14790 "EHLO et.endace.com")
	by vger.kernel.org with ESMTP id S267304AbUHDHFy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Aug 2004 03:05:54 -0400
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Andy Warner <andyw@pobox.com>
Cc: linux-ide@vger.kernel.org


Jeff Garzik wrote:
> 
> I've already got most of a driver locally; patience grasshopper :)
> 
> Marvell gave me access to their SATA hardware docs -- and more
> importantly -- errata which must be taken into account.
> 

What does this mean for the Marvell running Adaptec firmware 
such as is on the Supermicro P4SCT+ (they call it an aic81xx iirc)?


Jeff, by the way, did you see my mail about the BUG() with the 
ata_piix driver, I note that it works fine in RHEL3's kernel,
not sure whats going on there?

Cheers

James


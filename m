From: Jeff Garzik <jeff@garzik.org>
Subject: Re: libata: why do we need to define ATA_ENABLE_PATA instead of a
 CONFIG option?
Date: Tue, 07 Mar 2006 00:18:58 -0500
Message-ID: <440D17C2.60200@garzik.org>
References: <20060307010444.GA6799@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:31675 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750997AbWCGFTA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Mar 2006 00:19:00 -0500
In-Reply-To: <20060307010444.GA6799@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: linux-ide@vger.kernel.org

Ravikiran G Thirumalai wrote:
> Currently, we can use the piix ide driver for Intel ICH5 IDE controllers, or
> use ata_piix (libata) by #defining ATA_ENABLE_PATA manually at
> inclulde/linux/libata.h.  Why not have a CONFIG option to enable libata for such
> drivers instead of a #define in the code? I was wondering if there is any
> reason it is done this way.

ATA_ENABLE_PATA is there because PATA was highly experimental for a 
while, and only developers and power users should be enabling it.

	Jeff




From: "Gaston, Jason D" <jason.d.gaston@intel.com>
Subject: RE: [PATCH 2.6.23-rc4][reRESEND] ahci: RAID mode SATA patch for Intel Tolapai
Date: Fri, 31 Aug 2007 10:10:17 -0700
Message-ID: <39B20DF628532344BC7A2692CB6AEE0701B5BE08@orsmsx420.amr.corp.intel.com>
References: <200708302127.19535.jason.d.gaston@intel.com> <46D7C783.8050803@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:12012 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965436AbXHaRKT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 Aug 2007 13:10:19 -0400
Content-class: urn:content-classes:message
In-Reply-To: <46D7C783.8050803@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

This device has both AHCI and RAID modes that use the ahci driver.  Only
the RAID mode DID's are being added as the PCI class code support will
cover the AHCI mode.  Looking at the Generic, PCI class code support
section, it uses "board_ahci".  I assumed that they should be the same
as the generic class code support is working on this platform.

Thanks,

Jason


>-----Original Message-----
>From: Jeff Garzik [mailto:jgarzik@pobox.com]
>Sent: Friday, August 31, 2007 12:47 AM
>To: Gaston, Jason D
>Cc: linux-ide@vger.kernel.org; linux-kernel@vger.kernel.org
>Subject: Re: [PATCH 2.6.23-rc4][reRESEND] ahci: RAID mode SATA patch
for
>Intel Tolapai
>
>Jason Gaston wrote:
>> Resend trying to remove 8-bit characters in the email.
>>
>> This patch adds the Intel Tolapai RAID controller DID's for SATA
support.
>>
>> Signed-off-by:  Jason Gaston <jason.d.gaston@intel.com>
>>
>> --- linux-2.6.23-rc4/drivers/ata/ahci.c.orig	2007-08-27
>18:32:35.000000000 -0700
>> +++ linux-2.6.23-rc4/drivers/ata/ahci.c	2007-08-28
16:58:11.000000000 -
>0700
>> @@ -411,6 +411,8 @@
>>  	{ PCI_VDEVICE(INTEL, 0x292f), board_ahci_pi }, /* ICH9M */
>>  	{ PCI_VDEVICE(INTEL, 0x294d), board_ahci_pi }, /* ICH9 */
>>  	{ PCI_VDEVICE(INTEL, 0x294e), board_ahci_pi }, /* ICH9M */
>> +	{ PCI_VDEVICE(INTEL, 0x502a), board_ahci }, /* Tolapai */
>> +	{ PCI_VDEVICE(INTEL, 0x502b), board_ahci }, /* Tolapai */
>
>Why did you not use board_ahci_pi?  Is the AHCI ports-implemented
>register unreliable on this platform?

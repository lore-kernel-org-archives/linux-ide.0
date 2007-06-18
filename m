From: "Gaston, Jason D" <jason.d.gaston@intel.com>
Subject: RE: [PATCH] Add new ICH9M pci id (8086:2850) to ata_piix id list
Date: Mon, 18 Jun 2007 11:05:56 -0700
Message-ID: <39B20DF628532344BC7A2692CB6AEE07016FE490@orsmsx420.amr.corp.intel.com>
References: <4675A948.80007@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:24369 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764553AbXFRSGI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jun 2007 14:06:08 -0400
Content-class: urn:content-classes:message
In-Reply-To: <4675A948.80007@googlemail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Maurizio Monge <maurizio.monge@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Alan Cox <alan@redhat.com>, Jeff Garzik <jeff@garzik.org>

DID 2850 is not a SATA controller.  This is an ICH8 PATA controller DID.

Jason


>-----Original Message-----
>From: linux-ide-owner@vger.kernel.org [mailto:linux-ide-
>owner@vger.kernel.org] On Behalf Of Michal Piotrowski
>Sent: Sunday, June 17, 2007 2:36 PM
>To: Maurizio Monge
>Cc: linux-kernel@vger.kernel.org; linux-ide@vger.kernel.org; Alan Cox;
Jeff
>Garzik
>Subject: Re: [PATCH] Add new ICH9M pci id (8086:2850) to ata_piix id
list
>
>Hi,
>
>Maurizio Monge pisze:
>> To make ata_piix recognize my ich9m chip i had to apply the
>> modification that follows.
>>
>> Best regards
>> Maurizio Monge
>>
>>
>> diff -Nurb old/drivers/ata/ata_piix.c new/drivers/ata/ata_piix.c
>> --- old/drivers/ata/ata_piix.c  2007-06-17 23:06:12.000000000 +0200
>> +++ new/drivers/ata/ata_piix.c  2007-06-17 23:15:57.000000000 +0200
>> @@ -243,6 +243,8 @@
>>        { 0x8086, 0x292d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci
},
>>        /* SATA Controller IDE (ICH9M) */
>>        { 0x8086, 0x292e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci
},
>> +       /* Mobile SATA Controller IDE (ICH9M) */
>> +       { 0x8086, 0x2850, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
ich8_sata_ahci },
>                      ^^^^
>http://pci-ids.ucw.cz/iii/?i=80862850
>
>Is this really a SATA controller?
>((ICH8M/ICH8M-E) IDE Controller)
>
>Regards,
>Michal
>
>--
>LOG
>http://www.stardust.webpages.pl/log/
>-
>To unsubscribe from this list: send the line "unsubscribe linux-ide" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: "Gaston, Jason D" <jason.d.gaston@intel.com>
Subject: RE: [PATCH 2.6.24] ata_piix:  IDE mode SATA patch for Intel ICH10 DeviceID's
Date: Tue, 29 Jan 2008 10:03:04 -0800
Message-ID: <39B20DF628532344BC7A2692CB6AEE0702403EBE@orsmsx420.amr.corp.intel.com>
References: <200801281736.45574.jason.d.gaston@intel.com> <479F5EDF.9010601@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1765911AbYA2SFB@vger.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <479F5EDF.9010601@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, htejun@gmail.com
List-Id: linux-ide@vger.kernel.org

>-----Original Message-----
>From: Jeff Garzik [mailto:jgarzik@pobox.com]
>Sent: Tuesday, January 29, 2008 9:14 AM
>To: Gaston, Jason D
>Cc: linux-ide@vger.kernel.org; linux-kernel@vger.kernel.org;
>htejun@gmail.com
>Subject: Re: [PATCH 2.6.24] ata_piix: IDE mode SATA patch for Intel
ICH10
>DeviceID's
>
>Jason Gaston wrote:
>> This patch adds the Intel ICH10 IDE mode SATA Controller DeviceID's.
>>
>> Signed-off-by:  Jason Gaston <jason.d.gaston@intel.com>
>>
>> --- linux-2.6.24/drivers/ata/ata_piix.c.orig	2008-01-24
>14:58:37.000000000 -0800
>> +++ linux-2.6.24/drivers/ata/ata_piix.c	2008-01-28
14:58:22.000000000 -
>0800
>> @@ -263,6 +263,14 @@
>>  	{ 0x8086, 0x292e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci
},
>>  	/* SATA Controller IDE (Tolapai) */
>>  	{ 0x8086, 0x5028, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
tolapai_sata_ahci },
>> +	/* SATA Controller IDE (ICH10) */
>> +	{ 0x8086, 0x3a00, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci
},
>> +	/* SATA Controller IDE (ICH10) */
>> +	{ 0x8086, 0x3a06, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata
},
>> +	/* SATA Controller IDE (ICH10) */
>> +	{ 0x8086, 0x3a20, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci
},
>> +	/* SATA Controller IDE (ICH10) */
>> +	{ 0x8086, 0x3a26, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata
},
>
>can these do AHCI mode without losing any PATA ports?
>
>if so, I would prefer to always drive the hardware in AHCI mode, if it
>is capable of doing so.

They do not have PATA.

Jason

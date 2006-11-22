From: "Gaston, Jason D" <jason.d.gaston@intel.com>
Subject: RE: [PATCH 2.6.19-rc6][RESEND] ata_piix: IDE mode SATA patch for Intel ICH9
Date: Tue, 21 Nov 2006 17:30:52 -0800
Message-ID: <39B20DF628532344BC7A2692CB6AEE07A5A356@orsmsx420.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1031451AbWKVBa4@vger.kernel.org>
Content-class: urn:content-classes:message
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

I was thinking that if a functional difference was found, it would be
easier to tweak.

There are differences between the ICH8 and ICH9 SATA controller.  For
example, the PCS register now has port present bits that used to be
reserved in ICH8.  I'm not sure how or if these could be used in
ata_piix.

Jason



>-----Original Message-----
>From: Tejun Heo [mailto:htejun@gmail.com]
>Sent: Tuesday, November 21, 2006 5:23 PM
>To: Gaston, Jason D
>Cc: jgarzik@pobox.com; linux-ide@vger.kernel.org; linux-
>kernel@vger.kernel.org
>Subject: Re: [PATCH 2.6.19-rc6][RESEND] ata_piix: IDE mode SATA patch
for
>Intel ICH9
>
>Jason Gaston wrote:
>> This patch adds the Intel ICH9 IDE mode SATA controller DID's.
>>
>> Signed-off-by:  Jason Gaston <jason.d.gaston@intel.com>
>>
>> --- linux-2.6.19-rc6/drivers/ata/ata_piix.c.orig	2006-11-20
>04:58:48.000000000 -0800
>> +++ linux-2.6.19-rc6/drivers/ata/ata_piix.c	2006-11-20
>06:15:12.000000000 -0800
>
>Yeap, it came through fine this time, but ich8 and ich9 are identical
>from ata_piix's point of view.  Don't add ich9_sata_ahci, just use
>ich8_sata_ahci.
>
>--
>tejun

From: "Gaston, Jason D" <jason.d.gaston@intel.com>
Subject: RE: [PATCH 2.6.19-rc6] ahci: AHCI mode SATA patch for Intel ICH9
Date: Wed, 22 Nov 2006 08:17:17 -0800
Message-ID: <39B20DF628532344BC7A2692CB6AEE07A5A41E@orsmsx420.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:56892 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1755314AbWKVQRT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Nov 2006 11:17:19 -0500
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

I don't know the specifics of that discussion.  If you are asking about
using class code rather then a DID; that would work for ICH9.

Thanks,

Jason



>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
>owner@vger.kernel.org] On Behalf Of Arjan van de Ven
>Sent: Wednesday, November 22, 2006 1:04 AM
>To: Gaston, Jason D
>Cc: jgarzik@pobox.com; linux-ide@vger.kernel.org; linux-
>kernel@vger.kernel.org
>Subject: Re: [PATCH 2.6.19-rc6] ahci: AHCI mode SATA patch for Intel
ICH9
>
>On Tue, 2006-11-21 at 14:51 -0800, Jason Gaston wrote:
>> This patch adds the Intel ICH9 AHCI controller DID's for SATA
support.
>>
>> Signed-off-by:  Jason Gaston <jason.d.gaston@intel.com>
>
>there was some discussion about a generic class match for ahci...
>would these devices be matched by that?
>
>
>--
>if you want to mail me at work (you don't), use arjan (at)
linux.intel.com
>Test the interaction between Linux and your BIOS via
>http://www.linuxfirmwarekit.org
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

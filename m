From: "Gaston, Jason D" <jason.d.gaston@intel.com>
Subject: RE: [PATCH 2.6.23-rc4][reRESEND] ata_piix: IDE mode SATA patch for Intel Tolapai
Date: Fri, 7 Sep 2007 16:42:12 -0700
Message-ID: <39B20DF628532344BC7A2692CB6AEE0701BCF3BF@orsmsx420.amr.corp.intel.com>
References: <200708302136.57215.jason.d.gaston@intel.com> <46D7C856.5070901@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:43678 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751696AbXIGXmO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Sep 2007 19:42:14 -0400
Content-class: urn:content-classes:message
In-Reply-To: <46D7C856.5070901@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, htejun@gmail.com

>-----Original Message-----
>From: Jeff Garzik [mailto:jeff@garzik.org]
>Sent: Friday, August 31, 2007 12:51 AM
>To: Gaston, Jason D
>Cc: linux-ide@vger.kernel.org; linux-kernel@vger.kernel.org;
>htejun@gmail.com
>Subject: Re: [PATCH 2.6.23-rc4][reRESEND] ata_piix: IDE mode SATA patch
for
>Intel Tolapai
>
>Jason Gaston wrote:
>> Resend trying to remove 8-bit characters in the email.
>>
>> This patch adds the Intel Tolapai IDE mode SATA controller DID's.
>>
>> Signed-off-by:  Jason Gaston <jason.d.gaston@intel.com>
>
>applied

Jeff,

I just noticed that the following section came through as spaces instead
of tabs.  Do I need to resend a corrected version?

+static const struct piix_map_db tolapai_map_db = {
+        .mask = 0x3,
+        .port_enable = 0x3,
+        .map = {
+                /* PM   PS   SM   SS       MAP */
+                {  P0,  NA,  P1,  NA }, /* 00b */
+                {  RV,  RV,  RV,  RV }, /* 01b */
+                {  RV,  RV,  RV,  RV }, /* 10b */
+                {  RV,  RV,  RV,  RV },
+        },
+};
+

Thanks,

Jason

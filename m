From: "Gaston, Jason D" <jason.d.gaston@intel.com>
Subject: RE: SATA PMP support in 2.6.24-rc3?
Date: Thu, 29 Nov 2007 16:24:15 -0800
Message-ID: <39B20DF628532344BC7A2692CB6AEE07020AE7A8@orsmsx420.amr.corp.intel.com>
References: <39B20DF628532344BC7A2692CB6AEE070201BD83@orsmsx420.amr.corp.intel.com> <474CC423.70705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:35139 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760702AbXK3A0P convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Nov 2007 19:26:15 -0500
Content-class: urn:content-classes:message
In-Reply-To: <474CC423.70705@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

>Gaston, Jason D wrote:
>> Does 2.6.24-rc3 support SATA port multipliers?
>>
>> I am getting "ata6.03: COMRESET failed (errno=-5)" error messages
with a
>> SiliconImage PMP connected to an Intel ICH9 SATA controller in AHCI
>> mode.
>
>Yeah, it should work.
>
>> Dmesg output attached.
>
>Eeek.. Can you please tell me more about the configuration?  Which
>devices are connected to which downstream port, etc...
>
>Thanks.
>
>--
>tejun

I have tried connecting the PMP to several of the ICH9 ports, with no
change.  

Right now, on ICH9, I have:
-LH-20A1S DVD on ICH9 port0
-ST3320620AS HD on ICH9 port1
-Sil3726CBHU PMP on ICH9 port2

On the Sil3726 PMP, I have:
-ST3750640NS HD on PMP port0
-ST3750640NS HD on PMP port1

Thanks,

Jason

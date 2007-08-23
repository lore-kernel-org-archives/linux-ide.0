From: Tejun Heo <htejun@gmail.com>
Subject: Re: no need to add new DID's to AHCI driver?
Date: Thu, 23 Aug 2007 09:53:20 +0900
Message-ID: <46CCDA80.7040109@gmail.com>
References: <39B20DF628532344BC7A2692CB6AEE0701AE8117@orsmsx420.amr.corp.intel.com> <46CC8C31.3040502@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:60368 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419AbXHWAx2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Aug 2007 20:53:28 -0400
Received: by wa-out-1112.google.com with SMTP id v27so386465wah
        for <linux-ide@vger.kernel.org>; Wed, 22 Aug 2007 17:53:28 -0700 (PDT)
In-Reply-To: <46CC8C31.3040502@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "Gaston, Jason D" <jason.d.gaston@intel.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Gaston, Jason D wrote:
>> Hello,
>>
>> Now that the AHCI driver has support for all controllers with the 0x0106
>> (AHCI) class code, I am not planning on adding controller DeviceID's for
>> AHCI controllers.  I want to verify that this is the correct course of
>> action.
>>
>> Note:  I still will have to add the Intel SW "RAID" controller
>> DeviceID's as they have a 0x0104 (RAID) class code.
> 
> Yep, that's fine -- and the encouraged direction.
> 
> The ideal situation for users is when new hardware is "automagically"
> supported, without needing any driver PCI ID modifications at all.

One remaining hurdle tho is the distinction between board_ahci and
board_ahci_pi (whether to honor PORTS_IMPL or not).  AHCI class matching
uses board_ahci so PI will be ignored by default.  There's a pending
patch which removes this distinction, so this won't be a problem after
the patch is merged.

-- 
tejun

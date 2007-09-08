From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.23-rc4][reRESEND] ahci: RAID mode SATA patch for Intel
 Tolapai
Date: Sat, 08 Sep 2007 14:51:59 +0900
Message-ID: <46E2387F.4020404@gmail.com>
References: <200708302127.19535.jason.d.gaston@intel.com> <46D7C783.8050803@pobox.com> <39B20DF628532344BC7A2692CB6AEE0701B9A4CA@orsmsx420.amr.corp.intel.com> <46E1D313.2060302@pobox.com> <39B20DF628532344BC7A2692CB6AEE0701BCF3B5@orsmsx420.amr.corp.intel.com> <46E1E559.4000702@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:41515 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753536AbXIHRGo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Sep 2007 13:06:44 -0400
Received: by wa-out-1112.google.com with SMTP id v27so939980wah
        for <linux-ide@vger.kernel.org>; Sat, 08 Sep 2007 10:06:43 -0700 (PDT)
In-Reply-To: <46E1E559.4000702@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Gaston, Jason D" <jason.d.gaston@intel.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Gaston, Jason D wrote:
>> At this time, I don't have any way to test those particular DeviceID's
>> and I know that the AHCI mode DeviceID works by using the class code
>> support.  So, I would like to just leave them at they are, if that is
>> ok.
> 
> 
> Fine by me...  Overall I'll follow "vendor's best advice" here :)

The distinction between board_ahci and board_ahci_pi has been removed in
#upstream anyway, so it doesn't matter too much anyway.

Thanks.

-- 
tejun


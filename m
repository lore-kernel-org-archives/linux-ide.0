From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Soft-reset on a FIS-Based-Switching AHCI interface
Date: Wed, 14 Sep 2011 01:04:32 -0400
Message-ID: <4E7035E0.3000408@garzik.org>
References: <4E6E1105.6060103@plxtech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f42.google.com ([209.85.212.42]:63081 "EHLO
	mail-vw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248Ab1INFMe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Sep 2011 01:12:34 -0400
Received: by vwl1 with SMTP id 1so2006757vwl.1
        for <linux-ide@vger.kernel.org>; Tue, 13 Sep 2011 22:12:33 -0700 (PDT)
In-Reply-To: <4E6E1105.6060103@plxtech.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Crewe <rcrewe@plxtech.com>
Cc: linux-ide@vger.kernel.org, Shane Huang <Shane.Huang@amd.com>

On 09/12/2011 10:02 AM, Richard Crewe wrote:
> The AHCI spec. seems to indicate that a soft-reset can only be performed
> if FBS is disabled.

Can you cite section numbers / specific references for this?


> Looking at the LibATA and LibAHCI code at the moment, I can't see where
> this is done. The soft-reset happens during error recovery when the port
> re-enumerates devices.
>
> Am I missing something or is this a _relatively_ less-well tested area
> of the LibATA/AHCI operation?

I cannot see where FBS is disabled for soft-reset, either.

FBS is pretty new, hasn't changed much at all since its initial 
implementation on an AMD reference board, and is (obviously) only used 
with PMPs.  FBS is a pretty small subset of the total AHCI population, 
so I doubt the code is exercised heavily except for a very few, large 
storage installations.

	Jeff





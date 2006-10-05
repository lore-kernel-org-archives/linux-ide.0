From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/2] ahci: preserve PORTS_IMPL over host resets
Date: Fri, 06 Oct 2006 00:02:39 +0900
Message-ID: <45251E8F.5000401@gmail.com>
References: <20060930122121.GR25800@htj.dyndns.org> <4524EC09.2070608@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:30409 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751472AbWJEPCc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 5 Oct 2006 11:02:32 -0400
Received: by py-out-1112.google.com with SMTP id n25so770975pyg
        for <linux-ide@vger.kernel.org>; Thu, 05 Oct 2006 08:02:31 -0700 (PDT)
In-Reply-To: <4524EC09.2070608@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, robbat2@gentoo.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Instead of writing 0xf blindly, preserve the content of write-once
>> PORTS_IMPL register over host resets.
>>
>> This patch is taken from Jeff Garzik's AHCI init update patch.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>> Cc: Jeff Garzik <jgarzik@pobox.com>
> 
> One reason why I didn't go ahead and apply this is for 
> uninitalized-by-BIOS cases that are the reason I originally hardcoded a 
> 0xf value into the register.
> 
> This patch is OK, iff we also include a test to see if impl_save==0 
> prior to global reset.  If that is the case, we should hardcode 0xf or 
> (1<<n_ports)-1

Will do.

-- 
tejun

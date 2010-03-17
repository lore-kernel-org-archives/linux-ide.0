From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes 2/3] ahci: clean up board IDs
Date: Wed, 17 Mar 2010 19:04:08 -0400
Message-ID: <4BA15FE8.9010609@garzik.org>
References: <4B98575C.5050508@kernel.org> <4B9857EA.5090101@kernel.org> <4BA11518.30500@garzik.org> <4BA15EA8.8000707@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:63604 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753122Ab0CQXEK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Mar 2010 19:04:10 -0400
Received: by gwaa12 with SMTP id a12so528079gwa.19
        for <linux-ide@vger.kernel.org>; Wed, 17 Mar 2010 16:04:10 -0700 (PDT)
In-Reply-To: <4BA15EA8.8000707@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, pchen@nvidia.com, kernel-bugzilla.20.drkshadow@spamgourmet.com

On 03/17/2010 06:58 PM, Tejun Heo wrote:
> Hello,
>
> On 03/18/2010 02:44 AM, Jeff Garzik wrote:
>> It actually makes merging a lot more difficult, considering that libahci
>> -- which includes large amounts of ahci code movement -- was committed
>> to #upstream a week before this patch was posted.
>>
>> Because of libahci changes, I think patch #2 (this patch) and patch #3
>> are more appropriate for #upstream.
>>
>> The "(pdev->vendor != PCI_VENDOR_ID_NVIDIA)" may be overly broad, but
>> it's not wrong for 2.6.34, IMO.
>
> Hmmm... the actual fix is in #3.  I'll prep separate patches for
> upstream and upstream-fixes.

What does it fix, specifically?  AFAICS, the patch changes the AHCI 
state from

	no FPDMA AA for all NVIDIA

to

	some FPDMA AA for NVIDIA

thus the current state of the code is not broken and in need of fixing, 
but merely overly conservative.  Am I missing something?

	Jeff




From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.25-rc8-mm2: CONFIG_ATA_SFF: panic involving	mount_block_root
 and down the road
Date: Sun, 13 Apr 2008 09:45:45 +0900
Message-ID: <480157B9.90801@gmail.com>
References: <20080410203354.f0a6f464.akpm@linux-foundation.org> <20080411234345.GA4742@martell.zuzino.mipt.ru> <20080412005917.GA4742@martell.zuzino.mipt.ru> <20080412065248.GA8849@cs181133002.pp.htv.fi> <480088AD.1040904@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0708.google.com ([209.85.198.250]:42110 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753492AbYDMAqG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Apr 2008 20:46:06 -0400
Received: by rv-out-0506.google.com with SMTP id k29so292164rvb.1
        for <linux-ide@vger.kernel.org>; Sat, 12 Apr 2008 17:46:05 -0700 (PDT)
In-Reply-To: <480088AD.1040904@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Adrian Bunk <bunk@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>, Jeff Garzik <jgarzik@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Jeff Garzik wrote:
>>> Now raise hands those who knew that your ATA controller is SFF
>>> compliant.

/me raises a hand.

>> Is there any technical reason why we have to bother users with the 
>> ATA_SFF option at all?
>>
>> It sounds like a perfect canndidate for being select'ed.
> 
> 'default y' is appropriate, but option that is used to disable a major 
> swath of legacy code unneeded on modern FIS-based SATA platforms like AHCI.

Heh.. yeah, but I have to admit SFF support is cryptic.  We can 
definitely use some friendly explanation there.

-- 
tejun

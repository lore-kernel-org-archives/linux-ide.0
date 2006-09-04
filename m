From: Tejun Heo <htejun@gmail.com>
Subject: Re: Kernel fix for ICH7M controller
Date: Mon, 04 Sep 2006 09:34:19 +0200
Message-ID: <44FBD6FB.4080603@gmail.com>
References: <44FAE630.20801@gmail.com> <44FB93B5.1020703@gmail.com> <44FBBD6F.5060709@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:60345 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932445AbWIDHfE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Sep 2006 03:35:04 -0400
Received: by py-out-1112.google.com with SMTP id n25so2508593pyg
        for <linux-ide@vger.kernel.org>; Mon, 04 Sep 2006 00:34:30 -0700 (PDT)
In-Reply-To: <44FBBD6F.5060709@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Jonathan Dieter <jdieter@gmail.com>, linux-ide@vger.kernel.org, fedora-devel-list@redhat.com

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Jonathan Dieter wrote:
>>> The ata_piix module doesn't detect that my laptop's disk controller 
>>> (Intel Corporation 82801GBM/GHM - ICH7 Family) is configured to have 
>>> PATA drives in the first two channels.  I looked at Intel's 
>>> documentation and they say that my controller isn't supposed to 
>>> support this configuration, but it's the default setup on this 
>>> laptop, there's no way to change it in the BIOS, and it works in 
>>> Windows, so I'm assuming this is a documentation error.
>>>
>>> This patch changes one line in ata_piix.c so that it sees this 
>>> configuration as valid (and therefore recognizes my drives).  I've 
>>> tested it on my laptop and the module is now working perfectly 
>>> (whereas the kernel was using the old IDE driver previously with no 
>>> DMA enabled).
>>
>> Hello,
>>
>> Interesting.  Can you post the result of 'lspci -n -vvv -xxx'?  I 
>> don't see why this support shouldn't go into mainline but wanna see if 
>> narrowing down the effect a bit (if PCI ID allows us to) would be a 
>> good idea.
> 
> FWIW several PCI devices use the ich6m info entry.  We may want to split 
> out ICH7M rather than assume other chips behave similarly.

Hello, Jeff.

The controller is reporting subsystem id 1025(Acer):0107.  Either we can 
enable that entry for all ICH7Ms or only for the Acer.  I'm more 
inclined to the former.  What do you think?

Thanks.

-- 
tejun

-- 
VGER BF report: H 6.45778e-11

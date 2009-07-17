From: Tejun Heo <tj@kernel.org>
Subject: Re: AHCI: connection status changed + hard resetting link with 2.6.30+
Date: Fri, 17 Jul 2009 11:30:42 +0900
Message-ID: <4A5FE252.2050806@kernel.org>
References: <4A4FD162.30604@gmail.com> <4A552185.7090301@kernel.org> <4A5546AA.8000404@gmail.com> <4A5D981F.9020404@kernel.org> <4A5DAD7E.8050309@gmail.com> <4A5EA2DD.7000905@kernel.org> <4A5F2F69.2050800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:40524 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933992AbZGQCa5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Jul 2009 22:30:57 -0400
In-Reply-To: <4A5F2F69.2050800@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Zdenek Kaspar <zkaspar82@gmail.com>
Cc: linux-ide@vger.kernel.org

Zdenek Kaspar wrote:
> Tejun Heo napsal(a):
>> Zdenek Kaspar wrote:
>>> Tejun Heo napsal(a):
>>>> Zdenek Kaspar wrote:
>>>>> Hello Tejun, thanks for your reply. Attaching logs from my testing machine..
>>>>>
>>>>> I see this behavior on ICH7R with i3000 chipset too:
>>>>> 00:1f.2 RAID bus controller [0104]: Intel Corporation 82801GR/GH (ICH7
>>>>> Family) SATA RAID Controller [8086:27c3] (rev 01)
>>>> Can you please apply the attached patch and report the resulting boot
>>>> log?  Thanks.
>> Can you please try the attached patch?
>>
>> Thanks.
> 
> Now it's fine. Thanks & attaching dmesg..
> 

Cool, I'll post the patch upstream.  As the problem isn't critical and
that part of code is pretty intricate, I'll schedule it for the next
merge window.

Thanks.

-- 
tejun

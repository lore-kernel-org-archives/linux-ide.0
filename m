From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.24.3: regular sata drive resets - worrisome?
Date: Sat, 29 Mar 2008 21:58:34 +0900
Message-ID: <47EE3CFA.2000707@gmail.com>
References: <200803201518.32109.hpj@urpla.net> <20080320214830.6d39876d.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:1935 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380AbYC2M6m (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 29 Mar 2008 08:58:42 -0400
Received: by wa-out-1112.google.com with SMTP id v27so863278wah.23
        for <linux-ide@vger.kernel.org>; Sat, 29 Mar 2008 05:58:42 -0700 (PDT)
In-Reply-To: <20080320214830.6d39876d.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Hans-Peter Jansen <hpj@urpla.net>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello, Hans.

Andrew Morton wrote:
>> since I upgraded to 2.6.24.3 on one of my production systems, I see 
>> regular device resets like these:
>>
>> Mar 20 14:33:03 lisa5 kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
>> Mar 20 14:33:03 lisa5 kernel: ata2.00: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 0
>> Mar 20 14:33:03 lisa5 kernel:          res 40/00:00:01:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)

Ouch, timeout on FLUSH_EXT.  Are all errors on cmd ea?

>> Should I be worried? smartd doesn't show anything suspicious on those.

Can you please post the result of "smartctl -a /dev/sdX"?

>> It's been 4 samsung drives at all hanging on a sata sil 3124:

FLUSH_EXT timing out usually indicates that the drive is having problem 
writing out what it has in its cache to the media.  There was one case 
where FLUSH_EXT timeout was caused by the driver failing to switch 
controller back from NCQ mode before issuing FLUSH_EXT but that was on 
sata_nv.  There hasn't been any similar problem on sata_sil24.

Thanks.

-- 
tejun

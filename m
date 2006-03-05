From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 5/6] sata_sil: convert sil_port[] to u16 from unsigned
 long
Date: Sun, 05 Mar 2006 16:48:29 +0900
Message-ID: <440A97CD.30404@gmail.com>
References: <1141542232248-git-send-email-htejun@gmail.com> <440A969A.5090503@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.178]:8752 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752090AbWCEHsd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Mar 2006 02:48:33 -0500
Received: by pproxy.gmail.com with SMTP id x31so567544pye
        for <linux-ide@vger.kernel.org>; Sat, 04 Mar 2006 23:48:33 -0800 (PST)
In-Reply-To: <440A969A.5090503@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Carlos.Pardo@siliconimage.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>> unsigned long is way too big for sil_port[] offsets (currently the
>> table is 256 bytes on 64bit machines).  Convert sil_port[] to u16.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> 
> NAK.  This just forces the compiler to promote these from u16 to machine 
> int (i.e. unsigned long) at addition time.  Table size is a very trivial 
> matter.
> 

Wouldn't that be cheaper than extra cache lines? I'm pretty sure it 
would be on x86/64.

-- 
tejun

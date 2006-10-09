From: Tejun Heo <htejun@gmail.com>
Subject: Re: Errors when copying between drives on a SiI3114 controller under
 kernel 2.6.18
Date: Mon, 09 Oct 2006 17:43:18 +0900
Message-ID: <452A0BA6.8030401@gmail.com>
References: <op.tg1yx12kxci36i@akima> <45287FA6.5020906@gmail.com> <op.tg3tyekpxci36i@akima> <452A0A86.8070107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:50016 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932367AbWJIIn2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 9 Oct 2006 04:43:28 -0400
Received: by nf-out-0910.google.com with SMTP id x30so1899799nfb
        for <linux-ide@vger.kernel.org>; Mon, 09 Oct 2006 01:43:26 -0700 (PDT)
In-Reply-To: <452A0A86.8070107@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jonathan Bell <doggs.lay.eggs@googlemail.com>
Cc: linux-ide@vger.kernel.org, Carlos Pardo <Carlos.Pardo@siliconimage.com>

Tejun Heo wrote:
> I cannot reproduce your problem here.  Can you retest after running the 
> following commands?
> 
> # setpci -s 01:07.0 0c.b=04
> # setpci -s 01:08.0 0c.b=04

I forgot something.

* You need to make sata_sil a module.  Boot, unload sata_sil if loaded, 
run above commands, load sata_sil and test.

* If above commands don't work, try =00 instead of =04.

Thanks.

-- 
tejun

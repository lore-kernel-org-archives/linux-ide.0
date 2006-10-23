From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sis only recognizing primary drive in 2.6.18
Date: Mon, 23 Oct 2006 11:14:57 +0900
Message-ID: <453C25A1.5010208@gmail.com>
References: <20061006065816.GA5782@jim.sh> <45263683.408@gmx.net> <45287D85.1050302@gmail.com> <453A8B66.8080302@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:61813 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751187AbWJWCPH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 22 Oct 2006 22:15:07 -0400
Received: by ug-out-1314.google.com with SMTP id o38so1143340ugd
        for <linux-ide@vger.kernel.org>; Sun, 22 Oct 2006 19:15:06 -0700 (PDT)
In-Reply-To: <453A8B66.8080302@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Uwe Koziolek <uwe.koziolek@gmx.net>
Cc: Jim Paris <jim@jtan.com>, linux-ide@vger.kernel.org, muthas@mit.edu, fragmede@gmail.com, David Wang <touch@sis.com>

Uwe Koziolek wrote:
> Hi,
> 
> I have tested the patch with separate port_info and a patch only adding
> the flag ATA_FLAG_SLAVE_POSS for all controllers.
> The result  is allways  the  same.  The second sata disk  is allways
> /dev/sdb. libata handles this  correctly.
> 
> So i am not sure, that the separate port_info is really necessary. My
> assumption is a ATA_FLAG_SLAVE_POSS
> is sufficient for a correct handling.
> 
> If i am wrong, i will send a patch with separate port_info .

It might be sufficient to just add ATA_FLAG_SLAVE_POSS for all 
controllers but in general we don't want to sprinkle that flag over 
controllers which don't actually support slave device - sometimes for 
safety and also for documentation purpose.  So, please make a separate 
port_info and add ATA_FLAG_SLAVE_POSS only to controllers which actually 
support slave devices.

Thanks.

-- 
tejun

From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 4/4] libata: make libata use printk_header() and mprintk
Date: Wed, 16 Jan 2008 11:53:42 +0900
Message-ID: <478D71B6.7000400@gmail.com>
References: <1200445210549-git-send-email-htejun@gmail.com>	<12004452112326-git-send-email-htejun@gmail.com> <20080115184819.78069cce.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:27636 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757591AbYAPCxt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Jan 2008 21:53:49 -0500
Received: by wa-out-1112.google.com with SMTP id v27so146696wah.23
        for <linux-ide@vger.kernel.org>; Tue, 15 Jan 2008 18:53:48 -0800 (PST)
In-Reply-To: <20080115184819.78069cce.randy.dunlap@oracle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-kernel@vger.kernel.org, daniel.ritz-ml@swissonline.ch, jeff@garzik.org, linux-ide@vger.kernel.org

Randy Dunlap wrote:
>> -			ata_dev_printk(dev, KERN_WARNING,
>> -"Drive reports diagnostics failure. This may indicate a drive\n");
>> -			ata_dev_printk(dev, KERN_WARNING,
>> -"fault or invalid emulation. Contact drive vendor for information.\n");
>> -		}
> 
> Looks to me like several of these + lines have indent problems:
> following lines (i.e., not first line) of function call should be
> indented more than the first line:

Putting one more tab would put good part of those lines off the 80col
limit.  Hmmm... but I agree it looks ugly.  I'll add one or two spaces
there.

>> +		ata_dev_printk(dev, KERN_WARNING,
>> +		"Drive reports diagnostics failure. This may indicate a drive\n"
>> +		"fault or invalid emulation. Contact drive vendor for information.\n");

Thanks.

-- 
tejun

From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 05/12] ahci: implement SCR_NOTIFICATION r/w
Date: Fri, 13 Jul 2007 20:53:11 +0900
Message-ID: <469767A7.3070406@gmail.com>
References: <1183283617130-git-send-email-htejun@gmail.com> <468A5DD2.3040309@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:53113 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755847AbXGMLxR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Jul 2007 07:53:17 -0400
Received: by wa-out-1112.google.com with SMTP id v27so545701wah
        for <linux-ide@vger.kernel.org>; Fri, 13 Jul 2007 04:53:16 -0700 (PDT)
In-Reply-To: <468A5DD2.3040309@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>

Jeff Garzik wrote:
> Tejun Heo wrote:
>> @@ -1698,12 +1705,13 @@ static void ahci_print_info(struct ata_host
>> *host)
>>  
>>      dev_printk(KERN_INFO, &pdev->dev,
>>          "flags: "
>> -               "%s%s%s%s%s%s"
>> -               "%s%s%s%s%s%s%s\n"
>> +        "%s%s%s%s%s%s%s"
>> +        "%s%s%s%s%s%s%s\n"
>>                 ,
>>  
>>          cap & (1 << 31) ? "64bit " : "",
>>          cap & (1 << 30) ? "ncq " : "",
>> +        cap & (1 << 29) ? "sntf " : "",
> 
> ACK, although it is not clear to me why both "%s%s%s" lines are changed.
>  whitespace addition, perhaps?

Actually, it was minor cleanup converting eight spaces into a tab.  I'll
note it in the commit message.

-- 
tejun

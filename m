From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] Fix pointer arithmetic in hpt3xx driver code (3rd try)
Date: Sun, 07 Sep 2008 15:20:41 +0400
Message-ID: <48C3B909.3030405@ru.mvista.com>
References: <20080906171850.GF26371@google.com> <48C39D2F.4010701@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:15349 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753170AbYIGLUs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 7 Sep 2008 07:20:48 -0400
In-Reply-To: <48C39D2F.4010701@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Masoud Sharbiani <masouds@google.com>
Cc: bzolnier@gmail.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello, I wrote:
>> diff --git a/drivers/ide/pci/hpt366.c b/drivers/ide/pci/hpt366.c
>> index eb107ee..4eae284 100644
>> --- a/drivers/ide/pci/hpt366.c
>> +++ b/drivers/ide/pci/hpt366.c
>> @@ -613,6 +613,14 @@ static int check_in_drive_list(ide_drive_t 
>> *drive, const char **list)
>>      return 0;
>>  }
>>  
>> +static struct hpt_info *hpt3xx_get_info(struct device *dev)
>> +{
>> +    struct ide_host *host    = pci_get_drvdata(to_pci_dev(pci_dev));
>>   
>
>   Oops, this just won't compile. :-/

   BTW, there's no need to invoke to_pci_dev() at all since 
pci_get_drvdata(dev) boils down to dev_get_drvdata(&dev->dev) call. So, 
in order not to waste time on useless pointer tricks, we should just 
invoke the latter here.

>   And please re-consider passing 'struct pci_dev *' to this function 
> since it's pre-calculated by the callers and is used by them otherwise 
> in 5 (not even 4) cases out of 7.
>

   Well, since to_pci_dev() is unnecessary here, I'm taking my request 
back. :-)

MBR, Sergei



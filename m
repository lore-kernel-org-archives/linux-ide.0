From: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: Re: [PATCH v2]ata:ahci.c Fix warning: comparison between 'enum <anonymous>'
 and 'enum <anonymous>'
Date: Wed, 30 Jun 2010 00:06:43 -0700
Message-ID: <4C2AED03.7070103@gmail.com>
References: <1277879827-18233-1-git-send-email-justinmattock@gmail.com> <4C2AE8FE.3020409@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:43410 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589Ab0F3HG2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jun 2010 03:06:28 -0400
Received: by pvc7 with SMTP id 7so227570pvc.19
        for <linux-ide@vger.kernel.org>; Wed, 30 Jun 2010 00:06:28 -0700 (PDT)
In-Reply-To: <4C2AE8FE.3020409@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

On 06/29/2010 11:49 PM, Tejun Heo wrote:
> Hello,
>
> On 06/30/2010 08:37 AM, Justin P. Mattock wrote:
>> The below patch fixes a warning message during compiling of the kernel
>>    CC      drivers/ata/ahci.o
>> drivers/ata/ahci.c: In function 'ahci_init_one':
>> drivers/ata/ahci.c:1045:2: warning: comparison between 'enum<anonymous>' and 'enum<anonymous>'
>>
>>   Signed-off-by: Justin P. Mattock<justinmattock@gmail.com>
>
> Hmm, is this something we wanna go around the kernel and updating
> sources?  Or should we just flick a gcc option?
>

the flick a gcc option seems easier todo, but my guess its probably not 
the right way of dealing with the issue(even a warning).

>> @@ -1038,11 +1038,11 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>>   	struct device *dev =&pdev->dev;
>>   	struct ahci_host_priv *hpriv;
>>   	struct ata_host *host;
>> -	int n_ports, i, rc;
>> +	int n_ports, i, rc, sum = AHCI_MAX_CMDS;
>>
>>   	VPRINTK("ENTER\n");
>>
>> -	WARN_ON(ATA_MAX_QUEUE>  AHCI_MAX_CMDS);
>> +	WARN_ON(ATA_MAX_QUEUE>  sum);
>
> And, just do WARN_ON((int)ATA_MAX_QUEUE>  (int)AHCI_MAX_CMDS)
>
> Thanks.
>

that builds clean. keep in mind I just compile tested, no rebooting or 
anything. Should I just resend with what you posted, and call it that, 
or is this something that needs more?

Justin P. Mattock

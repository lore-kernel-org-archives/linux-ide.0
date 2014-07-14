From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] MAINTAINERS: Add Hans de Goede as ahci-platform maintainer
Date: Mon, 14 Jul 2014 15:38:47 +0200
Message-ID: <53C3DD67.40806@redhat.com>
References: <1405344142-3051-1-git-send-email-hdegoede@redhat.com> <1405344142-3051-2-git-send-email-hdegoede@redhat.com> <53C3DAA3.8000900@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:30593 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754225AbaGNNiy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 14 Jul 2014 09:38:54 -0400
In-Reply-To: <53C3DAA3.8000900@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

Hi,

On 07/14/2014 03:26 PM, Sergei Shtylyov wrote:
> Hello.
> 
> On 07/14/2014 05:22 PM, Hans de Goede wrote:
> 
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   MAINTAINERS | 9 +++++++++
>>   1 file changed, 9 insertions(+)
> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 6813d0a..5396f54 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -8007,6 +8007,15 @@ F:    drivers/ata/
>>   F:    include/linux/ata.h
>>   F:    include/linux/libata.h
>>
>> +SERIAL ATA AHCI PLATFORM devices support
>> +M:    Hans de Goede <hdegoede@redhat.com>
>> +M:    Tejun Heo <tj@kernel.org>
>> +L:    linux-ide@vger.kernel.org
>> +T:    git git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git
>> +S:    Supported
>> +F:    drivers/ata/ahci_platform.c
>> +F:    drivers/ata/libahci_platform.c
> 
>    You've also missed include/linux/ahci_platform.h

Thanks, my bad. V3 coming up. Who knew adding a MAINTAINERS entry
could be so hard :)

Regards,

Hans

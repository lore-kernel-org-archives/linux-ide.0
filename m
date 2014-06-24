From: "kefeng.wang" <kefeng.wang@linaro.org>
Subject: Re: [PATCH] ahci: disable ncq feature for hisilicon sata
Date: Tue, 24 Jun 2014 15:11:09 +0800
Message-ID: <53A9248D.8020902@linaro.org>
References: <1398416351-30567-1-git-send-email-kefeng.wang@linaro.org> <20140514170757.GD15690@htj.dyndns.org> <5396D529.308@linaro.org> <5396D8C9.6020607@linaro.org> <53970E81.1070608@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:63734 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbaFXHMH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Jun 2014 03:12:07 -0400
Received: by mail-pb0-f45.google.com with SMTP id rr13so6868117pbb.32
        for <linux-ide@vger.kernel.org>; Tue, 24 Jun 2014 00:12:07 -0700 (PDT)
In-Reply-To: <53970E81.1070608@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Zhangfei Gao <zhangfei.gao@linaro.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com, xuwei5@hisilicon.com

On 2014-6-10 21:56, Hans de Goede wrote:
> Hi Kefeng,
> 
> On 06/10/2014 12:07 PM, kefeng.wang wrote:
>> Hi Tejun,
>>
>> I have a question, the hip04 and hix5hd2 soc use the old version of IP, but they
>> also have a new version of IP which support FBS and NCQ, and now the new one is
>> used by a new soc. How can I distinguish them, use "hisilicon,hisi-ahci-vX" or just
>> add "generic-ahci" string for the IP which is conformant with spec and has
>> no special customization and issue? Any advices, thanks.
> 
> Please use "hisilicon,hisi-ahci-vX", this way it will be easier to add any
> special behavior in case this turns out to be necessary later.

OK, thanks for your guidance. If necessary, we will use hisi-ahci-vX for hisi's IP.

Hi Tejun, could you merger this patch please? thanks.

Regards,
Kefeng

> 
> Regards,
> 
> Hans
> 


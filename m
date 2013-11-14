From: xiangliang yu <yxlraid@gmail.com>
Subject: Re: [PATCH 1/1] AHCI: disabled FBS prior to issuing software reset
Date: Thu, 14 Nov 2013 08:26:54 +0800
Message-ID: <CAP0P+NU418LriZufDj2TdbvTT3_xBOLeX9nSdkswvowdx-AZMw@mail.gmail.com>
References: <CAP0P+NUQSByVNquY-zP3S-6GKhSvQXgq_4dDCTd2R8FM=YC_Gg@mail.gmail.com>
	<20131027115703.GH14934@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bk0-f48.google.com ([209.85.214.48]:53897 "EHLO
	mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157Ab3KNA05 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Nov 2013 19:26:57 -0500
In-Reply-To: <20131027115703.GH14934@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, yuxiangl@marvell.com

hi
how about this patch? do you have any update? thanks!


> On Wed, Oct 16, 2013 at 11:36:20AM2013/10/27 Tejun Heo <tj@kernel.org>:
> Hello,
> +0800, xiangliang yu wrote:
>> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
>> index 34c8216..fbe592f 100644
>> --- a/drivers/ata/libahci.c
>> +++ b/drivers/ata/libahci.c
>> @@ -1266,9 +1266,11 @@ int ahci_do_softreset(struct ata_link *link,
>> unsigned int *class,
>
> Your patch is still completely white space corrupted.  Please check
> your mail settings.  Using git-send-email is usually a good idea.  I'm
> applying the patch manually this time but *please* make sure your mail
> setup is working before posting things next time.
>
> Thanks.
>
> --
> tejun

From: "kefeng.wang" <kefeng.wang@linaro.org>
Subject: Re: [PATCH v6 3/3] ahci: add support for Hisilicon sata
Date: Wed, 14 May 2014 14:12:55 +0800
Message-ID: <53730967.6030403@linaro.org>
References: <1398416351-30567-1-git-send-email-kefeng.wang@linaro.org> <1398416351-30567-4-git-send-email-kefeng.wang@linaro.org> <20140513190427.GA28815@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:47327 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753073AbaENGNP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 May 2014 02:13:15 -0400
Received: by mail-pb0-f47.google.com with SMTP id un15so1270427pbc.20
        for <linux-ide@vger.kernel.org>; Tue, 13 May 2014 23:13:15 -0700 (PDT)
In-Reply-To: <20140513190427.GA28815@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com, xuwei5@hisilicon.com

On 2014-5-14 3:04, Tejun Heo wrote:
> On Fri, Apr 25, 2014 at 04:59:11PM +0800, Kefeng Wang wrote:
>> The hip04 SoC of hisilicon has an AHCI compliant SATA controller,
>> and it is compliant with the ahci 1.3 and sata 3.0 specification.
>>
>> There is a wrong bit in HOST_CAP of hip04 sata controller, which
>> enable unsupported feature of FBS, use AHCI_HFLAG_NO_FBS hflag to
>> disable it.
>>
>> Signed-off-by: Kefeng Wang <kefeng.wang@linaro.org>
> 
> Doesn't apply to libata/for-3.16.  Please refresh.

Send new patches, rebased onto libata/for-3.16, based on commit: 58eb8cd565af.
Is this OK, if not, please let me know, thanks.

> 
> Thanks.
> 


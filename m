From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: failures due to "libata: disable forced PORTS_IMPL for >= AHCI
 1.3 patch"
Date: Wed, 23 Mar 2016 19:06:25 +0000
Message-ID: <56F2E931.7010805@linaro.org>
References: <56F2C60A.5070504@linaro.org>
 <CAKgsxVQ8HQKNWYNBr3FtKS=iyn838UW6TG5NDeacAg7ZKEx_gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37472 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754437AbcCWTG3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Mar 2016 15:06:29 -0400
Received: by mail-wm0-f41.google.com with SMTP id p65so36729213wmp.0
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2016 12:06:28 -0700 (PDT)
In-Reply-To: <CAKgsxVQ8HQKNWYNBr3FtKS=iyn838UW6TG5NDeacAg7ZKEx_gA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Justin Maggard <jmaggard10@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, hdegoede@redhat.com, mikpelinux@gmail.com



On 23/03/16 18:28, Justin Maggard wrote:
> On Wed, Mar 23, 2016 at 9:36 AM, Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
>> Hi Tejun,
>>
>> Its bit late but just found that commit 566d18 "libata: disable forced
>> PORTS_IMPL for >= AHCI 1.3" is breaking AHCI on Qualcomm APQ8064 platforms
>> in the mainline kernel (arch/arm/boot/dts/qcom-apq8064.dtsi).
>>
>> This platform uses "generic-ahci" platform driver and reports AHCI version
>> as 0x10300, and PORTS_IMPL is never set, so the existing workaround was
>> correct for this platform, however the latest patch broken this.
>>
>> There are few ways to fix this issue,
>>
>> 1> Add new compatible string to achi_platform driver so that this platform
>> can force the port_map,
>>
>> Or
>>
>> 2> Have a generic dt binding to force the port map.
>>
>
> A generic dt binding is probably a better way forward.  The Annapurna
> Alpine platform seems to have the same issue.

+1 for generic bindings.

I suspected that other platforms would also hit the same issue.

--srini
>
> -Justin
>

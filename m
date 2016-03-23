From: Justin Maggard <jmaggard10@gmail.com>
Subject: Re: failures due to "libata: disable forced PORTS_IMPL for >= AHCI
 1.3 patch"
Date: Wed, 23 Mar 2016 11:28:40 -0700
Message-ID: <CAKgsxVQ8HQKNWYNBr3FtKS=iyn838UW6TG5NDeacAg7ZKEx_gA@mail.gmail.com>
References: <56F2C60A.5070504@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:34177 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430AbcCWS2l (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Mar 2016 14:28:41 -0400
Received: by mail-io0-f194.google.com with SMTP id p21so3719354ioe.1
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2016 11:28:41 -0700 (PDT)
In-Reply-To: <56F2C60A.5070504@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, hdegoede@redhat.com, mikpelinux@gmail.com

On Wed, Mar 23, 2016 at 9:36 AM, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
> Hi Tejun,
>
> Its bit late but just found that commit 566d18 "libata: disable forced
> PORTS_IMPL for >= AHCI 1.3" is breaking AHCI on Qualcomm APQ8064 platforms
> in the mainline kernel (arch/arm/boot/dts/qcom-apq8064.dtsi).
>
> This platform uses "generic-ahci" platform driver and reports AHCI version
> as 0x10300, and PORTS_IMPL is never set, so the existing workaround was
> correct for this platform, however the latest patch broken this.
>
> There are few ways to fix this issue,
>
> 1> Add new compatible string to achi_platform driver so that this platform
> can force the port_map,
>
> Or
>
> 2> Have a generic dt binding to force the port map.
>

A generic dt binding is probably a better way forward.  The Annapurna
Alpine platform seems to have the same issue.

-Justin

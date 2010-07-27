From: Tejun Heo <tj@kernel.org>
Subject: Re: support for drives larger than 2TiB
Date: Tue, 27 Jul 2010 10:41:36 +0200
Message-ID: <4C4E9BC0.6060805@kernel.org>
References: <4C4AB952.9030705@kernel.org> <SNT125-W4469FAC3FE110BB4882949C3A40@phx.gbl> <4C4BEF61.5010203@kernel.org> <4C4BF0D2.1070503@zytor.com> <4C4BF3C2.1020009@kernel.org> <4C4C87EF.5080605@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42618 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753905Ab0G0Il5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Jul 2010 04:41:57 -0400
In-Reply-To: <4C4C87EF.5080605@zytor.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Yuhong Bao <yuhongbao_386@hotmail.com>, jeff@garzik.org, ben.collins@ubuntu.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, hmh@debian.org

Hello,

On 07/25/2010 08:52 PM, H. Peter Anvin wrote:
> If you can set up the disk with GPT then just set up a bootable
> partition beyond the 2 TiB mark and install Syslinux 4 on it.  (Note:
> there is a bug in current versions of gdisk: attribute 2 is the legacy
> BIOS bootable attribute, but the author got the bit order wrong and so
> you have to set "attribute 61".  parted doesn't support the legacy BIOS
> bootable attribute yet.)
>
> If you don't want tomodify the contents of the disk then it can still be
> tested, but I don't have a ready-made test for you.

The disk doesn't contain any data.  I'll try it with several different
motherboards and report back.

Thanks.

-- 
tejun

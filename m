From: Tejun Heo <tj@kernel.org>
Subject: Re: support for drives larger than 2TiB
Date: Sun, 25 Jul 2010 10:01:37 +0200
Message-ID: <4C4BEF61.5010203@kernel.org>
References: <4C4AB952.9030705@kernel.org> <SNT125-W4469FAC3FE110BB4882949C3A40@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37778 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751364Ab0GYIB4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 25 Jul 2010 04:01:56 -0400
In-Reply-To: <SNT125-W4469FAC3FE110BB4882949C3A40@phx.gbl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yuhong Bao <yuhongbao_386@hotmail.com>
Cc: jeff@garzik.org, ben.collins@ubuntu.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, hmh@debian.org, "H. Peter Anvin" <hpa@zytor.com>

(cc'ing hpa, hi!)
Hello,

On 07/24/2010 08:40 PM, Yuhong Bao wrote:
>> However, 2TiB limit is
>> inherent in the BIOS programming interface and currently the only way
>> to overcome it is using a completely different BIOS interface (EFI,
>> that is).
>
> Nope, look at the Int13 extensions, it already support 64-bit LBA.

Ah, yeah, that sounds much more logical than requiring transition to
EFI.  Does anyone know how wide spread the support for this extension
is in BIOSes?  Do the bootloaders support this?

Thanks.

-- 
tejun

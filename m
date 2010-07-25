From: Alex Buell <alex.buell@munted.org.uk>
Subject: Re: support for drives larger than 2TiB
Date: Sun, 25 Jul 2010 09:26:24 +0100
Message-ID: <1280046384.2139.0.camel@lithium.local.net>
References: <4C4AB952.9030705@kernel.org>
	 <SNT125-W4469FAC3FE110BB4882949C3A40@phx.gbl> <4C4BEF61.5010203@kernel.org>
	 <4C4BF0D2.1070503@zytor.com>
Reply-To: alex.buell@munted.org.uk
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from v-smtp-auth-relay-3.gradwell.net ([79.135.125.42]:37126 "EHLO
	v-smtp-auth-relay-3.gradwell.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751887Ab0GYI07 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 25 Jul 2010 04:26:59 -0400
In-Reply-To: <4C4BF0D2.1070503@zytor.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Tejun Heo <tj@kernel.org>, Yuhong Bao <yuhongbao_386@hotmail.com>, jeff@garzik.org, ben.collins@ubuntu.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, hmh@debian.org

On Sun, 2010-07-25 at 01:07 -0700, H. Peter Anvin wrote:
> 
> Syslinux 4 supports it with full 64-bit capabilities.  SeaBIOS (used
> in
> Qemu/KVM) supports it, and I know at least some hardware/firmware RAID
> solutions support it; I recently got access to a 3 TB SATA drive but
> due to NDA requirements I can't reveal the results of that testing. 

Yes but is it possible to boot from a complete 4k sector with the new
standards? 
-- 
http://www.munted.org.uk

One very high maintenance cat living here.

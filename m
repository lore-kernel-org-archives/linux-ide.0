From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 09/14] ata: Use 32bit DMA in AHCI for Loongson 3.
Date: Mon, 18 Jun 2012 16:52:31 +0200
Message-ID: <20120618145231.GA4377@x1.osrc.amd.com>
References: <1339747801-28691-1-git-send-email-chenhc@lemote.com>
 <1339747801-28691-10-git-send-email-chenhc@lemote.com>
 <4FDB08AC.8010208@mvista.com>
 <CAAhV-H6AKp+aGUozOxQoLgGYQ+GtHMbKKC4MVkFA570zodjgDA@mail.gmail.com>
 <20120617120557.GE31534@liondog.tnic>
 <CAAhV-H67M5xH+HMyVNopm=TPhei24NfnzNqiPMA+Ucz4Y7V3hg@mail.gmail.com>
 <20120618101030.GA24308@liondog.tnic>
 <CAAhV-H5g2Y81fr=yU76RHDfzDSxG_7GpTs=RZm8ha8JbzHnfzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:34355 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751220Ab2FROwc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 18 Jun 2012 10:52:32 -0400
Content-Disposition: inline
In-Reply-To: <CAAhV-H5g2Y81fr=yU76RHDfzDSxG_7GpTs=RZm8ha8JbzHnfzQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Huacai Chen <chenhuacai@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>, Zhangjin Wu <wuzhangjin@gmail.com>, Huacai Chen <chenhc@lemote.com>, Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>, linux-ide@vger.kernel.org

On Mon, Jun 18, 2012 at 06:41:58PM +0800, Huacai Chen wrote:
> Ohh, this is because Loongson-3 has a hardware bug, when the HT
> controller receive a 64-bit DMA address, the high bits is lost. So set
> to 32-bit DMA is just a workaround.

Ok, this should definitely go into the commit message of your patch then
since it explains why you need that flag set.

Thanks.

-- 
Regards/Gruss,
Boris.

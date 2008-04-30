From: Alek Du <alek.du@intel.com>
Subject: Re: [PATCH] ata: Add Intel SCH PATA support (revised)
Date: Wed, 30 Apr 2008 10:49:31 +0800
Message-ID: <20080430104931.3aaab288@dxy.sh.intel.com>
References: <20080426140007.63cfeede@dxy.sh.intel.com>
	<20080428094123.59d055c7@core>
	<20080428170751.097bdbe6@dxy.sh.intel.com>
	<200804282101.33012.bzolnier@gmail.com>
	<20080429113905.757703fd@dxy.sh.intel.com>
	<48174EF9.8020208@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:44247 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752825AbYD3C4W (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Apr 2008 22:56:22 -0400
In-Reply-To: <48174EF9.8020208@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, jgarzik@pobox.com, linux-ide@vger.kernel.org, rob.rhoads@intel.com

Hi Sergei,

On Wed, 30 Apr 2008 00:38:17 +0800
"Sergei Shtylyov" <sshtylyov@ru.mvista.com> wrote:

>
> 
>     NAK this patch completely -- both libata and IDE parts.
>     Luckily, I have just had a quick look at the datasheet to which you've
> linked and that was enough to conclude that SCH is *not* compatible to
> ICH/PIIX family, so absolutely needs a separate driver!
>

Most registers are same except for port enable bit, IOCFG and DMA timing. Now
I know why my patch just works -- the BIOS set the timing correctly. Thanks
for point this out. I will post a separate driver patch later.


Thanks,
Alek

From: "Russell Howe" <rhowe@siksai.co.uk>
Subject: Re: IDE/ATAPI timeouts & lost interrupts on alpha with 2.6.20.2
Date: Mon, 12 Mar 2007 01:07:59 +0000
Message-ID: <20070312010758.GA1439@xiao.rsnet>
References: <20070310225643.GB21407@xiao.rsnet> <200703110102.13652.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from youju.siksai.co.uk ([87.127.14.180]:4543 "EHLO
	youju.siksai.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933623AbXCLBIN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Mar 2007 21:08:13 -0400
Received: from xiao.siksai.co.uk ([87.127.14.179] ident=rhowe)
	by youju.siksai.co.uk with smtp (Exim 4.50)
	id 1HQZ15-000141-BX
	for linux-ide@vger.kernel.org; Mon, 12 Mar 2007 01:08:11 +0000
Content-Disposition: inline
In-Reply-To: <200703110102.13652.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Sun, Mar 11, 2007 at 01:02:13AM +0100, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> It seems that the generic IDE host driver is loaded first
> (CONFIG_IDE_GENERIC=y/m) and "steals" resources needed by cy82c693.
> 
> Please try again without the generic IDE host driver so the proper
> driver could be used.

$ zgrep IDE_GENERIC /proc/config.gz
# CONFIG_IDE_GENERIC is not set

.. and I get the same behaviour

> If it doesn't help I think that the best way to chase it is git bisect

git-bisect, here I come..

-- 
Russell Howe       | Why be just another cog in the machine,
rhowe@siksai.co.uk | when you can be the spanner in the works?

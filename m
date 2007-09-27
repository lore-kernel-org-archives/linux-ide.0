From: Tejun Heo <htejun@gmail.com>
Subject: Re: T61 SATA error in log
Date: Thu, 27 Sep 2007 16:50:17 -0700
Message-ID: <46FC41B9.9050502@gmail.com>
References: <1190877668.30275.3.camel@pasglop>  <46FC13FA.3090400@gmail.com> <1190936161.6158.42.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:51267 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833AbXI0Xv7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Sep 2007 19:51:59 -0400
Received: by wa-out-1112.google.com with SMTP id v27so3347826wah
        for <linux-ide@vger.kernel.org>; Thu, 27 Sep 2007 16:51:58 -0700 (PDT)
In-Reply-To: <1190936161.6158.42.camel@pasglop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: benh@kernel.crashing.org
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>

Benjamin Herrenschmidt wrote:
> Allright. What is happening exactly ? A fluke on the link ?

The drive is sending spurious completions of NCQ commands (ie. it's
sending completions for commands which are not pending).  We believe
this happens due to firmware bugs and it matched the reality pretty well
(drives with spurious completions usually had other NCQ related
problems) but recently too many new drives are causing this problem.  I
have no idea what's going on.  I guess it's about time to contact
harddrive vendors.

>> benh@pasglop:~/kernels/linux-2.6$ sudo hdparm -I /dev/sda
> 
> /dev/sda:
> 
> ATA device, with non-removable media
>         Model Number:       ST9120822AS
>         Serial Number:      5LZ50702
>         Firmware Revision:  3.CLF

Will add to blacklist.  Thanks.

-- 
tejun

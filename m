From: Tejun Heo <tj@kernel.org>
Subject: Re: sata_sil for 3512A chip on kernel 2.6.26.3
Date: Sat, 04 Oct 2008 16:39:40 +0900
Message-ID: <48E71DBC.5090301@kernel.org>
References: <48E48BF2.1010403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:52667 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751613AbYJDHlz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 4 Oct 2008 03:41:55 -0400
In-Reply-To: <48E48BF2.1010403@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Damazy <damazy@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Damazy wrote:
> Hi.
> I have big problem working with sata_sil.
> If I plugin SAMSUNG HD502IJ to one of 3512A and try to copy anything
> from that drive to the same one big partition is always hard resetting
> link and stops responds for 5 sec.
> 
> first is always timeout
> status DRDY
> hard resetting link
> 
> next some times drive error or HSM violation
> 
> I know that drive is good because I'v check it in diffrent hardware and os.
> 
> I'v test my config with WD800 and its work perfect.
> What can I do with that?
> What more information I must send to proper diagnose the problem?
> I'v read lots of information on web, but nothing helps at all.
> The only way to stops this problem is disable DMA with libata.dma=0 but
> performance of this solution unacceptable.

Please post full kernel log including the boot messages and error
messages.

Thanks.

-- 
tejun

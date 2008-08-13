From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH #upstream-fixes] sata_mv: don't issue two DMA commands
 concurrently
Date: Wed, 13 Aug 2008 21:21:44 +0900
Message-ID: <48A2D1D8.4040405@gmail.com>
References: <489C19CE.6030708@ngs.ru> <489C4B6E.9070306@rtr.ca> <489C4F29.6020007@rtr.ca> <489C54D1.5080901@rtr.ca> <48A29E14.3090908@gmail.com> <48A2BBDC.2090201@ngs.ru> <48A2BC5D.5060801@gmail.com> <48A2C35C.7020400@ngs.ru> <48A2C460.6040504@gmail.com> <48A2C770.2040200@ngs.ru> <48A2CB1B.4000200@gmail.com> <48A2CE09.9090806@ngs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.191]:40189 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040AbYHMMWm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Aug 2008 08:22:42 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1529404tic.23
        for <linux-ide@vger.kernel.org>; Wed, 13 Aug 2008 05:22:40 -0700 (PDT)
In-Reply-To: <48A2CE09.9090806@ngs.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Artem Bokhan <aptem@ngs.ru>
Cc: linux-ide@vger.kernel.org

Artem Bokhan wrote:
> When I run 'dd if=/dev/sda of=/dev/null skip=9700 bs=1M' and it meets
> bad block, it takes about
> '/sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/0000:02:02.0/host4/target4:0:0/4:0:0:0/timeout
> + about 10 seconds' to determine I/O error. Until that IO to device is
> locked, as I understand. I want to reduce the time of lock as  much as
> possible.
> 
> dd: reading `/dev/sda': Input/output error
> 240+1 records in
> 240+1 records out
> 252575744 bytes (253 MB) copied, 13.7833 s, 18.3 MB/s

Can you post timestamped dmesg?

-- 
tejun

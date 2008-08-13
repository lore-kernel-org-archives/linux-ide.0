From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH #upstream-fixes] sata_mv: don't issue two DMA commands
 concurrently
Date: Wed, 13 Aug 2008 20:52:59 +0900
Message-ID: <48A2CB1B.4000200@gmail.com>
References: <489C19CE.6030708@ngs.ru> <489C4B6E.9070306@rtr.ca> <489C4F29.6020007@rtr.ca> <489C54D1.5080901@rtr.ca> <48A29E14.3090908@gmail.com> <48A2BBDC.2090201@ngs.ru> <48A2BC5D.5060801@gmail.com> <48A2C35C.7020400@ngs.ru> <48A2C460.6040504@gmail.com> <48A2C770.2040200@ngs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.187]:36690 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184AbYHMLx5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Aug 2008 07:53:57 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1524678tic.23
        for <linux-ide@vger.kernel.org>; Wed, 13 Aug 2008 04:53:56 -0700 (PDT)
In-Reply-To: <48A2C770.2040200@ngs.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Artem Bokhan <aptem@ngs.ru>
Cc: linux-ide@vger.kernel.org

Artem Bokhan wrote:
> Now I have about 10 seconds of "disk restart" when hitting bad block
> (with /sys/...../timeout=1).
> Can somebody point me, if there any way to reduce it to 1/2/3 secs?

I don't really follow what you're saying.  Can you please elaborate?

-- 
tejun

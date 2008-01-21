From: Tejun Heo <htejun@gmail.com>
Subject: Re: ATA device reset, shoud I be concerned?
Date: Mon, 21 Jan 2008 23:33:35 +0900
Message-ID: <4794AD3F.40309@gmail.com>
References: <200801140019.20668.g.chulkov@jacobs-university.de>	<20080115025435.1e21b703.akpm@linux-foundation.org>	<20080115113552.75731bf8@lxorguk.ukuu.org.uk>	<4794501E.90306@gmail.com>	<20080121130256.2443d7c1@lxorguk.ukuu.org.uk>	<47949AA4.9090601@gmail.com> <20080121141425.45aa9c61@lxorguk.ukuu.org.uk> <4794ACAF.70505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:19646 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753578AbYAUOdm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jan 2008 09:33:42 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3753250wah.23
        for <linux-ide@vger.kernel.org>; Mon, 21 Jan 2008 06:33:41 -0800 (PST)
In-Reply-To: <4794ACAF.70505@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, Georgi Chulkov <g.chulkov@jacobs-university.de>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>

Tejun Heo wrote:
> IMHO, losing media error information is much better than locking up a
> machine hard.  We can start white listing known good controllers but I'm
> skeptical how much benefit it will bring.

Just a data point, even ICHs lock up after PHY event if the wrong TF
register is accessed.  I just don't think tempting with TF regs after
timeout is worth the cost.

-- 
tejun

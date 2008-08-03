From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 3/5] libata: Implement disk shock protection support
Date: Sun, 03 Aug 2008 22:58:23 +0900
Message-ID: <4895B97F.4020708@gmail.com>
References: <87prp1kvyy.fsf@denkblock.local>	<20080726062142.29070.10413.stgit@denkblock.local>	<4892B8FE.1070400@gmail.com>	<20080801233459.11e9b254@lxorguk.ukuu.org.uk>	<489523DC.2090903@gmail.com> <20080803140536.062c2ef1@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.230]:44347 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755237AbYHCN67 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Aug 2008 09:58:59 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1744207rvb.1
        for <linux-ide@vger.kernel.org>; Sun, 03 Aug 2008 06:58:59 -0700 (PDT)
In-Reply-To: <20080803140536.062c2ef1@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Elias Oltmanns <eo@nebensachen.de>, Jeff Garzik <jeff@garzik.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, Pavel Machek <pavel@ucw.cz>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Alan Cox wrote:
>> on both sides of the cable and I think things like that would be more
>> difficult to work accidentally.
> 
> We'd have to query the drive vendors to see what they expected.

We'll have to query the controller vendors too and I think it's highly
likely to cause problems on many controllers.

-- 
tejun

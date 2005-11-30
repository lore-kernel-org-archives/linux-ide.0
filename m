From: Keith Mannthey <kmannth@gmail.com>
Subject: Re: totally random "VFS: Cannot open root device"
Date: Wed, 30 Nov 2005 14:05:30 -0800
Message-ID: <a762e240511301405s433109b7n93e7fdcc7409bef5@mail.gmail.com>
References: <438B6E05.8070009@eq.cz> <438D2C19.3030008@gmail.com>
	 <438DA3FA.2010809@eq.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.198]:27176 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750937AbVK3WFb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 30 Nov 2005 17:05:31 -0500
Received: by zproxy.gmail.com with SMTP id 14so124277nzn
        for <linux-ide@vger.kernel.org>; Wed, 30 Nov 2005 14:05:30 -0800 (PST)
In-Reply-To: <438DA3FA.2010809@eq.cz>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "0602@eq.cz" <0602@eq.cz>
Cc: Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org, Linux-ide <linux-ide@vger.kernel.org>

On 11/30/05, 0602@eq.cz <0602@eq.cz> wrote:

Best guess is driver initilization troubles. The screen shot only
dosen't really show anything besides it is broken. A full boot log
from the failed boot would be nice.  There were some recent SATA
change could you try the current 2.6.15-rc3 as well?

Thanks,
 Keith

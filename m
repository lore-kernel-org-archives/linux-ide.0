From: "John W. Linville" <linville@tuxdriver.com>
Subject: Re: [patch] libata: add ioctls to support SMART
Date: Mon, 30 Aug 2004 13:51:12 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <41336910.3010907@tuxdriver.com>
References: <200408301531.i7UFVBg29089@ra.tuxdriver.com> <41336824.1040206@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from apollo.tuxdriver.com ([24.172.12.4]:49925 "EHLO
	ra.tuxdriver.com") by vger.kernel.org with ESMTP id S268728AbUH3RvN
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 30 Aug 2004 13:51:13 -0400
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by ra.tuxdriver.com (8.11.6/8.11.6) with ESMTP id i7UGi3P30249
	for <linux-ide@vger.kernel.org>; Mon, 30 Aug 2004 12:44:03 -0400
In-Reply-To: <41336824.1040206@gmx.de>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Prakash K. Cheemplavam wrote:
> 
> I am pretty sure my drive supports SMART. I hope that I understood your
> post correctly that with this patch it should work.

Prakash,

You need "-d ata" on the smartctl command line (and in smartd.conf, if
using smartd) in order for this to work:

	smartctl -d ata -a /dev/sda

John


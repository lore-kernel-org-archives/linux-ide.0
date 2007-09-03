From: Tejun Heo <htejun@gmail.com>
Subject: Re: Resets on sil3124 & sil3726 PMP
Date: Mon, 03 Sep 2007 17:59:21 +0900
Message-ID: <46DBCCE9.9080806@gmail.com>
References: <46D2595B.1030409@sauce.co.nz> <46D2792B.401@vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:15646 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753494AbXICI7a (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Sep 2007 04:59:30 -0400
Received: by py-out-1112.google.com with SMTP id u77so4776556pyb
        for <linux-ide@vger.kernel.org>; Mon, 03 Sep 2007 01:59:29 -0700 (PDT)
In-Reply-To: <46D2792B.401@vc.cvut.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Richard Scobie <richard@sauce.co.nz>, linux-ide@vger.kernel.org

Petr Vandrovec wrote:
> For comparsion 1TB Hitachi behind 3726 PMP (again MS4UM) with sata_sil
> patch I sent last week (no NCQ, 1.5Gbps link between 3512 and PMP, and
> 3.0Gbps link between PMP and drive... why is it faster?):

If you turn off NCQ by echoing 1 to /sys/block/sdd/device/queue_depth on
sata_sil24, does the performance change?

-- 
tejun

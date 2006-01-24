From: Tejun Heo <htejun@gmail.com>
Subject: [COORDINATE] INIC-1620TA/1622TA2/1623TA2 SATA controllers from initio
Date: Wed, 25 Jan 2006 00:24:50 +0900
Message-ID: <43D646C2.6040104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.205]:36309 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030373AbWAXPZE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Jan 2006 10:25:04 -0500
Received: by zproxy.gmail.com with SMTP id 16so1305197nzp
        for <linux-ide@vger.kernel.org>; Tue, 24 Jan 2006 07:25:03 -0800 (PST)
Received: from [127.0.0.1] (htj.dyndns.org [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by htj.dyndns.org (Postfix) with ESMTP id 628ED1841EF
	for <linux-ide@vger.kernel.org>; Wed, 25 Jan 2006 00:24:50 +0900 (KST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux-ide <linux-ide@vger.kernel.org>

Hello, fellow ATA developers.

I've just bought this brand-new/quite affordable INIC-1622TA2 
controller.  AFAIK, there's no driver yet.  Initio has kindly posted 
document of this controller on their website[1].  I skimmed through the 
doc and it seems to be a pretty decent piece of hardware with NCQ support.

I'm gonna work on this driver probably from next week or the week after. 
  So, please let me know if someone is already working or planning to 
work on it.  I'll be happy to be a tester in that case.  The other way 
around would be helpful, too.  If you have this type of controller and 
feeling like to participate in testing, please let me know.

Thanks.

[1] http://initio.com/products/sata.htm

-- 
tejun

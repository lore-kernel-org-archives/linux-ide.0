From: Petr Vandrovec <petr@vandrovec.name>
Subject: sata_sil, sil3512, and PMP?
Date: Wed, 15 Aug 2007 06:46:52 -0700
Message-ID: <46C303CC.3040902@vandrovec.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailgw.cvut.cz ([147.32.3.235]:46487 "EHLO mailgw.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754245AbXHONqy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Aug 2007 09:46:54 -0400
Received: from mailgw (localhost [127.0.0.1])
	by mailgw.cvut.cz (Postfix) with SMTP id CD50B13B88B
	for <linux-ide@vger.kernel.org>; Wed, 15 Aug 2007 15:46:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mailgw.cvut.cz (Postfix) with ESMTP id A38F513B9C8
	for <linux-ide@vger.kernel.org>; Wed, 15 Aug 2007 15:46:52 +0200 (CEST)
Received: from mailgw.cvut.cz ([127.0.0.1])
	by localhost (mailgw [127.0.0.1]) (amavisd-new, port 10024) with LMTP
	id 19621-07 for <linux-ide@vger.kernel.org>;
	Wed, 15 Aug 2007 15:46:52 +0200 (CEST)
Received: from [127.0.0.1] (buk.vc.cvut.cz [147.32.240.88])
	by mailgw.cvut.cz (Postfix) with ESMTP id 2BAD013B88B
	for <linux-ide@vger.kernel.org>; Wed, 15 Aug 2007 15:46:51 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,
   is anybody working on PMP support in sata_sil driver, or should I 
give it a try, or is it simpler to just shell out $70 to get 3124 based 
device with FIS based switching?

According to datasheet it seems that 3512 should be able to do command 
based switching without (too big) problems.  Though I'm not very 
confident as whole PMP support fits into two sentences in 3512 public 
datasheet :-(
					Thanks,
						Petr Vandrovec


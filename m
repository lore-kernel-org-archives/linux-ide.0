From: Peter Favrholdt <linux-ide@how.dk>
Subject: sata_promise: which version/patch to test?
Date: Thu, 10 May 2007 21:41:32 +0200
Message-ID: <4643756C.4000205@how.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pqueueb.post.tele.dk ([193.162.153.10]:36562 "EHLO
	pqueueb.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754401AbXEJUNK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 May 2007 16:13:10 -0400
Received: from pfepc.post.tele.dk (pfepc.post.tele.dk [195.41.46.237])
	by pqueueb.post.tele.dk (Postfix) with ESMTP id E9F498A60
	for <linux-ide@vger.kernel.org>; Thu, 10 May 2007 21:42:35 +0200 (CEST)
Received: from how3.how.dk (0x50a32a37.unknown.tele.dk [80.163.42.55])
	by pfepc.post.tele.dk (Postfix) with ESMTP id 6919E8A0015
	for <linux-ide@vger.kernel.org>; Thu, 10 May 2007 21:41:33 +0200 (CEST)
Received: from how7.how.dk ([192.168.0.7] ident=pfavr)
	by how3.how.dk with esmtp (Exim 4.50)
	id 1HmEW5-0006G4-5K
	for linux-ide@vger.kernel.org; Thu, 10 May 2007 21:41:33 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I would like to help by testing the most recent version of the 
sata_promise driver on my

Promise Technology, Inc. PDC40718 (SATA 300 TX4) (rev 02)

with 4 Seagate 500GB ES drives:
         Model Number:       ST3500630NS
         Firmware Revision:  3.AEE
         (with 1.5/3.0Gbps jumper removed = 3.0Gbps)

This setup experienced a problem a while ago which was fixed using 
2.6.21-rc2 + Mikael Petterssons "force 1.5Gbps patch".

Could someone provide a hint on what sources/patches I should get?

E.g. vanilla 2.6.21.1 + ?

Thanks for listening.

Best regards,

Peter

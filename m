From: "Eunice Chen" <Eunice.Chen@siliconimage.com>
Subject: RE: sata_sil, sil3512, and PMP?
Date: Wed, 15 Aug 2007 11:43:12 -0700
Message-ID: <E8F452C423BB2E439AA9E397EB8A95F3038D9875@telegraph.siliconimage.com>
References: <46C303CC.3040902@vandrovec.name>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from siimage.com ([12.24.47.101]:8746 "EHLO mail.siimage.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752759AbXHOSwt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Aug 2007 14:52:49 -0400
Content-class: urn:content-classes:message
In-Reply-To: <46C303CC.3040902@vandrovec.name>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Petr Vandrovec <petr@vandrovec.name>
Cc: linux-ide@vger.kernel.org

3512/3112/3114 controllers do not support PMP. 3124/3132 controllers do.

Eunice

-----Original Message-----
From: linux-ide-owner@vger.kernel.org
[mailto:linux-ide-owner@vger.kernel.org] On Behalf Of Petr Vandrovec
Sent: Wednesday, August 15, 2007 5:47 AM
To: linux-ide@vger.kernel.org
Subject: sata_sil, sil3512, and PMP?

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

-
To unsubscribe from this list: send the line "unsubscribe linux-ide" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

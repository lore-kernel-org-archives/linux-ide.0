From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH/RFC 0/3] libata: interrupt driven pio (revised)
Date: Fri, 23 Sep 2005 05:46:47 -0400
Message-ID: <4333CF07.5010400@pobox.com>
References: <4321B4E0.8020801@tw.ibm.com> <4321C7DD.5050503@pobox.com> <43322C50.1060009@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:31157 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750858AbVIWJqy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Sep 2005 05:46:54 -0400
In-Reply-To: <43322C50.1060009@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>

Comments:

1) the more trivial (read: "easier" to apply) patches should come first 
in a patch series.  In this case, that means that

	* patch #2, s/pioxxx/hsmxxx/ should come first
	* whitespace changes in patch #3 should come before patch #1


2) LLD should signal its interest in using the polling code paths using 
a new ATA_FLAG_xxx added to its host_flags list of flags.  This is 
greatly preferred over, e.g., hand-coding this indication in 
pdc_qc_issue_prot() or mv_qc_issue_prot()


3) Testing of CONFIG_HIGHMEM should be eliminated.  In general, #ifdefs 
are discouraged in Linux whereever possible.  That may mean that 
local_irq_save() must be called unconditionally, or some other solution 
should be found.







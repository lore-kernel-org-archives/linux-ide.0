From: Brian King <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/3] libata: Initialize nbytes for internal sg commands
Date: Mon, 22 Jan 2007 15:00:17 -0600
Message-ID: <45B525E1.8040502@linux.vnet.ibm.com>
References: <11690587311891-patch-mail.ibm.com> <200701171832.l0HIWMB7025070@d03av04.boulder.ibm.com> <45AECEEF.6020008@gmail.com> <45AFD151.7050800@linux.vnet.ibm.com>
Reply-To: brking@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e5.ny.us.ibm.com ([32.97.182.145]:32894 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932515AbXAVVA3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 Jan 2007 16:00:29 -0500
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id l0ML0RMb027942
	for <linux-ide@vger.kernel.org>; Mon, 22 Jan 2007 16:00:27 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id l0ML0JfL066352
	for <linux-ide@vger.kernel.org>; Mon, 22 Jan 2007 16:00:19 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l0ML0IaH005814
	for <linux-ide@vger.kernel.org>; Mon, 22 Jan 2007 16:00:19 -0500
In-Reply-To: <45AFD151.7050800@linux.vnet.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: brking@linux.vnet.ibm.com
Cc: Tejun Heo <htejun@gmail.com>, jgarzik@pobox.com, linux-ide@vger.kernel.org

Brian King wrote:
> Tejun Heo wrote:
>> Brian King wrote:
>>> Some LLDDs, like ipr, use nbytes and pad_len to determine
>>> the total data transfer length of a command. Make sure
>>> nbytes gets initialized for internally generated commands.
>> I think it's better to apply the following patch instead of this one.
>>
>> http://article.gmane.org/gmane.linux.ide/14792
> 
> Works for me. I loaded that patch in place of this one and verified
> it solved my problem as well. I still need the other two patches in
> this series, however.

Jeff,

Do you plan to pull this patch series into upstream-fixes? Without these
three patches (or 1 & 3 plus Tejun's patch referenced above), ipr SATA
is broken in 2.6.20.

Thanks,

Brian

-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center

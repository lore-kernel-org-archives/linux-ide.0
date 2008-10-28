From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 0/1] sata_sil: Option to use IO space to access TF registers.
Date: Tue, 28 Oct 2008 10:56:55 +0900
Message-ID: <49067167.8030205@kernel.org>
References: <20081022182243.9471.87443.stgit@linux-chris2.mips.com>	<20081022221623.344aea62@lxorguk.ukuu.org.uk>	<20081022233439.GA30488@ftp.linux-mips.org> <20081023083215.74e48b03@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39754 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752089AbYJ1B5Q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Oct 2008 21:57:16 -0400
In-Reply-To: <20081023083215.74e48b03@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Chris Dearman <chris@ftp.linux-mips.org>, jgarzik@pobox.com, linux-ide@vger.kernel.org

Alan Cox wrote:
>>   The patch is a relatively clean work around for limitations in the
>> hardware I'm using, but I know it probably looks like just more
>> cruft from an outside perspective so I won't be championing it :)
> 
> I would make the switch a runtime value personally - some network drivers
> do this for similar reasons.

I agree.  Please make it a module parameter.

Thanks.

-- 
tejun

From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 14/14] ahci: add softreset
Date: Sun, 29 Jan 2006 00:11:34 -0500
Message-ID: <43DC4E86.8040101@pobox.com>
References: <20051218133305.GA31571@htj.dyndns.org> <20051218135149.GO31571@htj.dyndns.org> <43A646C7.3050503@pobox.com> <43A64F5A.1010002@gmail.com> <43A655C4.10300@pobox.com> <43A65DA2.2080402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:31183 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750826AbWA2FLl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Jan 2006 00:11:41 -0500
In-Reply-To: <43A65DA2.2080402@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, liml@rtr.ca, linux-ide@vger.kernel.org

Tejun Heo wrote:
> So, AFAICS, most steps need polling and some are rather long, too.  Am I 
> missing something here?

OK I'm mostly convinced...  let's see how polling works out.  That 
aligns with what VIA AHCI and port multipliers want.

	Jeff



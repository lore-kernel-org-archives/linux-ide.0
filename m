From: Tejun Heo <htejun@gmail.com>
Subject: Re: [stable] [PATCH -stable] libata: sync NCQ blacklist with	upstream
Date: Thu, 11 Oct 2007 12:21:23 +0900
Message-ID: <470D96B3.3040405@gmail.com>
References: <20071011015515.GQ12186@htj.dyndns.org> <20071011025734.GA30990@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:11080 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755080AbXJKDVd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Oct 2007 23:21:33 -0400
Received: by rv-out-0910.google.com with SMTP id k20so368525rvb
        for <linux-ide@vger.kernel.org>; Wed, 10 Oct 2007 20:21:33 -0700 (PDT)
In-Reply-To: <20071011025734.GA30990@kroah.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, stable@kernel.org

Greg KH wrote:
> On Thu, Oct 11, 2007 at 10:55:15AM +0900, Tejun Heo wrote:
>> Synchronize NCQ blacklist with the current upstream.
> 
> Which -stable tree is this for, 2.6.22 or 2.6.23?

It's against 2.6.23.

-- 
tejun

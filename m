From: Florian Effenberger <florian@effenberger.org>
Subject: Re: libata interface fatal error
Date: Thu, 24 May 2007 17:28:47 +0200
Message-ID: <4655AF2F.6060701@effenberger.org>
References: <4655923E.5000409@effenberger.org> <46559713.9070201@gmail.com> <46559C62.2040509@effenberger.org> <46559F5B.4090700@gmail.com> <4655A588.40500@effenberger.org> <4655A6CE.2010300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from garfield.effenberger.org ([85.214.43.221]:50667 "EHLO
	garfield.effenberger.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbXEXP2w (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 May 2007 11:28:52 -0400
In-Reply-To: <4655A6CE.2010300@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

We just disabled the RAID (Linux software RAID, no hardware RAID) and 
tested with one disk only, same results

What string should I grep the logs for when things are being lowered?

> If you let the system run, libata will turn off NCQ and/or lower PHY
> speed to 1.5Gbps.  Do errors disappear after that happens?


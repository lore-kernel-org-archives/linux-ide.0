From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Palmchip BK3710 IDE driver
Date: Tue, 22 Jan 2008 14:31:07 -0500
Message-ID: <4796447B.60000@garzik.org>
References: <200801212144.29511.asalnikov@ru.mvista.com> <20080121195148.146741ca@lxorguk.ukuu.org.uk> <200801221511.37372.asalnikov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53032 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751236AbYAVTbQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 22 Jan 2008 14:31:16 -0500
In-Reply-To: <200801221511.37372.asalnikov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anton Salnikov <asalnikov@ru.mvista.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, bzolnier@gmail.com

Anton Salnikov wrote:
>>> +static inline u32 ioread(u32 reg)
>>> +{
>>> +	return ioread32(base + reg);
>>> +}
>>> +
>>> +static inline void iowrite(u32 val, u32 reg)
>>> +{
>>> +	iowrite32(val, base + reg);
>>> +}
>> Why not just use ioread32/iowrite32 directly ?
> 
> Because this increases readability and does not affect functionality at all

Disagree.

It confuses the namespace, /decreasing/ readability.  Anyone _but_ you 
reading this code will be confused by a non-standard API named similarly 
to an existing kernel API.

	Jeff




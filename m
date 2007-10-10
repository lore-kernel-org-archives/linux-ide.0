From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream] libata: blacklist NCQ on Seagate Barracuda
 ST380817AS
Date: Tue, 09 Oct 2007 21:32:28 -0400
Message-ID: <470C2BAC.7020409@garzik.org>
References: <20071004020656.GA12186@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:58415 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752439AbXJJBcc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Oct 2007 21:32:32 -0400
In-Reply-To: <20071004020656.GA12186@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, ornati@fastwebnet.it

Tejun Heo wrote:
> From: Paolo Ornati <ornati@fastwebnet.it>
> 
> Seagate Barracuda ST380817AS has troubles with NCQ. For example,
> unpacking a tarball on an XFS filesystem gives this:
> 
> ata1.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x2 frozen
> ata1.00: cmd 61/40:00:29:a3:98/00:00:00:00:00/40 tag 0 cdb 0x0 data 32768 out
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> 
> More info here:
> http://lkml.org/lkml/2007/1/21/76
>     
> Blacklist it!
> 
> Signed-off-by: Paolo Ornati <ornati@fastwebnet.it>
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied several of these



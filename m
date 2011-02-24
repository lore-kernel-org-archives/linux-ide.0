From: Mark Lord <kernel@teksavvy.com>
Subject: Re: sata-sil drive detection issues.
Date: Thu, 24 Feb 2011 14:04:38 -0500
Message-ID: <4D66ABC6.8030909@teksavvy.com>
References: <4D5C92F4.5000906@crc.id.au> <4D5CA2B1.8020905@crc.id.au> <20110217095815.GN19830@htj.dyndns.org> <a9eccac6fe224ef627fc71e819ba30ae@crc.id.au> <20110218091629.GC21209@htj.dyndns.org> <4D65C155.7080902@crc.id.au> <20110224083123.GB7840@htj.dyndns.org> <4D662A8B.5050501@crc.id.au> <20110224100609.GF7840@htj.dyndns.org> <4D66859B.3020806@teksavvy.com> <4D668759.1020208@crc.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:9841 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756107Ab1BXTEl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Feb 2011 14:04:41 -0500
In-Reply-To: <4D668759.1020208@crc.id.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Steven Haigh <netwiz@crc.id.au>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, justin@jmicron.com

On 11-02-24 11:29 AM, Steven Haigh wrote:
>
> There is only one eSATA port on the back of the cradle. From looking at the
> specs of the JMB352[1], it seems that it has the capability to have 3 SATA
> channels. Two are used for the cradle bays, the third for the uplink to the PC.
> 
> The PDF states:
> "The SATA controller could be configured as host or device. The
> 3-port SATA II 3.0G controllers further supports the eSATA to dual SATA
> communication."
> 
> [1] - http://www.jmicron.com/PDF/JMB352/JMB352.pdf


It would be nice to know what that actually means.
The only standard way for a single eSATA to connect to two SATA
is via a SATA Port Multiplier.  I wonder if that chip implements one?


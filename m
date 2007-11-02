From: Frans de Boer <frans@fransdb.nl>
Subject: Re: SATA_SIL
Date: Fri, 02 Nov 2007 11:23:45 +0100
Message-ID: <1193999025.32531.7.camel@ws1.fransdb.nl>
References: <1193781389.26314.9.camel@ws1.fransdb.nl>
	 <4729126F.1000108@gmail.com> <1193955948.17609.31.camel@ws1.fransdb.nl>
	 <472A7928.2060702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out1.tiscali.nl ([195.241.79.176]:43014 "EHLO
	smtp-out1.tiscali.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753219AbXKBKXt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2007 06:23:49 -0400
In-Reply-To: <472A7928.2060702@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Both sil and sil24 are not the same compared to the stock 2.6.22.9
kernel.

On Fri, 2007-11-02 at 10:11 +0900, Tejun Heo wrote:
> [restoring linux-ide, please don't drop cc]
> 
> Frans de Boer wrote:
> > Hello sir,
> > 
> > I just checked: the SuSE 2.6.22.9-0.4 source for sata_sil.c (among
> > others) is NOT the same as the stock 2.6.22.9. Looking at your reply, I
> > quess that I have to skip 2.6.23 and use the next 2.6.24 release?
> 
> Is it sata_sil or sata_sil24?  You were talking about sil24 in the
> original message.
> 
> > On a more modern system, - without the sil chips - SuSE 10.3 with the
> > newer 2.6.23.1 kernel is working just fine.
> > 
> > Do you  still like to recieve my report as suggested by you?
> 
> Yeah, it should just work.  Thanks.
> 
Uh, your reacte on which part? The part of just wait for the 2.6.24
release or that you recieve the boot.msg and hwinfo output?

KR,
Frans.


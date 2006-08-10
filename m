From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCHSET] libata: improve initialization and legacy handling,
 take#3
Date: Thu, 10 Aug 2006 07:59:30 -0400
Message-ID: <44DB1FA2.6050604@pobox.com>
References: <11551977882917-git-send-email-htejun@gmail.com> <44DB101F.2080505@pobox.com> <44DB1953.3060803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:62940 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161152AbWHJL7e (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Aug 2006 07:59:34 -0400
In-Reply-To: <44DB1953.3060803@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Tejun Heo wrote:
> I see.  For this patchset though, pulling pata-drivers that way would 
> give it a small window of commits (probably just one) where pata drivers 
> won't build properly.  tj-pata-drivers was built by...
> 
> 1. pulling #tj-upstream before removing old legacy handling
> 2. updating #tj-pata-drivers to use new legacy handling
> 3. killing old legacy handling in #tj-upstream
> 4. pulling again

Yeah, usually I fix up brokenness myself.  There is no perfect system :)


> Such that pata-drivers doesn't fail to build after upstream merge.  I 
> won't make ALL branch from now on and tell you if merge needs some 
> special ordering.

Yep, that sounds better.

	Jeff




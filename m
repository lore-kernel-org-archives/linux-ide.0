From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [BUG] bug when enabling VM DEBUG
Date: Fri, 14 May 2010 17:48:44 -0400
Message-ID: <4BEDC53C.8040107@garzik.org>
References: <AANLkTikkSRI6u_mp6mNQReECB84t3oh-_MPVzAYEQULN@mail.gmail.com>	 <AANLkTikoNc6oAY5JthYX1jWx1w2KeJ1fGab72Z-OvIVG@mail.gmail.com>	 <4BEA1559.9000107@gmail.com>	 <1273662639.23818.67.camel@e102109-lin.cambridge.arm.com>	 <20100512115340.GA11261@Chamillionaire.breakpoint.cc>	 <1273667099.23818.86.camel@e102109-lin.cambridge.arm.com>	 <20100512130638.GB19314@shareable.org> <1273750233.30713.39.camel@e102109-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f191.google.com ([209.85.210.191]:47328 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932323Ab0ENVsq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 May 2010 17:48:46 -0400
In-Reply-To: <1273750233.30713.39.camel@e102109-lin.cambridge.arm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jamie Lokier <jamie@shareable.org>, Sebastian Andrzej Siewior <sebastian@breakpoint.cc>, lkml <linux-kernel@vger.kernel.org>, DE/ATA development list <linux-ide@vger.kernel.org>, saeed bishara <saeed.bishara@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Robert Hancock <hancockrwd@gmail.com>

On 05/13/2010 07:30 AM, Catalin Marinas wrote:
> I already proposed a PIO cache flushing API on linux-arch. I tried to
> revive the discussion with another patch for cachetlb.txt but it hasn't
> drawn much interest.


Oh well.  I'll apply the local-to-libata patch, and hope that someone 
else proposes a better API.

	Jeff




From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] 2.6.34-rc3 v2 Disable R_OK (Early ACK) on SII 3726 PMP
Date: Thu, 22 Apr 2010 22:16:05 -0400
Message-ID: <4BD102E5.7080006@pobox.com>
References: <g2ida824cf31004141843p41f7b21fz25927e3c6faeeed7@mail.gmail.com> <l2jda824cf31004201352y5fcdfa40g2ecb5dbb1706bf88@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:48020 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755058Ab0DWCQP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Apr 2010 22:16:15 -0400
In-Reply-To: <l2jda824cf31004201352y5fcdfa40g2ecb5dbb1706bf88@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: Linux IDE mailing list <linux-ide@vger.kernel.org>, Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 04/20/2010 04:52 PM, Grant Grundler wrote:
> ping? Can this patch please be applied?

Apologies for the delay, I had been pulled away from libata this week by 
baby stuff :/


> I was assuming this will show up here:
>     http://git.kernel.org/?p=linux/kernel/git/jgarzik/libata-dev.git;a=shortlog;h=refs/heads/upstream-linus

Nope, upstream-linus is always a temporary branch.

#upstream-fixes is where 2.6.X-rcY changes are found (though typically 
these are pushed upstream ASAP)

#upstream is the development branch for 2.6.(X+1), where this change can 
[now] be found.

	Jeff




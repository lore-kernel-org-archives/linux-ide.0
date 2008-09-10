From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
Date: Wed, 10 Sep 2008 20:25:55 +0400
Message-ID: <48C7F513.2090203@ru.mvista.com>
References: <20080910.010824.07456636.anemo@mba.ocn.ne.jp>	<48C6B768.4010200@ru.mvista.com> <20080911.003222.51867360.anemo@mba.ocn.ne.jp> <48C7EDE4.3090400@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:15177 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751868AbYIJQZQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Sep 2008 12:25:16 -0400
In-Reply-To: <48C7EDE4.3090400@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org, linux-ide@vger.kernel.org, bzolnier@gmail.com, ralf@linux-mips.org

Hello, I just wrote:

>    Acltually, this is somewhat wrong WRT the programming the command PIO 
> timings in the bits 8..10: they should be set to the same value 

    Hmm, probably isn't actually wrong, though usually IDE controllers have a 
single command timings register per channel.

MBR, Sergei


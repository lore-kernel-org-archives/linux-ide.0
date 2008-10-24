From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] ide: Add tx4938ide driver (v2)
Date: Sat, 25 Oct 2008 01:06:17 +0900 (JST)
Message-ID: <20081025.010617.78730272.anemo@mba.ocn.ne.jp>
References: <20081023.012013.52129771.anemo@mba.ocn.ne.jp>
	<4900B6A8.30705@ru.mvista.com>
	<20081025.005544.92344156.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mba.ocn.ne.jp ([122.1.235.107]:52131 "EHLO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751925AbYJXQGB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 24 Oct 2008 12:06:01 -0400
In-Reply-To: <20081025.005544.92344156.anemo@mba.ocn.ne.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sshtylyov@ru.mvista.com
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, bzolnier@gmail.com, ralf@linux-mips.org

On Sat, 25 Oct 2008 00:55:44 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> >     Same comment about calculating only once...
> 
> Yes.  But are there any good place to hold calculated values?  I don't
> think it is not worth to allocate a local structure just for holding
> such values.  And this is not a critical path anyway :-)

Oh, I mean "I don't think it is worth to ...".
---
Atsushi Nemoto

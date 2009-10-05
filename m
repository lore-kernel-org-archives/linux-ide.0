From: David Miller <davem@davemloft.net>
Subject: Re: kernel BUG at drivers/ide/ide-disk.c:187 (2.6.31)
Date: Sun, 04 Oct 2009 17:19:23 -0700 (PDT)
Message-ID: <20091004.171923.211397115.davem@davemloft.net>
References: <20091001.115310.100974682.davem@davemloft.net>
	<20091003033942.GA8129@dis.manty.net>
	<20091004223705.GB5030@dis.manty.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:36696
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757082AbZJEAT2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 4 Oct 2009 20:19:28 -0400
In-Reply-To: <20091004223705.GB5030@dis.manty.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: manty@manty.net
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

From: Santiago Garcia Mantinan <manty@manty.net>
Date: Mon, 5 Oct 2009 00:37:05 +0200

>> Applied it to 2.6.31.1, I'll wait and see what the weekend tells us.
> 
> up 2 days,  8:27 and still nothing, maybe I shouldn't have applied it to .1
> as some of the fixes there could be masking the problem and I should be
> testing it on 2.6.31 :-?

If 2.6.31.1 fixes your bug, that would be good news :-)

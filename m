From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: [PATCH] at91_ide: remove headers specific for at91sam9263
Date: Sat, 15 Aug 2009 16:15:52 -0400
Message-ID: <200908151615.52689.stf_xl@wp.pl>
References: <1250330561-10975-1-git-send-email-geomatsi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.wp.pl ([212.77.101.1]:22891 "EHLO mx1.wp.pl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751348AbZHOO5z (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 15 Aug 2009 10:57:55 -0400
In-Reply-To: <1250330561-10975-1-git-send-email-geomatsi@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergey Matyukevich <geomatsi@gmail.com>
Cc: linux-ide@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

On Saturday 15 August 2009 06:02, Sergey Matyukevich wrote:
> This driver requires only static memory controller definitions and macroses
> contained in generic header at91sam9_smc.h.
> 
> Those extra headers are misleading since this driver also works fine for
> at91sam9260 SoC: tests were performed on afeb9260 board.
> 
> Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>

Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

Thanks
Stanislaw

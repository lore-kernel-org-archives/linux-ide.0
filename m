From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC] Get DMA to work for CD/DVD with pdc202xx_old
Date: Tue, 18 Apr 2006 15:05:34 +0100
Message-ID: <1145369135.18736.49.camel@localhost.localdomain>
References: <BAY105-F111271D2374577E2FBCB9FA3C40@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:33209 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751031AbWDRN4F (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Apr 2006 09:56:05 -0400
In-Reply-To: <BAY105-F111271D2374577E2FBCB9FA3C40@phx.gbl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tobias Oed <tobiasoed@hotmail.com>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, andre@linux-ide.org

On Maw, 2006-04-18 at 09:15 -0400, Tobias Oed wrote:
> +       #if 0
>         if ((drive->media != ide_disk) && (speed < XFER_SW_DMA_0))
>                 return -1;
> -
> +       #endif
> +

This change looks unrelated to anything you are trying to do. Rest looks
sane enough


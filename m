From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] hpt366: fix HPT370 DMA timeouts
Date: Thu, 16 Apr 2009 20:54:20 +0200
Message-ID: <200904162054.27279.bzolnier@gmail.com>
References: <200904072009.32070.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.190]:37422 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752395AbZDPTjK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Apr 2009 15:39:10 -0400
Received: by fk-out-0910.google.com with SMTP id 18so261811fkq.5
        for <linux-ide@vger.kernel.org>; Thu, 16 Apr 2009 12:39:09 -0700 (PDT)
In-Reply-To: <200904072009.32070.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, stable@kernel.org

On Tuesday 07 April 2009 18:09:32 Sergei Shtylyov wrote:
> The big driver change in 2.4.19-rc1 introduced a regression for many HPT370[A]
> chips -- DMA stopped to work completely, only causing endless timeouts...
> 
> The culprit has been identified (at last!): it turned to be the code resetting
> the DMA state machine before each transfer. Stop doing it now as this counter-
> measure has clearly caused more harm than good.
> 
> This should fix the kernel.org bug #7703.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Wow!

applied

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/3] mips au1xxx_ide.h: use NULL as firmware-revision wildcard.
Date: Wed, 30 May 2007 22:45:19 +0200
Message-ID: <200705302245.19939.bzolnier@gmail.com>
References: <20070521145042.GA6957@redhat.com> <200705282141.42507.bzolnier@gmail.com> <7vy7j87ddp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.244]:50062 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758181AbXE3WWy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 May 2007 18:22:54 -0400
Received: by an-out-0708.google.com with SMTP id d31so775707and
        for <linux-ide@vger.kernel.org>; Wed, 30 May 2007 15:22:53 -0700 (PDT)
In-Reply-To: <7vy7j87ddp.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Dave Jones <davej@redhat.com>

On Tuesday 29 May 2007, Junio C Hamano wrote:
> This updates the DMA whitelist in MIPS specific au1xxx ide
> driver to use NULL instead of "ALL" as the wildcard.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>

applied

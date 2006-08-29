From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] HPA resume fix
Date: Tue, 29 Aug 2006 12:11:51 +0100
Message-ID: <1156849911.6271.101.camel@localhost.localdomain>
References: <44F40F06.4010408@PicturesInMotion.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:61881 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932270AbWH2KuA
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Aug 2006 06:50:00 -0400
In-Reply-To: <44F40F06.4010408@PicturesInMotion.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lee Trager <Lee@PicturesInMotion.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Ar Maw, 2006-08-29 am 05:55 -0400, ysgrifennodd Lee Trager:
> This patch fixes a problem with computers that have HPA on their hard
> drive and not being able to come out of resume from RAM or disk. This is
> my first patch to the kernel and third time submitting it, hopefully I
> got it right this time.
> 
> Signed-off-by: Lee Trager <Lee@PicturesInMotion.net>

For -mm only to get more testing

Acked-by: Alan Cox <alan@redhat.com>

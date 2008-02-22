From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] hpt366: fix section mismatch warnings
Date: Fri, 22 Feb 2008 22:53:42 +0300
Message-ID: <47BF2846.1030604@ru.mvista.com>
References: <20080222194651.GA7154@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:58349 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1764632AbYBVTwl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 Feb 2008 14:52:41 -0500
In-Reply-To: <20080222194651.GA7154@uranus.ravnborg.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Sam Ravnborg wrote:

> hpt366: fix section mismatch warnings

> Fix following warnings:
> WARNING: o-sparc64/vmlinux.o(.data+0x195a38): Section mismatch in reference from the variable hpt37x_info.0 to the variable .devinit.data:hpt370
> WARNING: o-sparc64/vmlinux.o(.data+0x195a40): Section mismatch in reference from the variable hpt37x_info.0 to the variable .devinit.data:hpt370a
> WARNING: o-sparc64/vmlinux.o(.data+0x195a48): Section mismatch in reference from the variable hpt37x_info.0 to the variable .devinit.data:hpt372
> WARNING: o-sparc64/vmlinux.o(.data+0x195a50): Section mismatch in reference from the variable hpt37x_info.0 to the variable .devinit.data:hpt372n

> Replace a static array with a small switch resulting in
> more readable code.
> Be consistent in use of __devinitconst for const data
> to avoid section type conflicts.
> Mark the pci table __devinitconst.

> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei

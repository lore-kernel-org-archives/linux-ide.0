From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH v5] Resurrect IT8172 IDE controller driver
Date: Fri, 2 Jan 2009 23:25:04 +0100
Message-ID: <200901022325.04782.bzolnier@gmail.com>
References: <E1LIkqz-00021S-O5@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:7099 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753015AbZABWd4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Jan 2009 17:33:56 -0500
In-Reply-To: <E1LIkqz-00021S-O5@localhost>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shane McDonald <mcdonald.shane@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, sshtylyov@ru.mvista.com, linux-kernel@vger.kernel.org

On Friday 02 January 2009, Shane McDonald wrote:
> Support for the IT8172 IDE controller was removed from the kernel
> sometime after 2.6.18.  Support for the only boards that used the IT8172
> was removed from the kernel after 2.6.18, as they had never compiled
> since 2.6.0.  However, there are a couple of platforms that use this
> chip: the PMC-Sierra Xiao Hu thin-client computer, which is no longer
> in production, and the Linksys NSS4000 Network Attached Storage box,
> which is based on the Xiao Hu board.  I am attempting to add support
> for the Xiao Hu to the kernel, and this IT8172 IDE controller is the
> first bit of code in this effort.
> 
> This patch resurrects the IT8172 IDE controller code.  I began with
> the 2.6.18 version of the it8172.c file, and have moved it forward so
> that it works with the latest version of the kernel.  I have run this
> driver on a PMC-Sierra Xiao Hu board with the 2.6.28 kernel, and
> I have had no problems with it in my configuration.  The attached patch
> applies cleanly against 2.6.28.
> 
> Signed-off-by: Shane McDonald <mcdonald.shane@gmail.com>
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied, thanks!

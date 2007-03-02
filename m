From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_qdi: Fix initialisation
Date: Fri, 02 Mar 2007 18:19:12 -0500
Message-ID: <45E8B0F0.1090407@garzik.org>
References: <20070302145635.1fc6fac7@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54613 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992728AbXCBXTP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Mar 2007 18:19:15 -0500
In-Reply-To: <20070302145635.1fc6fac7@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Alan Cox wrote:
> The QDI init code contains some bugs which mean it only works if you have
> a test setup that causes both a successful and failed probe. Fix this
> 
> Found by Philip Guo
> 
> (Who found it working on code analysis tools not running VLB IDE
> controllers)
> 
> Signed-off-by: Alan Cox <alan@redhat.com>diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc2/drivers/ata/pata_qdi.c linux-2.6.21-rc2/drivers/ata/pata_qdi.c

applied, though it appears your patch-sending script munched a few newlines



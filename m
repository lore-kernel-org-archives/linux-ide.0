From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_hpt3x2n: Further updating based upon old IDE work
Date: Fri, 09 Mar 2007 09:15:11 -0500
Message-ID: <45F16BEF.2060807@garzik.org>
References: <20070308233058.23b5c29d@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56524 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767311AbXCIOPP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Mar 2007 09:15:15 -0500
In-Reply-To: <20070308233058.23b5c29d@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org

Alan Cox wrote:
> And it now supports the hpt371n so at some point needs a rename. Sigh

Procedure for this:

1) Send me a diff of the /changed/ files (usually just Makefile, and 
NEVER send changes to the files being renamed)

2) Include in the patch email "Jeff, please run 'git mv OLD NEW' with 
this commit"

3) Send a second patch, diff'd against the /new/ pathname, adding 
MODULE_ALIAS() line for compat with the old driver name


From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH][libata] pata_pdc202xx_old: fix data corruption and other
 problems
Date: Tue, 06 Mar 2007 04:05:37 -0500
Message-ID: <45ED2EE1.4040505@garzik.org>
References: <200703040158.43471.bzolnier@gmail.com> <200703040448.08578.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51801 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933113AbXCFJFl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Mar 2007 04:05:41 -0500
In-Reply-To: <200703040448.08578.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> This version has improved patch description
> (on the second thought the original patch description was too vague).
> 
> Bart
> 
> [PATCH] pata_pdc202xx_old: fix possible data corruption and other problems

applied, though please include the "This version has improved patch 
description" notes after the "---" terminator.  That way, Linus's git 
tools automatically strip such meta-comments automatically from the 
patch description, before pasting directly into the kernel changelog.

	Jeff




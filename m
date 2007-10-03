From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 09/10] libata_scsi: Fix transfer lengths
Date: Wed, 03 Oct 2007 16:43:00 -0400
Message-ID: <4703FED4.6090409@garzik.org>
References: <200710022053.l92Kr4Wg021703@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56326 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758636AbXJCUnC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 Oct 2007 16:43:02 -0400
In-Reply-To: <200710022053.l92Kr4Wg021703@imap1.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com

akpm@linux-foundation.org wrote:
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> 
> This should get into the base tree very soon anyway but it fixes a ton of
> devices so it would be nice to have in -mm so I can get people to test -mm not
> "-mm + a bit" when reporting ATAPI problems.

applied, after replacing the -mm-specific patch description with 
something a bit more useful



From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Another Maxtor drive with broken NCQ
Date: Fri, 06 Jul 2007 15:09:20 -0400
Message-ID: <468E9360.4070504@garzik.org>
References: <468E8DE1.9010405@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:58379 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754239AbXGFTJW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 6 Jul 2007 15:09:22 -0400
In-Reply-To: <468E8DE1.9010405@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Chuck Ebbert wrote:
> From:
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=246352
> 
> Looks like this entry is needed in the NCQ blacklist:
> 
> {"Maxtor 6B200M0",      "BANC1BM0",     ATA_HORKAGE_NONCQ }
> 
> Or should *all* Maxtor 6B200M0 be blacklisted, since there's already
> one of them in the list?

Wanna send that as a patch, with attribution and sign-offs?  :)

	Jeff




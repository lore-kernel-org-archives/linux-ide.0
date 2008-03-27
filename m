From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCHSET #upstream] libata: improve FLUSH error handling
Date: Thu, 27 Mar 2008 14:53:35 -0400
Message-ID: <47EBED2F.80101@garzik.org>
References: <12066128663306-git-send-email-htejun@gmail.com> <47EBDE84.1070802@emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:39548 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755531AbYC0Sxi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 27 Mar 2008 14:53:38 -0400
In-Reply-To: <47EBDE84.1070802@emc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ric@emc.com
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, liml@rtr.ca

Ric Wheeler wrote:
> Are we sure that it is ever the right thing to do to reissue a flush 
> command?


I confess no field experience here, but that's what the spec wants at 
least...

	Jeff



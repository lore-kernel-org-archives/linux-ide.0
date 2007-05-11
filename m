From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: add human-readable error value decoding
Date: Fri, 11 May 2007 19:22:44 -0400
Message-ID: <4644FAC4.4010809@garzik.org>
References: <46428103.3040003@shaw.ca> <4642E92D.5010509@gmail.com> <4643AAF6.7080204@shaw.ca> <46449E59.90608@redhat.com> <4644A3AD.7000700@gmail.com> <4644F7EC.3080607@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44058 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752040AbXEKXWs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 11 May 2007 19:22:48 -0400
In-Reply-To: <4644F7EC.3080607@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Tejun Heo <htejun@gmail.com>, Chuck Ebbert <cebbert@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Robert Hancock wrote:
> The ATA ones are more of a pain in that regard than SCSI though - SCSI 
> has all distinct error codes for different errors, whereas ATA has 
> bitmasks for everything..

That should not affect implementation.  Either way, a table-driven 
approach can easily work.

I favor decoding the SError status bits, but your names were far too 
long.  "ProtocolErr" should be "Proto".  "10B8BErr" should be "10b8b". 
HostInternalErr to HostInt.  PHYInternalErr to PHYInt.  etc.

	Jeff



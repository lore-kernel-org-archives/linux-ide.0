From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Intel ICH9M/M-E SATA error-handling/reset problems
Date: Sat, 14 Feb 2009 15:53:16 -0500
Message-ID: <49972F3C.2090800@garzik.org>
References: <200902141206.06419.mirsev@cicese.mx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:48044 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752001AbZBNUxV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 14 Feb 2009 15:53:21 -0500
In-Reply-To: <200902141206.06419.mirsev@cicese.mx>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Serguei Miridonov <mirsev@cicese.mx>
Cc: linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>

Serguei Miridonov wrote:
> I have some problems with SATA in a new notebook PC (HP Pavilion dv5t, 
> Intel chipset). Seagate FreeAgent Pro 1TB external drive practically 
> can not be used with eSATA in Linux (fresh install from DVD Fedora 10, 
> now fully updated), and yesterday I also had problem with DVD 
> recording using internal HL-DT-ST BDDVDRW drive.

Some eSata fixes went into the more-recent kernels...  Can you try 
2.6.29-rc5?

	Jeff




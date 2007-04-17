From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pci-quirks: disable MSI on RS400-200 and RS480
Date: Tue, 17 Apr 2007 10:57:28 -0400
Message-ID: <4624E058.8010808@garzik.org>
References: <20070416045918.GI10619@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:39892 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754328AbXDQO5j (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Apr 2007 10:57:39 -0400
In-Reply-To: <20070416045918.GI10619@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torresmat@gmail.com, conke.hu@gmail.com

Tejun Heo wrote:
> MSI doesn't work on RS400-200 and RS480 requiring pci=nomsi kernel
> boot parameter for ahci to work.  This patch disables MSI on those
> chips.
> 
>   http://thread.gmane.org/gmane.linux.ide/17820
>   http://thread.gmane.org/gmane.linux.ide/17516
>   https://bugzilla.novell.com/show_bug.cgi?id=263893
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK.  Greg will apply, I presume?



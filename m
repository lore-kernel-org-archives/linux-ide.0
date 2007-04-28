From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 01/10] ata: printk warning fixes
Date: Sat, 28 Apr 2007 15:16:49 -0400
Message-ID: <46339DA1.6060706@garzik.org>
References: <200704260719.l3Q7JLr7023679@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53673 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751717AbXD1TQv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 28 Apr 2007 15:16:51 -0400
In-Reply-To: <200704260719.l3Q7JLr7023679@shell0.pdx.osdl.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-ide@vger.kernel.org, htejun@gmail.com

akpm@linux-foundation.org wrote:
> From: Andrew Morton <akpm@linux-foundation.org>
> 
> drivers/ata/libata-core.c: In function 'ata_hpa_resize':
> drivers/ata/libata-core.c:986: warning: format '%lld' expects type 'long long int', but argument 5 has type 'u64'
> drivers/ata/libata-core.c:986: warning: format '%lld' expects type 'long long int', but argument 6 has type 'u64'
> drivers/ata/libata-core.c:990: warning: format '%lld' expects type 'long long int', but argument 4 has type 'u64'
> drivers/ata/libata-core.c:990: warning: format '%lld' expects type 'long long int', but argument 5 has type 'u64'
> drivers/ata/libata-core.c:1003: warning: format '%lld' expects type 'long long int', but argument 4 has type 'u64'
> 
> Also fix various 80-col bustage.
> 
> Cc: Jeff Garzik <jeff@garzik.org>
> Cc: Tejun Heo <htejun@gmail.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

applied



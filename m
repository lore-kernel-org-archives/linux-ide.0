From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: READ SCSI cmd seems to fail on SATA optical devices...
Date: Wed, 15 Nov 2006 16:28:09 +0000
Message-ID: <20061115162809.3ecd7d3a@localhost.localdomain>
References: <1163434776.2984.21.camel@de-c-l-110.nero-de.internal>
	<4558BE57.4020700@cfl.rr.com>
	<1163444160.27291.2.camel@de-c-l-110.nero-de.internal>
	<1163446372.15249.190.camel@laptopd505.fenrus.org>
	<1163519125.2998.8.camel@de-c-l-110.nero-de.internal>
	<455 <455B3A78.7010503@gmail.com>
	<455B3D99.8040705@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:1505 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030667AbWKOQbF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Nov 2006 11:31:05 -0500
In-Reply-To: <455B3D99.8040705@cfl.rr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Tejun Heo <htejun@gmail.com>, Mathieu Fluhr <mfluhr@nero.com>, Arjan van de Ven <arjan@infradead.org>, jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 15 Nov 2006 11:17:29 -0500
Phillip Susi <psusi@cfl.rr.com> wrote:

> The original patch memsets the entire buffer only to copy over most of 
> it right after.  Could you amend the patch so that it memcpys first, 
> then memsets only the remainder of the buffer?  No sense wasting cpu 
> cycles.

Look at the generated code - its faster to memset the entire CDB as Tejun
is doing than actually bother to think about it.

Alan

From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH #upstream] libata: blacklist NCQ on Seagate Barracuda
 ST380817AS
Date: Thu, 4 Oct 2007 12:54:36 +0100
Message-ID: <20071004125436.1ae8dbe8@the-village.bc.nu>
References: <20071004020656.GA12186@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43179 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753719AbXJDLtr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Oct 2007 07:49:47 -0400
In-Reply-To: <20071004020656.GA12186@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, ornati@fastwebnet.it

On Thu, 4 Oct 2007 11:06:56 +0900
Tejun Heo <htejun@gmail.com> wrote:

> From: Paolo Ornati <ornati@fastwebnet.it>
> 
> Seagate Barracuda ST380817AS has troubles with NCQ. For example,
> unpacking a tarball on an XFS filesystem gives this:
> 
> ata1.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x2 frozen
> ata1.00: cmd 61/40:00:29:a3:98/00:00:00:00:00/40 tag 0 cdb 0x0 data 32768 out
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)

Looking at this and our NCQ code I don't see any provision for drive
unfairness in our code. If we continue to issue commands to the drive I'm
not seeing where we guarantee a given command will ever complete rather
than being deferred forever by a dumb drive - which some SCSI drives also
will do...

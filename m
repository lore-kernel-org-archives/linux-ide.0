From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: iq81340mc: oops with SATA VIA
Date: Wed, 7 Mar 2007 01:14:43 +0000
Message-ID: <20070307011443.08a13916@lxorguk.ukuu.org.uk>
References: <20070212114114.GG6457@deprecation.cyrius.com>
	<0C7297FA1D2D244A9C7F6959C0BF1E52017D0497@azsmsx413.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40987 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030760AbXCGAKe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Mar 2007 19:10:34 -0500
In-Reply-To: <0C7297FA1D2D244A9C7F6959C0BF1E52017D0497@azsmsx413.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Williams, Dan J" <dan.j.williams@intel.com>
Cc: Martin Michlmayr <tbm@cyrius.com>, buytenh@wantstofly.org, linux-ide@vger.kernel.org

> Martin I am copying linux-ide because I am wondering if this issue is
> due to a case where the fact that iop13xx posts i/o writes is causing
> issues.  On IA the driver would be stalled until an i/o write completed.
> On iop13xx the driver is free to continue running.  Perhaps someone with
> more knowledge about the sata_via hardware can answer if this would be
> an issue, because everything thus far looks correct in the iop13xx code.

outb/w/l and friends are required not to post. If you are using mmio
operations then the MMIO ops code in libata does any posting of writes
required and handles it properly. If you are emulating outb/w/l without
avoiding posting then it wont work as with many other drivers.

Alan

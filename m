From: Jeremy Kerr <jk@ozlabs.org>
Subject: Re: siimage breakage: no MMIO
Date: Thu, 1 May 2008 21:04:01 +1000
Message-ID: <200805012104.02035.jk@ozlabs.org>
References: <200805011832.17580.jk@ozlabs.org> <200805011252.21709.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:49070 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755220AbYEALEP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 May 2008 07:04:15 -0400
In-Reply-To: <200805011252.21709.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Ben Herrenschmidt <benh@kernel.crashing.org>, cbe-oss-dev@ozlabs.org

> Don't over-write hwif->host_flags in ide_init_port(), some host
> drivers set IDE_HFLAG_MMIO or IDE_HFLAG_NO_IO_32BIT host flag early.

Excellent, works great.

Thanks,


Jeremy

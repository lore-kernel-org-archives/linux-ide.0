From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/4] drivers/ata: add low-level I/O calls
Date: Fri, 12 Jan 2007 10:24:06 +0000
Message-ID: <20070112102406.6eb9374f@localhost.localdomain>
References: <200701120958.l0C9wICB019343@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53136 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161048AbXALKNk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Jan 2007 05:13:40 -0500
In-Reply-To: <200701120958.l0C9wICB019343@toshiba.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, kou.ishizaki@toshiba.co.jp, benh@kernel.crashing.org, arnd@arndb.de, paulus@samba.org, linas@austin.ibm.com

On Fri, 12 Jan 2007 19:00:45 +0900
Akira Iguchi <akira2.iguchi@toshiba.co.jp> wrote:

> Dear everyone,
> 
> This is the patchset (based on 2.6.20-rc4) to add low-level I/O calls
> which access the taskfile registers. The idea comes from drivers/ide
> IN*/OUT* calls.

I think this is the wrong approach. The existing code provides methods
for things like "read the status", "write a taskfile" and this is the
style that should be kept.

Alan

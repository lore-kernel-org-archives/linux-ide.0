From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH #upstream-fixes] libata: implement libata.force_cbl
 parameter
Date: Tue, 8 Jan 2008 14:40:04 +0000
Message-ID: <20080108144004.30a18457@lxorguk.ukuu.org.uk>
References: <4783786A.6040608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43933 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756698AbYAHOmR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Jan 2008 09:42:17 -0500
In-Reply-To: <4783786A.6040608@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Tue, 08 Jan 2008 22:19:38 +0900
Tejun Heo <htejun@gmail.com> wrote:

> Implement libata.force_cbl parameter to work around incorrect PATA
> cable detection.

This seems to be a pretty hopeless hack as it assumes all your devices
are on the same cable (most boxes now have SATA and PATA). If we are
going to do this we need a way to specify which controller/device as we
will do for geometry forcing and other stuff.

Alan

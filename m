From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH #upstream-fixes] pata_via: fix SATA cable detection on
 cx700
Date: Thu, 7 Feb 2008 01:46:44 +0000
Message-ID: <20080207014644.52cb1b73@core>
References: <47AA5C7D.7000108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33030 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758048AbYBGBwv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Feb 2008 20:52:51 -0500
In-Reply-To: <47AA5C7D.7000108@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Thu, 07 Feb 2008 10:18:53 +0900
Tejun Heo <htejun@gmail.com> wrote:

> The first port of cx700 is SATA.  Fix cable detection.

That should be set anyway by the drive detect but it does no harm and
fixes stuff if there is no drive.

Acked-by: Alan Cox <alan@redhat.com>

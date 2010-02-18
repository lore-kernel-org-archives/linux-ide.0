From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/3] pata_oldpiix: add locking for parallel scanning
Date: Thu, 18 Feb 2010 21:45:31 +0000
Message-ID: <20100218214531.60a08f00@lxorguk.ukuu.org.uk>
References: <20100218185914.16594.61415.sendpatchset@localhost>
	<20100218185928.16594.4054.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:53099 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754186Ab0BRVqV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Feb 2010 16:46:21 -0500
In-Reply-To: <20100218185928.16594.4054.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 18 Feb 2010 19:59:28 +0100
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] pata_oldpiix: add locking for parallel scanning
> 
> Add an extra locking for parallel scanning.
> 
> This is similar change as commit 60c3be3 for ata_piix host driver
> and while pata_oldpiix doesn't enable parallel scan yet the race
> could probably also be triggered by requesting re-scanning of both
> ports at the same time using SCSI sysfs interface.
> 
> Fix documentation while at it.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Alan Cox <alan@linux.intel.com>

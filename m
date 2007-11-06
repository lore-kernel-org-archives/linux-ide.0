From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 11/12] libata: add ATA_CBL_PATA_IGN
Date: Tue, 6 Nov 2007 11:25:19 +0000
Message-ID: <20071106112519.7b7736cf@the-village.bc.nu>
References: <1194327550227-git-send-email-htejun@gmail.com>
	<11943275512264-git-send-email-htejun@gmail.com>
	<20071106105947.6f633868@the-village.bc.nu>
	<473049C4.3090807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50422 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755004AbXKFLYo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Nov 2007 06:24:44 -0500
In-Reply-To: <473049C4.3090807@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

On Tue, 06 Nov 2007 20:02:28 +0900
Tejun Heo <htejun@gmail.com> wrote:

> Alan Cox wrote:
> >> This patch adds ATA_CBL_PATA_IGN which tells libata to ignore the
> >> cable type completely and just let the LLD determine the transfer mode
> >> via host transfer mode masks and ->mode_filter().
> >>
> >> Signed-off-by: Tejun Heo <htejun@gmail.com>
> >> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> > 
> > Acked-by: Alan Cox <alan@redhat.com>
> > 
> 
> I think this can be applied to pata_acpi too as we don't have any idea
> about actual cable there.

Agreed entirely - and its beginning to look like pata_via is also a
candidate as some boards have real issues.

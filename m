From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 05/10] ns87415: use custom ->dma_{start,end} to handle
 ns87415_prepare_drive()
Date: Mon, 09 Mar 2009 01:22:32 +0300
Message-ID: <49B44528.5040308@ru.mvista.com>
References: <20090220171139.25429.26702.sendpatchset@localhost.localdomain> <20090220171215.25429.46593.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:6042 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753521AbZCHWWj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 8 Mar 2009 18:22:39 -0400
In-Reply-To: <20090220171215.25429.46593.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Use custom ->dma_{start,end} methods to handle ns87415_prepare_drive()
> there instead of in ->dma_setup method.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei



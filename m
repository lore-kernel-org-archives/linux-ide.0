From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 09/10] ide: set/clear drive->waiting_for_dma flag in the
 core code
Date: Tue, 10 Mar 2009 18:05:50 +0300
Message-ID: <49B681CE.2060409@ru.mvista.com>
References: <20090220171139.25429.26702.sendpatchset@localhost.localdomain> <20090220171243.25429.21171.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:51216 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754308AbZCJPFL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Mar 2009 11:05:11 -0400
In-Reply-To: <20090220171243.25429.21171.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> Set/clear drive->waiting_for_dma flag in the core code
> instead of in ->dma_setup and ->dma_end methods.

> There should be no functional changes caused by this patch.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei

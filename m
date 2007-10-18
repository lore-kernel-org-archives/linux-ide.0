From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/3] ide: Add ide_get_paired_drive() helper
Date: Thu, 18 Oct 2007 16:00:01 +0400
Message-ID: <47174AC1.7080800@ru.mvista.com>
References: <20071018005621.8F637DDEB8@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:42682 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755952AbXJRL7u (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 18 Oct 2007 07:59:50 -0400
In-Reply-To: <20071018005621.8F637DDEB8@ozlabs.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>

Benjamin Herrenschmidt wrote:

> This adds a helper to get to the "other" drive on a pair connected
> to a given hwif.

    Maibe "mate drive" would've been a better name that "paired"...

> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei

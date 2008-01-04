From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/3] ide-pmac: macio resource freeing bugfix
Date: Fri, 04 Jan 2008 21:32:42 +0300
Message-ID: <477E7BCA.7060206@ru.mvista.com>
References: <200712301824.51003.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:1893 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752450AbYADScD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Jan 2008 13:32:03 -0500
In-Reply-To: <200712301824.51003.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Release DMA resource before zeroing pmif.

> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei

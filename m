From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/4] it8213/piix/slc90e66: "de-couple" PIO and UDMA modes
Date: Fri, 10 Aug 2007 21:06:38 +0400
Message-ID: <46BC9B1E.5010202@ru.mvista.com>
References: <200708092213.40058.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:56296 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753692AbXHJRE2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 10 Aug 2007 13:04:28 -0400
In-Reply-To: <200708092213.40058.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Don't force PIO4 when programming UDMA mode (suggested by Sergei).

    Not sure if it was worth a separte patvh but well...

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei

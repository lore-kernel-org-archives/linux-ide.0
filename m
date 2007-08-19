From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/7] ide: remove "idex=dma" kernel parameter
Date: Sun, 19 Aug 2007 17:38:00 +0400
Message-ID: <46C847B8.1060207@ru.mvista.com>
References: <200708182048.35285.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:61167 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752669AbXHSNfh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 19 Aug 2007 09:35:37 -0400
In-Reply-To: <200708182048.35285.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> It has been obsoleted since 1 Nov 2004, is valid only when used together with
> "ide=nodma" kernel parameter (which makes no sense) and only for aec62xx,
> cmd64x, cs5220, generic, hpt366, sl82c105, tc86c001 and triflex host drivers.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei

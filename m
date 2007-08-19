From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 5/7] ide: add "hdx=nodma" kernel parameter
Date: Sun, 19 Aug 2007 17:43:46 +0400
Message-ID: <46C84912.4040200@ru.mvista.com>
References: <200708182050.50372.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:61185 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752823AbXHSNlW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 19 Aug 2007 09:41:22 -0400
In-Reply-To: <200708182050.50372.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Add "hdx=nodma" option allowing user to disallow DMA for a given device.

> * Obsolete "ide=nodma" option.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei

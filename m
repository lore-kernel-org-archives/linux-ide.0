From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 05/63] ide-cd: add missing 'ireason' masking to cdrom_write_intr()
Date: Fri, 21 Dec 2007 14:55:48 +0300
Message-ID: <476BA9C4.8010608@ru.mvista.com>
References: <200712200155.17499.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:30187 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753734AbXLULz1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Dec 2007 06:55:27 -0500
In-Reply-To: <200712200155.17499.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Mask 'ireason' variable with 0x3 so the valid interrupt reason value
> is passed to cdrom_write_check_ireason() for checking.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei

From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/9] ide: move drive_is_ready() to ide-io.c
Date: Sat, 17 Jan 2009 23:22:48 +0300
Message-ID: <49723E18.5030006@ru.mvista.com>
References: <20090115200032.17294.84745.sendpatchset@localhost.localdomain> <20090115200053.17294.47740.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:10886 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754775AbZAQUWy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 Jan 2009 15:22:54 -0500
In-Reply-To: <20090115200053.17294.47740.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Move drive_is_ready() to ide-io.c, then make it static.
>
> Also make some minor CodingStyle fixups while at it.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei



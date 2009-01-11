From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 5/9] ide: move ide_pktcmd_tf_load() to ide-atapi.c
Date: Mon, 12 Jan 2009 00:18:38 +0300
Message-ID: <496A622E.4080905@ru.mvista.com>
References: <20090106183520.21193.63704.sendpatchset@localhost.localdomain> <20090106183547.21193.43620.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:13309 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751023AbZAKVSn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Jan 2009 16:18:43 -0500
In-Reply-To: <20090106183547.21193.43620.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Then make it static and remove 'dma' argument.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>   

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei



From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] slc90e66: always tune PIO
Date: Fri, 03 Aug 2007 22:13:36 +0400
Message-ID: <46B37050.8070808@ru.mvista.com>
References: <200708030045.10051.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:52106 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757074AbXHCSLi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Aug 2007 14:11:38 -0400
In-Reply-To: <200708030045.10051.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

    Note that setting DMA modes will set the chipset to PIO4.

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei

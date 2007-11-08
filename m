From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 8/18] ide-disk: use ide_get_lba_addr()
Date: Thu, 08 Nov 2007 17:05:14 +0300
Message-ID: <4733179A.4050300@ru.mvista.com>
References: <200711050022.57478.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:54045 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754253AbXKHOFA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Nov 2007 09:05:00 -0500
In-Reply-To: <200711050022.57478.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Export ide_get_lba_addr().

> * Convert idedisk_{read_native,set}_max_address() to use ide_get_lba_addr().

> * Remove incorrect comment from idedisk_read_native_max_address()
>   (noticed by Sergei).

> There should be no functionality changes caused by this patch.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei


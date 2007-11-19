From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 4/21] ide/Kconfig: fix mpc8xx host driver dependencies
Date: Mon, 19 Nov 2007 21:58:02 +0300
Message-ID: <4741DCBA.4050405@ru.mvista.com>
References: <200711182315.19408.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:30204 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750762AbXKSS5t (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Nov 2007 13:57:49 -0500
In-Reply-To: <200711182315.19408.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org

Bartlomiej Zolnierkiewicz wrote:

> Only LWMON, IVMS8, IVML24 and TQM8xxL platforms have the needed
> defines (IDE0_BASE_OFFSET and friends) in the platform header file.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei

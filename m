From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 22/63] ide-cd: remove struct atapi_{mechstat_header,changer_info,slot}
Date: Fri, 21 Dec 2007 15:33:47 +0300
Message-ID: <476BB2AB.60605@ru.mvista.com>
References: <200712200209.24164.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:30574 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750920AbXLUMd0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Dec 2007 07:33:26 -0500
In-Reply-To: <200712200209.24164.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Remove ->changer_info from struct cdrom_info (it is never allocated).

> * Remove unused struct atapi_{mechstat_header,changer_info,slot}.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei


From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 09/63] ide-cd: fix 'ireason' reporting in cdrom_pc_intr()
Date: Fri, 21 Dec 2007 15:01:39 +0300
Message-ID: <476BAB23.70503@ru.mvista.com>
References: <200712200158.32631.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:30229 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751091AbXLUMBS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Dec 2007 07:01:18 -0500
In-Reply-To: <200712200158.32631.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Mask 'ireason' variable so only the valid interrupt reason bits
> will be reported on "drive appears confused" error.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei

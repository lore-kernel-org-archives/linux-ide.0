From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 8/15] ide-cd: fix register loading order in cdrom_start_packet_command()
Date: Sun, 04 Nov 2007 18:44:37 +0300
Message-ID: <472DE8E5.10807@ru.mvista.com>
References: <200710310029.09936.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:11195 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750802AbXKDPo2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 4 Nov 2007 10:44:28 -0500
In-Reply-To: <200710310029.09936.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Load IDE_CONTROL_REG before other registers in cdrom_start_packet_command().

> It shouldn't affect anything (just a usual paranoia to separate changes
> which change the way in which hardware is accessed from code cleanups).

> While at it move misplaced FIXME comment in the right place.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei

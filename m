From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 8/15] ide-cd: fix register loading order in cdrom_start_packet_command()
Date: Fri, 09 Nov 2007 16:47:56 +0300
Message-ID: <4734650C.4060002@ru.mvista.com>
References: <200710310029.09936.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:1220 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759122AbXKINrn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Nov 2007 08:47:43 -0500
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

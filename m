From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 15/21] sgiioc4: always init hwif->io_ports
Date: Tue, 27 Nov 2007 15:55:46 +0300
Message-ID: <474C13D2.2090804@ru.mvista.com>
References: <200711182326.26860.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:42016 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754639AbXK0Mzd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Nov 2007 07:55:33 -0500
In-Reply-To: <200711182326.26860.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Jeremy Higdon <jeremy@sgi.com>

Bartlomiej Zolnierkiewicz wrote:

> 'if (hwif->io_ports[IDE_DATA_OFFSET] != cmd_base)' is always true.

> Cc: Jeremy Higdon <jeremy@sgi.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei


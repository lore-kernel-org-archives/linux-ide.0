From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 7/7] ide: remove hw_regs_t typedef
Date: Fri, 15 May 2009 16:17:00 +0400
Message-ID: <4A0D5D3C.4000805@ru.mvista.com>
References: <20090513205139.28638.87226.sendpatchset@localhost.localdomain> <20090513205231.28638.12447.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:34378 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1762766AbZEOMQT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 15 May 2009 08:16:19 -0400
In-Reply-To: <20090513205231.28638.12447.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> Remove hw_regs_t typedef and rename struct hw_regs_s to struct ide_hw.

> There should be no functional changes caused by this patch.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei


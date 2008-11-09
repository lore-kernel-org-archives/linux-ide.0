From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 11/11] ide: push local_irq_{save,restore}() to do_identify()
Date: Sun, 09 Nov 2008 20:19:41 +0300
Message-ID: <49171BAD.9060306@ru.mvista.com>
References: <20081109162219.18999.74912.sendpatchset@localhost.localdomain> <20081109162331.18999.93299.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:32771 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755409AbYKIRTm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 9 Nov 2008 12:19:42 -0500
In-Reply-To: <20081109162331.18999.93299.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> Push local_irq_{save,restore}() from actual_try_to_identify()
> to do_identify() and remove no longer needed local_irq_enable().

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei

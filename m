From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 03/11] ide: remove dead code from drive_is_ready()
Date: Sun, 09 Nov 2008 20:15:59 +0300
Message-ID: <49171ACF.4020702@ru.mvista.com>
References: <20081109162219.18999.74912.sendpatchset@localhost.localdomain> <20081109162233.18999.12402.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:32762 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755450AbYKIRQA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 9 Nov 2008 12:16:00 -0500
In-Reply-To: <20081109162233.18999.12402.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> We guarantee 400ns delay at the time of issuing the command.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei

From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 06/18] ide: factor out code unregistering devices from
 ide_unregister()
Date: Sat, 09 Feb 2008 21:07:32 +0300
Message-ID: <47ADEBE4.1010607@ru.mvista.com>
References: <20080208004421.17746.32557.sendpatchset@localhost.localdomain> <20080208004502.17746.73284.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:5353 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751563AbYBISGl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 9 Feb 2008 13:06:41 -0500
In-Reply-To: <20080208004502.17746.73284.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Factor out code unregistering devices from ide_unregister() to
> ide_port_unregister_devices().

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei

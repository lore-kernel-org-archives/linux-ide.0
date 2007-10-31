From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/15] ide: CPU endianness doesn't matter for special_t
Date: Wed, 31 Oct 2007 19:40:28 +0300
Message-ID: <4728AFFC.3090705@ru.mvista.com>
References: <200710310024.24262.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:41496 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758051AbXJaQkW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 Oct 2007 12:40:22 -0400
In-Reply-To: <200710310024.24262.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> special_t is used only internally by the IDE subsystem (it isn't
> related to hardware registers and isn't exported to the user-space).

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei

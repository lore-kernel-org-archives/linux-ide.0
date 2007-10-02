From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/3] ide: add CONFIG_IDE_ARCH_OBSOLETE_INIT
Date: Tue, 02 Oct 2007 23:39:35 +0400
Message-ID: <47029E77.6070605@ru.mvista.com>
References: <200709192211.03850.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:24992 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751451AbXJBTjy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Oct 2007 15:39:54 -0400
In-Reply-To: <200709192211.03850.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Add CONFIG_IDE_ARCH_OBSOLETE_INIT to drivers/ide/Kconfig and use it instead
> of defining IDE_ARCH_OBSOLETE_INIT in <arch/ide.h>.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

>  include/asm-arm26/ide.h             |    1 -

    No such file upstream anymore. Looks good otherwise...

MBR, Sergei

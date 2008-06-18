From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: [PATCH] IDE: Fix HDIO_DRIVE_RESET handling
Date: Thu, 19 Jun 2008 01:41:08 +0200
Message-ID: <87ej6uz4yz.fsf@denkblock.local>
References: <87k5gmz596.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:39671 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751000AbYFRXlU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Jun 2008 19:41:20 -0400
In-Reply-To: <87k5gmz596.fsf@denkblock.local> (Elias Oltmanns's message of
	"Thu, 19 Jun 2008 01:35:01 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Elias Oltmanns <eo@nebensachen.de> wrote:
[...]
> The patch below tries to address these issues by handling the
> HDIO_DRIVE_RESET ioctl in-band.

Sorry, I forgot to mention that it applies to the current ide-2.6 tree.

Regards,

Elias

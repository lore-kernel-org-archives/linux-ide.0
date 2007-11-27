From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/21] ide: merge ->fixup and ->quirkproc methods
Date: Tue, 27 Nov 2007 21:39:02 +0300
Message-ID: <474C6446.6080400@ru.mvista.com>
References: <200711182311.35962.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:45386 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756654AbXK0Sit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 13:38:49 -0500
In-Reply-To: <200711182311.35962.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Assign drive->quirk_list in ->quirkproc implementations:
>   - hpt366.c::hpt3xx_quirkproc()
>   - pdc202xx_new.c::pdcnew_quirkproc()
>   - pdc202xx_old.c::pdc202xx_quirkproc()

> * Make ->quirkproc void.

> * Move calling ->quirkproc from do_identify() to probe_hwif().

> * Convert it821x_fixups() to it821x_quirkproc() in it821x.c.

> * Convert siimage_fixup() to sil_quirkproc() in siimage.c, also remove
>   no longer needed drive->present check from is_dev_seagate_sata().

> * Convert ide_undecoded_slave() to accept 'drive' instead of 'hwif'
>   as an argument.  Then convert ide_register_hw() to accept 'quirkproc'
>   argument instead of 'fixup' one.

> * Remove no longer needed ->fixup method.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei

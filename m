From: Alan Pope <alan.pope@gmail.com>
Subject: Fwd: PDC202XX_OLD broken
Date: Mon, 6 Dec 2004 22:12:25 +0000
Message-ID: <8e93903b041206141247586005@mail.gmail.com>
References: <8e93903b041206140529a8baa9@mail.gmail.com>
Reply-To: Alan Pope <alan.pope@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.194]:49222 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261676AbULFWM0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Dec 2004 17:12:26 -0500
Received: by wproxy.gmail.com with SMTP id 71so190314wra
        for <linux-ide@vger.kernel.org>; Mon, 06 Dec 2004 14:12:25 -0800 (PST)
In-Reply-To: <8e93903b041206140529a8baa9@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Added a "Seagate ST3200822A Barracuda 7200.7 Plus 200GB" disk to my
main PC which uses a with "Promise PDC20265 (FastTrak100
Lite/Ultra100) (rev 02)" controller.

I get these when placing the disk under any load (DMA enabled)

hde: dma_intr: status=0xff { Busy }

ide: failed opcode was: unknown
hde: DMA disabled
PDC202XX: Primary channel reset.
PDC202XX: Secondary channel reset.

(a number of times)

ide2: reset timed-out, status=0xff
end_request: I/O error, dev hde, sector 11776
Buffer I/O error on device hde, logical block 1472

(many times)

Any clues, greatfully received.

I've tried under 2.6.8 through 2.6.9-ac9 & 2.6.10-rc2 with the same effect.

Thanks,
Al.

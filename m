From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: libata: CD and dvd devices not recognized
Date: Mon, 19 Mar 2007 15:10:52 +0300
Message-ID: <45FE7DCC.3000507@ru.mvista.com>
References: <45F873AC.6010204@gmail.com> <200703172107.42107.bzolnier@gmail.com> <45FD0F68.7090207@gmail.com> <200703181610.33714.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:48154 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753798AbXCSMLH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Mar 2007 08:11:07 -0400
In-Reply-To: <200703181610.33714.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: YUP <yupadmin@gmail.com>, albertl@mail.com, linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> It seems that the drive works just fine in PIO mode with pdc202xx_new
> IDE driver (it doesn't support ATAPI DMA at the moment)

    There used to be Albert's patch enabling ATAPIT DMA in this driver:

    http://marc.info/?l=linux-ide&m=111027913608663

Oh my, that was 2 years ago, and all slipped thru the cracks... :-)

> Thanks,
> Bart

MBR, Sergei

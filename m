From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: libata: CD and dvd devices not recognized
Date: Tue, 20 Mar 2007 18:23:23 +0300
Message-ID: <45FFFC6B.2060000@ru.mvista.com>
References: <45F873AC.6010204@gmail.com> <200703172107.42107.bzolnier@gmail.com> <45FD0F68.7090207@gmail.com> <200703181610.33714.bzolnier@gmail.com> <45FE7DCC.3000507@ru.mvista.com> <45FF166B.8000303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:58732 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S933606AbXCTPWu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Mar 2007 11:22:50 -0400
In-Reply-To: <45FF166B.8000303@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: YUP <yupadmin@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, albertl@mail.com, linux-ide@vger.kernel.org

Hello.

YUP wrote:

> Well, I checked pata_pdc2027x.c code and found that code completely 
> rewrited. For unexperienced user it is not so easy to apply.

    This patch was to drivers/ide/pci/pdc202xx_new.c -- and I thought libata 
driver had this enabled since then... wait, it *is* enabled there.

> Yarema

>>    There used to be Albert's patch enabling ATAPIT DMA in this driver:

>>    http://marc.info/?l=linux-ide&m=111027913608663

>> Oh my, that was 2 years ago, and all slipped thru the cracks... :-)

MBR, Sergei

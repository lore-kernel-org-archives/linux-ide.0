From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: http://bugzilla.kernel.org/show_bug.cgi?id=11742
Date: Fri, 24 Oct 2008 08:50:43 +0200
Message-ID: <20081024065043.GA4762@gollum.tnic>
References: <20081020112039W.fujita.tomonori@lab.ntt.co.jp> <20081022061207.GB30682@gollum.tnic> <20081022155025S.fujita.tomonori@lab.ntt.co.jp> <200810222215.02762.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:64100 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589AbYJXGux (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Oct 2008 02:50:53 -0400
Received: by fg-out-1718.google.com with SMTP id 19so863207fgg.17
        for <linux-ide@vger.kernel.org>; Thu, 23 Oct 2008 23:50:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200810222215.02762.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, valerio.p@libero.it, linux-ide@vger.kernel.org

Hi,

> Is the culprit REQ_TYPE_BLOCK_PC request or REQ_TYPE_ATA_PC one?

Well, from what I see from the latest traces Valerio sent me, it is always a
REQ_TYPE_BLOCK_PC with sizes for rq->data_len which fail in the alignment test:

rq->data_len: 0xc,
rq->data_len: 0xf810,
rq->data_len: 0xf810,
rq->data_len: 0xf810,
rq->data_len: 0xf810,
rq->data_len: 0xf810,
rq->data_len: 0xf810,
rq->data_len: 0xf810,
rq->data_len: 0xf810,
rq->data_len: 0xf810,
rq->data_len: 0xf810,
rq->data_len: 0xf810,
rq->data_len: 0xf810,
rq->data_len: 0xf810,
rq->data_len: 0xf810,
rq->data_len: 0xf810,
rq->data_len: 0xf810,

Those are, according to Valerio, taken during burning which looks like something
aroung 64K requests which fail the rq->data_len & alignment test where alignment
is 0x1f. The would've passed the old test rq->data_len & 0xf.

/me researching DMA alignment requirements...

-- 
Regards/Gruss,
    Boris.

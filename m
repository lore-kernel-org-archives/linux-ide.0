From: Andy Warner <andyw@pobox.com>
Subject: Re: [SATA] status report, libata-dev queue updated
Date: Fri, 5 Nov 2004 13:26:13 -0600
Message-ID: <20041105132613.A30910@florence.linkmargin.com>
References: <20041105100049.GA31653@havoc.gtf.org> <418BCED3.1030600@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ms-smtp-02.rdc-kc.rr.com ([24.94.166.122]:11757 "EHLO
	ms-smtp-02.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S261163AbUKET15 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Nov 2004 14:27:57 -0500
Content-Disposition: inline
In-Reply-To: <418BCED3.1030600@wasp.net.au>; from brad@wasp.net.au on Fri, Nov 05, 2004 at 11:04:51PM +0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brad Campbell <brad@wasp.net.au>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Brad Campbell wrote:
> [...]
> Read that as "I have tried really, really hard to break it and as yet been unable to".

Is your system SMP ? I'm actively tracking a problem now with
pass-thru behaviour (via /dev/sg* ) on SMP systems.

Symptom is a system freeze after a few messages like
this:

ata3: command 0x34 timeout, stat 0x58 host_stat 0x0
ata2: command 0x24 timeout, stat 0x58 host_stat 0x0
ata3: status=0x58 { DriveReady SeekComplete <4>ATA: abnormal status 0x58 on port 0xF8A3CCC7
ata2: status=0x58 { DriveReady SeekComplete DataRequest }
DataReq

This particular example is of a Read Sectors command pending
on one drive and Write Sectors on another. Don't know if it
is the pio state machine not being SMP-safe, or what just yet.
-- 
andyw@pobox.com

Andy Warner		Voice: (612) 801-8549	Fax: (208) 575-5634

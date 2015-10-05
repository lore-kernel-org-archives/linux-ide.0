From: Guillermo Amaral <g@maral.me>
Subject: Kinston HyperX M.2 PCIe drives
Date: Mon, 5 Oct 2015 09:48:45 -0700
Message-ID: <20151005164845.GA5181@enterprise.localdomain>
Reply-To: g@maral.me
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:35765 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbbJEQsr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Oct 2015 12:48:47 -0400
Received: by ioiz6 with SMTP id z6so191892813ioi.2
        for <linux-ide@vger.kernel.org>; Mon, 05 Oct 2015 09:48:46 -0700 (PDT)
Received: from localhost (201.170.46.200.dsl.dyn.telnor.net. [201.170.46.200])
        by smtp.gmail.com with ESMTPSA id g198sm10573158ioe.6.2015.10.05.09.48.46
        for <linux-ide@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2015 09:48:46 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi guys,

So I got my hands on a Kingston HyperX M.2 PCIe drive and noticed it has
really poor performance on Linux.

I get about half write speed of a SATA III SSD and about half better
read speed than a SATA III SSD (3/2) but somebody actually did a proper
benchmark on Linux:

  http://www.phoronix.com/scan.php?page=article&item=kingston-hyperx-pred

It uses a Marvell 88SS9293 controller, I was wondering if anybody else
has seen simiar issues with this controller or if there's a way to
figure out what's wrong without the datasheet (since it doesn't seem to
be publicly available).

I noticed kept getting FPDMA READ errors while testing it so I disabled
NCQ for now to avoid hangs.

I would love to help get this drive working if anybody can point me in
the right direction: I have dmesg, lcpci, hdparm output available for
anybody interested, I can also dual-boot into a *Winfferent* OS where
the drive works fine.

Cheers,
G

-- 
gamaral


From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [bisected] Re: todays git: WARNING: at
 drivers/ata/libata-sff.c:1017 ata_sff_hsm_move+0x45e/0x750()
Date: Sun, 11 Jan 2009 11:24:36 +0000
Message-ID: <20090111112436.33136222@lxorguk.ukuu.org.uk>
References: <200901091334.55823.borntraeger@de.ibm.com>
	<200901101009.13699.borntraeger@de.ibm.com>
	<20090110104114.633cacd8@lxorguk.ukuu.org.uk>
	<200901101242.05203.borntraeger@de.ibm.com>
	<49688B63.5030105@ru.mvista.com>
	<20090110122130.318cf168@lxorguk.ukuu.org.uk>
	<20090110130745.GA14049@elte.hu>
	<49689EA8.20506@garzik.org>
	<20090110132412.GB14049@elte.hu>
	<20090110133617.GA22304@elte.hu>
	<20090110135731.0da08c90@lxorguk.ukuu.org.uk>
	<4968BA6F.8050207@ru.mvista.com>
	<20090110152800.44308491@lxorguk.ukuu.org.uk>
	<4968C5CA.6010508@ru.mvista.com>
	<4968FFD7.6070302@ru.mvista.com>
	<20090111001038.33943d2e@lxorguk.ukuu.org.uk>
	<4969B956.6010802@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:34785 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753522AbZAKMGw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Jan 2009 07:06:52 -0500
In-Reply-To: <4969B956.6010802@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, Jeff Garzik <jeff@garzik.org>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>

> > The VLB controller docs explicitly require you do entirely 32bit.
> 
>    Didn't VLB contollers largely predate ATAPI devices?

Yes but they generally work with ATAPI.


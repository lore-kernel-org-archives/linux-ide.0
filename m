From: Mark Lord <liml@rtr.ca>
Subject: Re: [CALL-FOR-HELP] pata_ali: can't get MWDMA working!
Date: Wed, 09 Jan 2008 12:25:33 -0500
Message-ID: <4785038D.1030503@rtr.ca>
References: <4784FBC1.7070804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4931 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752024AbYAIRZe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 Jan 2008 12:25:34 -0500
In-Reply-To: <4784FBC1.7070804@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, IDE/ATA development list <linux-ide@vger.kernel.org>, andre@linux-ide.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Are you really sure that the old IDE is actually issuing DMA commands,
rather than falling back to PIO ?

Cheers

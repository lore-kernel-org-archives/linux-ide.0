From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata: Don't trust current capacity values in identify
 words 57-58
Date: Mon, 16 Feb 2009 21:43:48 -0500
Message-ID: <499A2464.2080602@rtr.ca>
References: <4999CA54.1060306@gmail.com> <4999F032.6060107@rtr.ca> <4999FAF2.1000800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:36535 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751799AbZBQCnu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Feb 2009 21:43:50 -0500
In-Reply-To: <4999FAF2.1000800@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, =?UTF-8?B?SGFubm8gQsO2Y2s=?= <hanno@hboeck.de>

Robert Hancock wrote:
..
> This is the !ata_id_has_lba code path. If the drive supports LBA then 
> the LBA capacity will always be used, that hasn't changed.
..

Oh, good.  No problems then!

Cheers

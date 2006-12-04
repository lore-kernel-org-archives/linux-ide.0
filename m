From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] pata_it8213: Add new driver for the IT8213 card.
Date: Mon, 04 Dec 2006 17:38:22 -0500
Message-ID: <4574A35E.60007@pobox.com>
References: <20061204164931.7d36d744@localhost.localdomain>	<20061204124344.a7c21221.akpm@osdl.org> <20061204215558.63bc4e90@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38770 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937434AbWLDWi1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Dec 2006 17:38:27 -0500
In-Reply-To: <20061204215558.63bc4e90@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Alan wrote:
>> Was the duplication of timings[] deliberate?
> 
> It's actually duplicated in all the PIIX/ICH-alike drivers. I could move
> it in them all. Jeff - its copied from your piix driver - shall I move
> them all ?

Please do...

	Jeff




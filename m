From: Tejun Heo <htejun@gmail.com>
Subject: Re: [patch 2/2] sata_via: Delay on vt6420 when starting ATAPI DMA
 	write
Date: Wed, 20 Jan 2010 15:54:24 +0900
Message-ID: <4B56A8A0.3050309@gmail.com>
References: <20100116235653.898098245@gmail.com>	 <20100116235851.884756038@gmail.com> <4B5678E2.2050709@gmail.com>	 <4B568C63.4050506@gmail.com> <7eb6a4d81001192233i5418249ct5a1717045f75167c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:53651 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231Ab0ATGsU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Jan 2010 01:48:20 -0500
In-Reply-To: <7eb6a4d81001192233i5418249ct5a1717045f75167c@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bart Hartgers <bart.hartgers@gmail.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, juergen.metzdorf@telelev-dsl.de, markpschool@hotmail.com, sporadic.crash@gmail.com, apopov@sirma.bg, david@coomber.co.za, jay4mail@gmail.com

Hello,

On 01/20/2010 03:33 PM, Bart Hartgers wrote:
> Well, the ata_sff_pause actually does a ndelay(400), and with today's
> processors that would be a 'slow path', right?

unlikely() is used to mark very unlikely paths not the slow ones and I
don't really think DMA_TO_DEVICE would qualify as an unlikely path.

Thanks.

-- 
tejun

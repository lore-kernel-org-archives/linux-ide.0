From: Bart Hartgers <bart.hartgers@gmail.com>
Subject: Re: [patch 2/2] sata_via: Delay on vt6420 when starting ATAPI DMA
	write
Date: Wed, 20 Jan 2010 11:43:17 +0100
Message-ID: <7eb6a4d81001200243k7ca637cco25d319a43edf86f5@mail.gmail.com>
References: <20100116235653.898098245@gmail.com>
	 <20100116235851.884756038@gmail.com> <4B5678E2.2050709@gmail.com>
	 <4B568C63.4050506@gmail.com>
	 <7eb6a4d81001192233i5418249ct5a1717045f75167c@mail.gmail.com>
	 <4B56A8A0.3050309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f209.google.com ([209.85.219.209]:36938 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962Ab0ATKnV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Jan 2010 05:43:21 -0500
In-Reply-To: <4B56A8A0.3050309@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, juergen.metzdorf@telelev-dsl.de, markpschool@hotmail.com, sporadic.crash@gmail.com, apopov@sirma.bg, david@coomber.co.za, jay4mail@gmail.com

Hi,

2010/1/20 Tejun Heo <htejun@gmail.com>:
> Hello,
>
> On 01/20/2010 03:33 PM, Bart Hartgers wrote:
>> Well, the ata_sff_pause actually does a ndelay(400), and with today's
>> processors that would be a 'slow path', right?
>
> unlikely() is used to mark very unlikely paths not the slow ones and I
> don't really think DMA_TO_DEVICE would qualify as an unlikely path.
>

Ok, I am convinced; I'll drop the unlikely.

Groeten,
Bart

> Thanks.
>
> --
> tejun
>



-- 
Bart Hartgers - New e-mail: bart.hartgers@gmail.com

From: Matt Sealey <matt@genesi-usa.com>
Subject: Re: SATA open bugs
Date: Thu, 09 Aug 2007 12:17:50 +0100
Message-ID: <46BAF7DE.7010003@genesi-usa.com>
References: <32209efe0708081531o4215bac5teac2113c3518c743@mail.gmail.com> <46BA9101.6080407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mithrandir.softwarenexus.net ([66.98.186.96]:2409 "EHLO
	mail.genesi-usa.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756672AbXHILQs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Aug 2007 07:16:48 -0400
In-Reply-To: <46BA9101.6080407@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Natalie Protasevich <protasnb@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Alan <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>


Tejun Heo wrote:
> Hello, Natalie.
> 
>> http://bugzilla.kernel.org/show_bug.cgi?id=8649
> 
> This one is chrp specific.  The native mode fix didn't work.  I'll
> follow up later.

Following up in private with original porter now.

I really think this is a combination of a chip bug and firmware
configuration being futzed. We might have to leave IRQ steering
at 14/15 even in PCI mode, because the ISA bridge isn't so smart
as the docs imply it is.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

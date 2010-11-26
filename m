From: Tejun Heo <tj@kernel.org>
Subject: Re: sata_sil24: external raid storage mistaken as port multiplier
Date: Fri, 26 Nov 2010 21:16:03 +0100
Message-ID: <4CF01583.5050307@kernel.org>
References: <1290461073.12443.21.camel@Tobias-Karnat>	 <1290514125.28293.2.camel@Tobias-Karnat> <1290572588.24847.20.camel@Tobias-Karnat> <4CEFEC17.6060503@kernel.org> <4CF014F8.9000700@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37159 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751077Ab0KZUQJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 26 Nov 2010 15:16:09 -0500
In-Reply-To: <4CF014F8.9000700@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: Tobias Karnat <tobias.karnat@googlemail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello,

On 11/26/2010 09:13 PM, Mark Lord wrote:
>> That said, yeah, it probably would be a good idea to add a
>> libata.force param.
> 
> How about some form of auto-detection instead?

That's a device which reports that it's a PMP but fails to behave
itself as one.  The sucky thing is that depending on the current mode
and firmware revision, the same hardware can actually bahave as a
pretty decent PMP.  I frankly have no idea how to work it around.

-- 
tejun

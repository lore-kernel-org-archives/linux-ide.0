From: Mark Lord <kernel@teksavvy.com>
Subject: Re: ahci: CAP_SSS and parallel scan
Date: Thu, 06 May 2010 16:19:22 -0400
Message-ID: <4BE3244A.7060607@teksavvy.com>
References: <4BE27C49.5090809@kernel.org> <4BE28C4F.9000903@linux.intel.com> <4BE2D5D6.1010705@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:29108 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932277Ab0EFUT0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 May 2010 16:19:26 -0400
In-Reply-To: <4BE2D5D6.1010705@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>, Jeff Garzik <jeff@garzik.org>, t.artem@mailcity.com, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On 06/05/10 03:49 PM, Jeff Garzik wrote:
>
>> Currently, there's no way to tell whether staggered spin up is needed
>> or drives are already spun up.

Perhaps by issuing a "CHECK POWER MODE" command?
For many drives, a non-spinning drive is detectable from its IDENTIFY data.

Cheers

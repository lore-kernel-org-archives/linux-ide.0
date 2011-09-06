From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH #upstream-fixes] libata: clear PIO pad area
Date: Tue, 06 Sep 2011 14:06:23 +0400
Message-ID: <4E65F09F.6020508@ru.mvista.com>
References: <20110906040905.GD18425@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:42846 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754047Ab1IFKHJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Sep 2011 06:07:09 -0400
Received: by wwf5 with SMTP id 5so6031921wwf.1
        for <linux-ide@vger.kernel.org>; Tue, 06 Sep 2011 03:07:08 -0700 (PDT)
In-Reply-To: <20110906040905.GD18425@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@linux.intel.com>, linux-ide@vger.kernel.org, tom.leiming@gmail.com

Hello.

On 06-09-2011 8:09, Tejun Heo wrote:

> ata_sff_data_xfer[32]() use pad area if the transfer size isn't
> multiple of transfer size; however, this area wasn't cleared and
> garbage data in pad area could be transferred to the device.  Make
> sure the pad area is cleared.

> Signed-off-by: Tejun Heo<tj@kernel.org>
> Cc: Lei Ming<tom.leiming@gmail.com>

    And what's the problem with garbage data? Why it's worse than 0s?

WBR, Sergei

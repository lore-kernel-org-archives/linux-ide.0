From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/6] sata_nv: kill not-working hotplug code
Date: Tue, 20 Jun 2006 05:09:22 -0400
Message-ID: <4497BB42.4070008@pobox.com>
References: <11505269952304-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:42184 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030189AbWFTJJY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Jun 2006 05:09:24 -0400
In-Reply-To: <11505269952304-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

applied 1-6, then applied a cset to s/spin_lock_irqsave/spin_lock/


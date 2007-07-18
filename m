From: Tejun Heo <htejun@gmail.com>
Subject: Re: ALi SATA problem
Date: Wed, 18 Jul 2007 18:35:00 +0900
Message-ID: <469DDEC4.6080908@gmail.com>
References: <200707181117.41129.pavel@netsafe.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.236]:21184 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751535AbXGRJfG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jul 2007 05:35:06 -0400
Received: by nz-out-0506.google.com with SMTP id s18so113911nze
        for <linux-ide@vger.kernel.org>; Wed, 18 Jul 2007 02:35:05 -0700 (PDT)
In-Reply-To: <200707181117.41129.pavel@netsafe.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pavel Mateja <pavel@netsafe.cz>
Cc: linux-ide@vger.kernel.org

Pavel Mateja wrote:
> ata2: exception Emask 0x10 SAct 0x0 SErr 0x4060000 action 0x2 frozen
> ata2: (irq_stat 0x00000040, connection status changed)
> ata4: exception Emask 0x10 SAct 0x0 SErr 0x4060000 action 0x2 frozen
> ata4: (irq_stat 0x00000040, connection status changed)
> ata2: soft resetting port

Please check power supply and re-cable things.

-- 
tejun

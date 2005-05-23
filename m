From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: DMA not works in Linux 2.6.12, but in Windows works fine.
Date: Mon, 23 May 2005 14:34:26 -0400
Message-ID: <42922232.90206@pobox.com>
References: <web-135595327@mail5.rambler.ru> <20050523193010.5bf72481.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:38601 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261929AbVEWSec (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 May 2005 14:34:32 -0400
In-Reply-To: <20050523193010.5bf72481.vsu@altlinux.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: Ivan G <g-i-v@rambler.ru>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Sergey Vlasov wrote:
> To IDE developers: Is something planned to work around this problem?
> AFAIK, there are some machines where BIOS does not provide an option to
> turn off the combined mode.

This limitation exists because two drivers (drivers/ide and libata) want 
to use different parts of the same hardware.

Once libata can do ATAPI 100%, when we can just let libata handle both 
PATA and SATA, which will enable DMA again.

	Jeff



From: Mark Lord <lkml@rtr.ca>
Subject: Re: DMA not works in Linux 2.6.12, but in Windows works fine.
Date: Tue, 24 May 2005 12:21:31 -0400
Message-ID: <4293548B.2000100@rtr.ca>
References: <web-135595327@mail5.rambler.ru> <20050523193010.5bf72481.vsu@altlinux.ru> <42922232.90206@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:6671 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S262112AbVEXQVd
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 May 2005 12:21:33 -0400
In-Reply-To: <42922232.90206@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Sergey Vlasov <vsu@altlinux.ru>, Ivan G <g-i-v@rambler.ru>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Note to others:

If you are brave and pull down Jeff's libata-dev tree,
then it already has ATAPI DMA working (mostly) therein.

That's what I've done on my newest ICH6M machine here,
and both the PATA HD and PATA DVD-RW are working just fine
in "combined mode" using ata_piix.  After applying a bugfix
patch for ATAPI error handling (which Jeff has just posted
here today somewhere for general comments).

Cheers.

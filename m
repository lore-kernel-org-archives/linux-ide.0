From: Tejun Heo <tj@kernel.org>
Subject: Re: Maybe a bug in libata-core
Date: Mon, 23 Aug 2010 11:27:01 +0200
Message-ID: <4C723EE5.9050408@kernel.org>
References: <4C71C645.8050007@stud.tu-ilmenau.de>	<4C723C65.6080303@kernel.org> <20100823104400.37cfb3f0@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-14
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35341 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751643Ab0HWJcg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Aug 2010 05:32:36 -0400
In-Reply-To: <20100823104400.37cfb3f0@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: stefan.huebner@stud.tu-ilmenau.de, jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello,

On 08/23/2010 11:44 AM, Alan Cox wrote:
> It's user triggerable (as root I grant) so really shouldn't be
> generating WARNs in that case either - just an -EIO.

I still want to keep WARN_ON_ONCE() tho.  It will help detecting
possible breakage in the many code paths prepping data vectors through
block, SCSI, DMA API and whatnot.  Silent AC_ERR_SYSTEM failure can be
pretty difficult to track down and it's not like WARN_ON_ONCE() can be
used as an attack vector.

Thanks.

-- 
tejun

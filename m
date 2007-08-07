From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: implement BROKEN_HPA horkage and apply it to
 HDS724040KLSA80
Date: Wed, 08 Aug 2007 00:00:28 +0900
Message-ID: <46B8890C.7090403@gmail.com>
References: <20070807054250.GQ13674@htj.dyndns.org> <20070807115105.4f5cbc66@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.185]:52253 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756782AbXHGPAf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Aug 2007 11:00:35 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1416276rvb
        for <linux-ide@vger.kernel.org>; Tue, 07 Aug 2007 08:00:33 -0700 (PDT)
In-Reply-To: <20070807115105.4f5cbc66@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, stable@kernel.org, kelk1@comcast.net

Luiz Fernando N. Capitulino wrote:
> Em Tue, 7 Aug 2007 14:42:50 +0900
> Tejun Heo <htejun@gmail.com> escreveu:
> 
> | HDS724040KLSA80 reports that it supports HPA && LBA48 but craps itself
> | on READ_NATIVE_MAX_EXT.  Implement BROKEN_HPA horkage and apply it to
> | the drive.  If the horkage is set, all HPA operations are skipped.
> | 
> | While at it, make HPA test a bit more reliable by also checking
> | ata_id_has_hpa().
> 
>  Tejun, is the following patch ok for 2.6.22.1?

Yeah, looks okay to me but -stable needs to wait for upstream merge.

Thanks.

-- 
tejun

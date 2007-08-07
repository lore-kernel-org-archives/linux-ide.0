From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: Re: [PATCH] libata: implement BROKEN_HPA horkage and apply it to
 HDS724040KLSA80
Date: Tue, 7 Aug 2007 12:04:48 -0300
Message-ID: <20070807120448.245481f8@localhost>
References: <20070807054250.GQ13674@htj.dyndns.org>
	<20070807115105.4f5cbc66@localhost>
	<46B8890C.7090403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from perninha.conectiva.com.br ([200.140.247.100]:57120 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934457AbXHGPE5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Aug 2007 11:04:57 -0400
In-Reply-To: <46B8890C.7090403@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, stable@kernel.org, kelk1@comcast.net

Em Wed, 08 Aug 2007 00:00:28 +0900
Tejun Heo <htejun@gmail.com> escreveu:

| Luiz Fernando N. Capitulino wrote:
| > Em Tue, 7 Aug 2007 14:42:50 +0900
| > Tejun Heo <htejun@gmail.com> escreveu:
| > 
| > | HDS724040KLSA80 reports that it supports HPA && LBA48 but craps itself
| > | on READ_NATIVE_MAX_EXT.  Implement BROKEN_HPA horkage and apply it to
| > | the drive.  If the horkage is set, all HPA operations are skipped.
| > | 
| > | While at it, make HPA test a bit more reliable by also checking
| > | ata_id_has_hpa().
| > 
| >  Tejun, is the following patch ok for 2.6.22.1?
| 
| Yeah, looks okay to me but -stable needs to wait for upstream merge.

 Okay, I'll that version in Mandriva.

 Thanks a lot, Tejun.

-- 
Luiz Fernando N. Capitulino

From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: Re: Problems with 1GB SimpleTech CF Card
Date: Wed, 24 May 2006 16:03:45 +0200
Message-ID: <447467C1.9060505@imc-berlin.de>
References: <447436B3.4090906@imc-berlin.de> <44746566.6040601@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:57095 "EHLO
	mail.imc-berlin.de") by vger.kernel.org with ESMTP id S932600AbWEXODt
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 24 May 2006 10:03:49 -0400
Received: from mailserver.berlin.imc-berlin.de (mailserver.berlin.imc-berlin.de [10.0.0.19])
	by mail.imc-berlin.de (Postfix) with ESMTP id CCFA82F023
	for <linux-ide@vger.kernel.org>; Wed, 24 May 2006 16:03:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mailserver.berlin.imc-berlin.de (Postfix) with ESMTP id C03C41E20EE
	for <linux-ide@vger.kernel.org>; Wed, 24 May 2006 16:03:48 +0200 (CEST)
Received: from [10.0.2.10] (scholz.berlin.imc-berlin.de [10.0.2.10])
	by mailserver.berlin.imc-berlin.de (Postfix) with ESMTP id E61A41213E
	for <linux-ide@vger.kernel.org>; Wed, 24 May 2006 16:03:47 +0200 (CEST)
In-Reply-To: <44746566.6040601@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-ide@vger.kernel.org

Mark,

>> When doing "mke2fs /dev/hda1" after 30 seconds I get
>>
>>     hda: irq timeout: status=0xd0 { Busy }
>>     ide: failed opcode was: unknown
>>     ide0: reset: master: error (0x00?)
> 
> Mmmm.. No idea, but one thing to try is "hdparm -W0" on the card,
> and see if that makes any difference.

No. It does not make any difference. Thanks.

BTW:
a) Windows does its famous Blue Screen when accessing the card. So it looks
like this special CF card is broken.
b) I got a new one today. SLCF1GBJ-F. Same revision (7.0.0) and same
firmware (05/03/04) and same geometry. Only that this one reports "fixed"
and not "removable". But this can NOT be the reason for one working and the
other not working! (I hardcoded the config->id value ...)


--
Steven

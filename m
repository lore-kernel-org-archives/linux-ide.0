From: "Luciano A. Stertz" <luciano@tteng.com.br>
Subject: Re: T10/04-262 ATA pass thru - patch.
Date: Wed, 06 Oct 2004 09:21:24 -0300
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4163E344.3040609@tteng.com.br>
References: <20040928001633.A8363@florence.linkmargin.com> <415AFF27.7080906@tteng.com.br> <415AFFBB.8090503@pobox.com> <4162EDA3.1030202@tteng.com.br> <20041005140653.A13393@florence.linkmargin.com> <41631DEC.9090404@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 200-203-041-086.paemt7002.e.brasiltelecom.net.br ([200.203.41.86]:37970
	"EHLO einstein.tteng.com.br") by vger.kernel.org with ESMTP
	id S269225AbUJFMPp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 6 Oct 2004 08:15:45 -0400
In-Reply-To: <41631DEC.9090404@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andy Warner <andyw@pobox.com>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Andy Warner wrote:
> 
>> Luciano A. Stertz wrote:
>>
>>> [...]
>>>     Am I supposed to be able to run any ATA command from user-space 
>>> now, then? Let's say I want to run a IDENTIFY DEVICE, how can I do 
>>> that? I tried SG_IO, but sg_allow_access blocks my request since the 
>>> 'ATA_16' command isn't recognized yet. Is there another way?
>>
>>
>>
>> I am using SG_IO to issue arbitrary ATA commands. Unfortunately
>> I can't share that customer code with you, sorry. But have
>> faith that you can do it. I've not had sg_allow_access()
>> get in my way doing this - I'll find out why not and report
>> back; I did not modify sg.c.
> 
> 
> Probably you were running as root, and Luciano was not (guessing)
	I'm running as root. But there are many other variables in my 
environment... for example, I tried to back port the patch to an older 
2.4 kernel. Don't take my problem too seriously for now... I'll let you 
know if I discover something else.

-- 
Luciano A. Stertz
luciano@tteng.com.br
T&T Engenheiros Associados Ltda
http://www.tteng.com.br
Fone/Fax (51) 3224 8425

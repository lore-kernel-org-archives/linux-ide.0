From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: T10/04-262 ATA pass thru - patch.
Date: Tue, 05 Oct 2004 18:19:24 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <41631DEC.9090404@pobox.com>
References: <20040928001633.A8363@florence.linkmargin.com> <415AFF27.7080906@tteng.com.br> <415AFFBB.8090503@pobox.com> <4162EDA3.1030202@tteng.com.br> <20041005140653.A13393@florence.linkmargin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57823 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266183AbUJEWTi
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 5 Oct 2004 18:19:38 -0400
In-Reply-To: <20041005140653.A13393@florence.linkmargin.com>
List-Id: linux-ide@vger.kernel.org
To: Andy Warner <andyw@pobox.com>
Cc: "Luciano A. Stertz" <luciano@tteng.com.br>, linux-ide@vger.kernel.org

Andy Warner wrote:
> Luciano A. Stertz wrote:
> 
>>[...]
>>	Am I supposed to be able to run any ATA command from user-space now, 
>>then? Let's say I want to run a IDENTIFY DEVICE, how can I do that? I 
>>tried SG_IO, but sg_allow_access blocks my request since the 'ATA_16' 
>>command isn't recognized yet. Is there another way?
> 
> 
> I am using SG_IO to issue arbitrary ATA commands. Unfortunately
> I can't share that customer code with you, sorry. But have
> faith that you can do it. I've not had sg_allow_access()
> get in my way doing this - I'll find out why not and report
> back; I did not modify sg.c.

Probably you were running as root, and Luciano was not (guessing)

	Jeff




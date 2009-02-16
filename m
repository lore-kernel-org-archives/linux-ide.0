From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 14/18] ide: use ->tf_read in ide_read_error()
Date: Mon, 16 Feb 2009 15:13:10 +0300
Message-ID: <49995856.0@ru.mvista.com>
References: <20080620213323.13202.71450.sendpatchset@localhost.localdomain> <20080620213458.13202.77992.sendpatchset@localhost.localdomain> <4998A37D.3040904@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:58136 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754472AbZBPMNQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Feb 2009 07:13:16 -0500
In-Reply-To: <4998A37D.3040904@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello, I wrote:

>> * Add IDE_TFLAG_IN_FEATURE taskfile flag for reading Feature
>>   register and handle it in ->tf_read.
>>   
>
>  Doesn't seem like a good name -- you can't read the features 
> register. I should've commented to this patch earlier, of course...

   Moreover, the error register shoudn't be affeceted by the HOB bit, so 
this flag doesn't make sense.

MBR, Sergei



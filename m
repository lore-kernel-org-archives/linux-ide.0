From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: blacklist NCQ on OCZ CORE 2 SSD (resend)
Date: Tue, 30 Dec 2008 09:35:06 +0900
Message-ID: <49596CBA.8090903@kernel.org>
References: <494F6D6A.2010406@dsrg.mff.cuni.cz> <49588CBF.80002@kernel.org> <495899A9.8030507@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50475 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751709AbYL3Afn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Dec 2008 19:35:43 -0500
In-Reply-To: <495899A9.8030507@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: =?UTF-8?B?THVib23DrXIgQnVsZWo=?= <lubomir.bulej@dsrg.mff.cuni.cz>, jgarzik@pobox.com, linux-ide@vger.kernel.org

Sergei Shtylyov wrote:
> Hello.
> 
> Tejun Heo wrote:
> 
>>> The patchlet below blacklists NCQ on OCZ CORE v2 SSD drive(s). Even
>>> though the drive advertises NCQ support with queue depth 1, it responds
>>> with all-zeroes FIS to NCQ commands which triggers ata error handling
>>> several times before the kernel decides to disable NCQ on the drive.
>>>
>>> signed-off-by: Lubomir Bulej <lubomir.bulej@dsrg.mff.cuni.cz>
>>>     
>>
>> Please capitalize the leading s and add --- separator between
>> description and the patch body.
> 
>   Why Lubomir needs to add --- if there's no diffstat or comments? :-

Hmm... now come to think of it, you're right.  I guess I'm now just
too accustomed to seeing it.

Thanks.

-- 
tejun

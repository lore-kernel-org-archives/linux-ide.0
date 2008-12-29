From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] libata: blacklist NCQ on OCZ CORE 2 SSD (resend)
Date: Mon, 29 Dec 2008 12:34:33 +0300
Message-ID: <495899A9.8030507@ru.mvista.com>
References: <494F6D6A.2010406@dsrg.mff.cuni.cz> <49588CBF.80002@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:50656 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752976AbYL2Jej (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Dec 2008 04:34:39 -0500
In-Reply-To: <49588CBF.80002@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: =?UTF-8?B?THVib23DrXIgQnVsZWo=?= <lubomir.bulej@dsrg.mff.cuni.cz>, jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello.

Tejun Heo wrote:

>> The patchlet below blacklists NCQ on OCZ CORE v2 SSD drive(s). Even
>> though the drive advertises NCQ support with queue depth 1, it responds
>> with all-zeroes FIS to NCQ commands which triggers ata error handling
>> several times before the kernel decides to disable NCQ on the drive.
>>
>> signed-off-by: Lubomir Bulej <lubomir.bulej@dsrg.mff.cuni.cz>
>>     
>
> Please capitalize the leading s and add --- separator between
> description and the patch body.
>   

   Why Lubomir needs to add --- if there's no diffstat or comments? :-O

MBR, Sergei



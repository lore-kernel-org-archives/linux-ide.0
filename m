From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] drivers/ata/libata-eh.c: fix unused variable warning
Date: Fri, 23 Apr 2010 09:52:46 -0400
Message-ID: <4BD1A62E.5070602@garzik.org>
References: <1271858846-1706-1-git-send-email-antonf@turbolinux.com.cn> <20100421152404.62699040@lxorguk.ukuu.org.uk> <4BCF1247.8080508@gmail.com> <4BCFA50E.80800@gmail.com> <4BD13E84.2040204@kernel.org> <20100423064332.GA22988@shell.devel.redhat.com> <4BD145B0.8080102@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f227.google.com ([209.85.217.227]:52111 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757492Ab0DWNwu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Apr 2010 09:52:50 -0400
Received: by gxk27 with SMTP id 27so1495412gxk.1
        for <linux-ide@vger.kernel.org>; Fri, 23 Apr 2010 06:52:49 -0700 (PDT)
In-Reply-To: <4BD145B0.8080102@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jgarzik@redhat.com>, Fang Wenqi <anton.fang@gmail.com>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, antonf@turbolinux.com.cn

On 04/23/2010 03:01 AM, Tejun Heo wrote:
> Hello, Jeff.
>
> On 04/23/2010 08:43 AM, Jeff Garzik wrote:
>> On Fri, Apr 23, 2010 at 08:30:28AM +0200, Tejun Heo wrote:
>>> On 04/22/2010 03:23 AM, Fang Wenqi wrote:
>>>> Sorry that the title should be:
>>>>   "fix uninitialized variable warning"
>>>>
>>>> not
>>>> "fix unused variable warning"
>>>>
>>>> Need I re-send the patch mail ?
>>>
>>> Yes, please do so.  gcc 4.4.1 generates a spurious warning on it too.
>>>
>>> Acked-by: Tejun Heo<tj@kernel.org>
>>
>> It's not a spurious warning.  The code failed to fully initialize all
>> fields of the ata_taskfile structure, prior to copying the ata_taskfile
>> structure into qc->result_tf.
>
> Hmmmm.... right, I've always thought it was gcc not noticing the
> structure is being initialized in ata_eh_read_log_10h() but it
> actually is noticing much more, so something like the following is
> more appropriate?
>
> Subject: libata: fully initialize @tf in ata_eh_read_log_10h()
>
> ata_eh_read_log_10h() filled @tf only partially.  It didn't cause any
> correctness issues but triggered spruious uninitialized variable
> warning.  Do ata_tf_init() before filling in @tf.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>

Sorry, I should have also pointed out that a fix went upstream to Linus 
in the last batch of fixes...

	Jeff





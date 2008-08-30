From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: [PATCH] ide: Build fix for CONFIG_IDE_PROC_FS=n
Date: Sat, 30 Aug 2008 18:23:21 +0200
Message-ID: <87wshympza.fsf@denkblock.local>
References: <20080829213217.4826.91622.stgit@denkblock.local>
	<48B92CB6.2090702@ru.mvista.com> <48B92D7A.7020701@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:41867 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752604AbYH3QXd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 30 Aug 2008 12:23:33 -0400
In-Reply-To: <48B92D7A.7020701@ru.mvista.com> (Sergei Shtylyov's message of
	"Sat, 30 Aug 2008 15:22:34 +0400")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> Hello, I have just written:
>>> Recent changes have broken compilation when CONFIG_IDE_PROC_FS is
>
>>> not set.
>>>
>>> Signed-off-by: Elias Oltmanns <eo@nebensachen.de>
>>>   
>> [...]
>>> diff --git a/drivers/ide/ide-disk.h b/drivers/ide/ide-disk.h
>>> index f937772..5254cae 100644
>>> --- a/drivers/ide/ide-disk.h
>>> +++ b/drivers/ide/ide-disk.h
>>> @@ -23,8 +23,10 @@ ide_decl_devset(acoustic);
>>>  /* ide-disk_ioctl.c */
>>>  int ide_disk_ioctl(struct inode *, struct file *, unsigned int,
>>> unsigned long);
>>>  +#ifdef CONFIG_IDE_PROC_FS
>>>  /* ide-disk_proc.c */
>>>  extern ide_proc_entry_t ide_disk_proc[];
>>>  extern const struct ide_proc_devset ide_disk_settings[];
>>> +#endif /* CONFIG_IDE_PROC_FS */
>>>   #endif /* __IDE_DISK_H */
[...]
>>
>>   Is surrounding 'extern' declarations by #ifdef's really of any value?
>>   They shouldn't be used if CONFIG_IDE_PROC_FS=n, so no object file
>> records should be generated.
>
>   Ah, you probably mean to turn the possible link time errors if the
> do get referenced into the compile time errors...

Sorry, I don't quite understand that last sentence. But we definitely
have compile time errors here because the compiler doesn't even know of
ide_proc_entry_t when CONFIG_IDE_PROC_FS is not set. Therefore the
forward declarations appear to be syntactically incorrect, regardless
whether extern or not.

Regards,

Elias

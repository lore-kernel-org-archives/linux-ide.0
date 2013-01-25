From: Simon Que <sque@chromium.org>
Subject: Re: [PATCH v3] ata: libata-core: initialize native_sectors in ata_hpa_resize()
Date: Fri, 25 Jan 2013 15:31:57 -0800
Message-ID: <CANV8Hs0dyU7jcO0WqdU6JqcaUPNHhOQF7vKcqCB0tkTVgiSxYw@mail.gmail.com>
References: <1359057478-3920-1-git-send-email-sque@chromium.org>
	<51026AD1.7070202@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ee0-f51.google.com ([74.125.83.51]:54430 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753441Ab3AYXcC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Jan 2013 18:32:02 -0500
Received: by mail-ee0-f51.google.com with SMTP id d17so446028eek.38
        for <linux-ide@vger.kernel.org>; Fri, 25 Jan 2013 15:31:58 -0800 (PST)
In-Reply-To: <51026AD1.7070202@mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: linux-ide@vger.kernel.org, Mandeep Baines <msb@chromium.org>

I'm using a ChromeOS / ChromiumOS gcc.

Technically it won't be used uninitialized since there's a check for
the return value.  But this isn't always obvious to the compiler --
it'd have to be smart enough to look at ata_read_native_max_address()
to see that if '*max_sectors' is not set, then there is a nonzero
return value, which would cause ata_hpa_resize() to return early.

This patch is really meant to satisfy the compiler, rather than to
catch some corner case where 'native_sectors' gets used uninitialized.
 Setting it to 0 makes more sense because its "true initialization" is
in a later call.

On Fri, Jan 25, 2013 at 3:21 AM, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
> Hello.
>
>
> On 24-01-2013 23:57, Simon Que wrote:
>
>> Eliminates a compiler warning about uninitialized variable.
>> "warning: 'native_sectors' may be used uninitialized in this function"
>
>
>> Signed-off-by: Simon Que <sque@chromium.org>
>> ---
>>   drivers/ata/libata-core.c |    2 +-
>>   1 files changed, 1 insertions(+), 1 deletions(-)
>
>
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index d2b18ea..b185db1 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -1324,7 +1324,7 @@ static int ata_hpa_resize(struct ata_device *dev)
>>         int print_info = ehc->i.flags & ATA_EHI_PRINTINFO;
>>         bool unlock_hpa = ata_ignore_hpa || dev->flags &
>> ATA_DFLAG_UNLOCK_HPA;
>>         u64 sectors = ata_id_n_sectors(dev->id);
>> -       u64 native_sectors;
>> +       u64 native_sectors = 0;
>
>
>    Isn't it wiser to set it to 'sectors'? And frankly speaking I don't see
> how this variable may indeed be used unitialized. What version of gcc are
> you using?
>
> MBR, Sergei
>

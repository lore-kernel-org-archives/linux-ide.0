From: Aubin LaBrosse <aubin@stormboxes.com>
Subject: Re: [PATCH] Replace assert() with WARN_ON in drivers/scsi/libata-core.c
Date: Mon, 13 Feb 2006 19:20:38 -0500
Message-ID: <43F12256.1050702@stormboxes.com>
References: <20060213233518.15196.57162.stgit@localhost.localdomain> <43F119D0.5080103@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070003090206050903040401"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.stormboxes.com ([207.234.184.232]:47253 "EHLO
	dedicated.stormboxes.com") by vger.kernel.org with ESMTP
	id S1030331AbWBNAUk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Feb 2006 19:20:40 -0500
In-Reply-To: <43F119D0.5080103@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------070003090206050903040401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jeff Garzik wrote:
> Aubin LaBrosse wrote:
>> Replace assert() with WARN_ON in drivers/scsi/libata-core.c
>>
>> This is my first patch to the kernel - this work was suggested by 
>> Jeff Garzik as a janitorial task for libata.  If I could get some 
>> feedback letting me know that this is the correct format and my tools 
>> are setup right, I'll do the rest of these.
>>
>> Signed-off-by: Aubin LaBrosse <aubin@stormboxes.com>
>> ---
>>
>>  drivers/scsi/libata-core.c |   46 
>> ++++++++++++++++++++++----------------------
>>  1 files changed, 23 insertions(+), 23 deletions(-)
>
> Someone already beat you to it :)
>
> I looked over your patch anyway.  It looks acceptable, except we avoid 
> the '~' style in such tests:
>
> +    WARN_ON(qc == NULL);    /* ata_qc_from_tag _might_ return NULL */
> +    WARN_ON(~qc->flags & ATA_QCFLAG_ACTIVE);
>
>     Jeff
>
So what would be the proper way to invert that type of test?  (!(field & 
flag)) will do the same, right?  is that preferred for anything other 
than aesthetic reasons? (which is a fine reason to prefer something, of 
course, I'm just wondering if there's any other reasons, performance or 
otherwise

-aubin

--------------070003090206050903040401
Content-Type: text/x-vcard; charset=utf-8;
 name="aubin.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="aubin.vcf"

begin:vcard
fn:Aubin LaBrosse
n:LaBrosse;Aubin
email;internet:aubin@stormboxes.com
tel;work:589-0692
tel;home:429-1520
tel;cell:493-0121
version:2.1
end:vcard


--------------070003090206050903040401--

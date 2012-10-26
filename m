From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] pata_arasan_cf: declare/use 'qc' and 'ap' variables in
 arasan_cf_dma_start()
Date: Fri, 26 Oct 2012 22:17:58 +0400
Message-ID: <508AD3D6.6080502@mvista.com>
References: <201210252108.47085.sshtylyov@ru.mvista.com> <CAOh2x==5iy4cDvney8uue2V10Ok1m+v5zeRJjqsw4Tk16reMaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:47300 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965556Ab2JZSTG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Oct 2012 14:19:06 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so2579868lag.19
        for <linux-ide@vger.kernel.org>; Fri, 26 Oct 2012 11:19:05 -0700 (PDT)
In-Reply-To: <CAOh2x==5iy4cDvney8uue2V10Ok1m+v5zeRJjqsw4Tk16reMaQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: viresh kumar <viresh.kumar@linaro.org>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, jgarzik@pobox.com, spear-devel <spear-devel@list.st.com>

Hello.

On 10/26/2012 07:31 AM, viresh kumar wrote:

>> 'acdev->qc' and 'acdev->qc->ap' expressions are used multiple times in this
>> function, so it makes sense to use the local variables for them.

>> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

  Another idea came to me afterwards...

>> ---
>> The patch is atop of the 'upstream' branch of libata-dev.git...
>>
>>  drivers/ata/pata_arasan_cf.c |    6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)

>> Index: libata-dev/drivers/ata/pata_arasan_cf.c
>> ===================================================================
>> --- libata-dev.orig/drivers/ata/pata_arasan_cf.c
>> +++ libata-dev/drivers/ata/pata_arasan_cf.c
>> @@ -668,13 +668,15 @@ void arasan_cf_error_handler(struct ata_
>>
>>  static void arasan_cf_dma_start(struct arasan_cf_dev *acdev)
>>  {
>> +       struct ata_queued_cmd *qc = acdev->qc;
>> +       struct ata_port *ap = qc->ap;
>>         u32 xfer_ctr = readl(acdev->vbase + XFER_CTR) & ~XFER_DIR_MASK;
>> -       u32 write = acdev->qc->tf.flags & ATA_TFLAG_WRITE;
>> +       u32 write = qc->tf.flags & ATA_TFLAG_WRITE;
>>
>>         xfer_ctr |= write ? XFER_WRITE : XFER_READ;
>>         writel(xfer_ctr, acdev->vbase + XFER_CTR);
>>
>> -       acdev->qc->ap->ops->sff_exec_command(acdev->qc->ap, &acdev->qc->tf);
>> +       ap->ops->sff_exec_command(ap, &qc->tf);


   Perhaps it was also worth declaring:

	struct ata_taskfile *tf = &qc->tf;

   I'll submit the next version of patch next week, probably...

MBR, Sergei


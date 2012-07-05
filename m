From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH v2 2/2] ata: implement MODE SELECT command
Date: Thu, 05 Jul 2012 23:42:33 +0400
Message-ID: <4FF5EE29.6020706@mvista.com>
References: <1341481235-12708-1-git-send-email-pbonzini@redhat.com> <1341481235-12708-3-git-send-email-pbonzini@redhat.com> <4FF57DAA.8010405@mvista.com> <4FF58320.1050606@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:41719 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755838Ab2GEToB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Jul 2012 15:44:01 -0400
Received: by bkwj10 with SMTP id j10so3817443bkw.19
        for <linux-ide@vger.kernel.org>; Thu, 05 Jul 2012 12:43:59 -0700 (PDT)
In-Reply-To: <4FF58320.1050606@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

Hello.

On 07/05/2012 04:05 PM, Paolo Bonzini wrote:

>>> +
>>> +    /*
>>> +     * No mode subpages supported (yet) but asking for _all_
>>> +     * subpages may be valid
>>> +     */
>>> +    if (spg && (spg != ALL_SUB_MPAGES))
>>> +        goto invalid_param;

>>    Rather "paramater not supported" (0x26/0x01)...

> SCSI spec begs to differ... there is no reference to that sense code in
> the whole SPC spec.

   Right you are, I was just picking the more fitting ASC/ASCQ from the table
instead of reading the command description itself. :-<

MBR, Sergei

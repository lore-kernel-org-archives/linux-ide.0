From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [Fwd: - ide-remove-dma_base2-field-form-ide_hwif_t.patch removed
 from -mm tree]
Date: Wed, 26 Jul 2006 23:23:47 +0400
Message-ID: <44C7C143.5050201@ru.mvista.com>
References: <44C52CCE.7070204@ru.mvista.com> <20060724225703.GD776006@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:18311 "EHLO imap.sh.mvista.com")
	by vger.kernel.org with ESMTP id S1751112AbWGZTZB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Jul 2006 15:25:01 -0400
In-Reply-To: <20060724225703.GD776006@sgi.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeremy Higdon <jeremy@sgi.com>
Cc: Jes Sorensen <jes@sgi.com>, Brent Casavant <bcasavan@sgi.com>, jpk@sgi.com, Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux IDE <linux-ide@vger.kernel.org>

Hello.

Jeremy Higdon wrote:

>>   Alan and Andrew wanted me to coordinate the change with SGI before 
>>recasting this patch because the sgiioc4.c is the only real user of the
>>'dma_base2' field which the IDE maintaner wanted me to remove. The use of
>>this field in this driver doesn't seem necessary or even well grounded -- 
>>hwif_data seem to fit the task better... Will you ACK this change?

> This patch won't apply with the line wrapping in the email.  Can you please
> resend?  You can turn off the "format=flowed" tag in your mailer or send as
> an attachment.

    Done, after being recast. Please ACK or NAK.

> The field is necessary for proper operation of the driver.

    My point is that there's better choice -- with hwif_data we can get rid of 
the typecasts. dma_base2 should just go away.

> jeremy

WBR, Sergei

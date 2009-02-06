From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/3 v2] AT91: initialize Compact Flash on AT91SAM9263
 cpu
Date: Fri, 06 Feb 2009 20:23:55 +0300
Message-ID: <498C722B.6060808@ru.mvista.com>
References: <200902061214.19789.stf_xl@wp.pl> <498C2A57.6010908@ru.mvista.com> <200902061433.19490.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:25211 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752796AbZBFRXb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 6 Feb 2009 12:23:31 -0500
In-Reply-To: <200902061433.19490.stf_xl@wp.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-ide@vger.kernel.org, Andrew Victor <avictor.za@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk

Stanislaw Gruszka wrote:

>>>+void __init at91_add_device_cf(struct at91_cf_data *data)
>>>+{

>>[...]

>>>+	/* enable EBI controlled pins */
>>>+	at91_set_A_periph(AT91_PIN_PD5, 1);  /* NWAIT */
>>>+	at91_set_A_periph(AT91_PIN_PD8, 0);  /* CFCE1 */
>>>+	at91_set_A_periph(AT91_PIN_PD9, 0);  /* CFCE2 */
>>>+	at91_set_A_periph(AT91_PIN_PD14, 0); /* CFNRW */
>>>+
>>>+	if (data->flags & AT91_CF_TRUE_IDE)

>>   Again, I've probably missed something but this structre doesn't have 
>>the 'flags' field. How is this suppoed to compile?

> Patch 2/3 add flags to the at91_cf_data structure.

    Ah, stupid me. Haven't looked at that patch yet. :-<

> Stanislaw Gruszka

MBR, Sergei

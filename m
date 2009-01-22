From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [RFC][PATCH] at91_ide driver
Date: Thu, 22 Jan 2009 16:38:58 +0300
Message-ID: <497876F2.3070405@ru.mvista.com>
References: <200901141345.42583.stf_xl@wp.pl> <497863B6.4040306@ru.mvista.com> <49786572.1030408@ru.mvista.com> <200901221357.27247.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:26992 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751886AbZAVNi0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 22 Jan 2009 08:38:26 -0500
In-Reply-To: <200901221357.27247.stf_xl@wp.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, linux-ide@vger.kernel.org

Stanislaw Gruszka wrote:

>>>>>>>+            t9 = t2i - t1;

>>>>>>   It  more sense to calculate such things *after* quantizing the 
>>>>>>timings with calc_mck_cycles()...

>>>>>Why?

>>>>  More precise result -- matching the clock being used.

>>>  However, I don't understand now why you need to stretch t9...

>>  Ah, I do again. t0 *should be equal* to t1 + t2 + t9 for the better 
>>speeds.

    Moreover, t1 + t2 + t9 must be no less that t0 minimum, otherwise it would 
be a timing violation.

> And hold time should meet min t2i requirement, so t9 = max(t9_orig, t2i - t1).

    There's no direct connection between these in ATA/CF specs.

> Stanislaw Gruszka

WBR, Sergei


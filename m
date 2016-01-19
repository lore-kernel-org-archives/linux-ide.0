From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2] libata: disable forced PORTS_IMPL for >= AHCI 1.3
Date: Tue, 19 Jan 2016 20:23:43 +0300
Message-ID: <569E711F.6090404@cogentembedded.com>
References: <CALCETrU7yMvXEDhjAUShoHEhDwifJGapdw--BKxsP0jmjKGmRw@mail.gmail.com>
 <20160114223732.GG3520@mtj.duckdns.org>
 <20160115201305.GN3520@mtj.duckdns.org> <569A16E1.7010708@cogentembedded.com>
 <20160119172217.GQ3520@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:36578 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756874AbcASRXr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Jan 2016 12:23:47 -0500
Received: by mail-lf0-f43.google.com with SMTP id h129so148797895lfh.3
        for <linux-ide@vger.kernel.org>; Tue, 19 Jan 2016 09:23:46 -0800 (PST)
In-Reply-To: <20160119172217.GQ3520@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hello.

On 01/19/2016 08:22 PM, Tejun Heo wrote:

>>> +	/* fabricate port_map from cap.nr_ports for < AHCI 1.3 */
>>> +	if (!port_map && (!(vers >> 16) ||
>>> +			  ((vers >> 16) == 1 && (vers & 0xFFFF) < 0x300))) {
>>
>>      Hm, won't just (vers < 0x1300) just work?
>
> lol, indeed.  Lemme update the patch.

    Oops. 0x10300, of course.

> Thanks.

MBR, Sergei


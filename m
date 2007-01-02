From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: [PATCH 2.6.20-rc2-mm1] HPT36x PCI clock detection fix
Date: Tue, 2 Jan 2007 21:20:33 +0100
Message-ID: <58cb370e0701021220l55725639g5545a16d2f0e0ccc@mail.gmail.com>
References: <200612302236.36285.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:12977 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755281AbXABUUf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Jan 2007 15:20:35 -0500
Received: by nf-out-0910.google.com with SMTP id o25so7433714nfa
        for <linux-ide@vger.kernel.org>; Tue, 02 Jan 2007 12:20:34 -0800 (PST)
In-Reply-To: <200612302236.36285.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

On 12/30/06, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> Fix minor coding mistake in the HPT36x PCI clock detection code noticed by
> Bartlomiej Zolnierkiewicz -- it always reported 33 MHz due to the missing
> 'break' statements.  This, however, most probably never mattered -- in fact,
> I was thinking of removing the 25/40 MHz cases completely since HPT36x BIOSes
> didn't seem to set any other value than 7 into the 'cmd_high_time' field, i.e.
> supported only 33 MHz PCI.
>
> Note that in the original driver there was another bug: 25 and 40 MHz cases
> were interchanged.  Since the 'cmd_high_time' field is in units of PCI clocks,
> a lower clock count just *cannot* correspond to a higher frequency, i. e. it
> should be 5 for 25 MHz PCI and 9 for 40 MHz PCI, not the other way around.
>
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

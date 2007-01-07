From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: [PATCH 2.6.20-rc2-mm1] PIIX tuneproc() fixes/cleanups
Date: Sun, 7 Jan 2007 02:23:50 +0100
Message-ID: <58cb370e0701061723j2a290f8dydadd80eff4bb622b@mail.gmail.com>
References: <200612302101.20679.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:42701 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932302AbXAGBXw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 6 Jan 2007 20:23:52 -0500
Received: by nf-out-0910.google.com with SMTP id o25so8950472nfa
        for <linux-ide@vger.kernel.org>; Sat, 06 Jan 2007 17:23:51 -0800 (PST)
In-Reply-To: <200612302101.20679.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

On 12/30/06, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> Fix/cleanup the driver's tuneproc() and ratemask() methods:
>
> - PPE, IE, and TIME bits need to be cleared beforehand for the slave drive as
>   well as master (Alan probably just forgot about it);
>
> - this driver only supports PIO modes up to 4, so must pass the correct limit
>   to ide_get_best_pio_mode();
>
> - use min_t() macro instead of min();
>
> - simplify slave vs master drive evaluation;
>
> - do come coding and formatting cleanups...
>
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

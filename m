From: "Maurizio Monge" <maurizio.monge@gmail.com>
Subject: Re: HSM violation with ahci+WDC WD1600BEVS-22RST0
Date: Mon, 24 Sep 2007 23:52:51 +0200
Message-ID: <e4c519350709241452l33c2f1b6m8ab943460248656f@mail.gmail.com>
References: <138995186.20070924163607@efirst.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.188]:40720 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753615AbXIXVwx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Sep 2007 17:52:53 -0400
Received: by fk-out-0910.google.com with SMTP id z23so1851503fkz
        for <linux-ide@vger.kernel.org>; Mon, 24 Sep 2007 14:52:51 -0700 (PDT)
In-Reply-To: <138995186.20070924163607@efirst.ro>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Catalin Constantin <catalin@efirst.ro>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

No, i did not manage to improve (it should NOT be a dangerous error BTW).
I simply think that this issue is because of buggy firmware, so i
posted to linux-ide a patch to blacklist this hard disk from using NCQ
(because it is triggering spurious completions).
I don't know what the "blacklisting policy" is for linux kernel
developers, i think that, since there probably are a lot of buggy
drives for NCQ and so, a module parameter to disable NCQ while loading
libata could be useful.
Best regards.

On 9/24/07, Catalin Constantin <catalin@efirst.ro> wrote:
> Hello,
>
> Did you manage to find out why were you getting thoes messages ATA
> related ?
>
> I am having the same issue and some help would be very handy.
>
> Thank you and sorry for disturbing you,
>
> --
> Catalin Constantin
> Efirst - www.efirst.ro
> http://www.cabanova.ro
>
>


-- 
Ciao
Maurizio
http://stregatto.wordpress.com

"Well we all shine on
Like the moon and the stars and the sun" (John Lennon)

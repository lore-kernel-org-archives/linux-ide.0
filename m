From: Tejun Heo <htejun@gmail.com>
Subject: Re: Stardom SATA HSM violation
Date: Fri, 07 Sep 2007 09:58:59 +0900
Message-ID: <46E0A253.7060803@gmail.com>
References: <46CFA08E.6090604@arbores.ca>	<6bffcb0e0708261610g10d9c59ck5789fac6feca9f42@mail.gmail.com>	<46DBCB6C.8080206@gmail.com> <20070905095327.6277d054.akpm@linux-foundation.org> <46DEE617.4050004@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:36645 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964896AbXIGA7J (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Sep 2007 20:59:09 -0400
Received: by wa-out-1112.google.com with SMTP id v27so364056wah
        for <linux-ide@vger.kernel.org>; Thu, 06 Sep 2007 17:59:09 -0700 (PDT)
In-Reply-To: <46DEE617.4050004@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Andrew Morton <akpm@linux-foundation.org>, michal.k.k.piotrowski@gmail.com, bryan@arbores.ca, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello,

Mark Lord wrote:
> I reported a very similar bug back a few releases ago.
> Anyone who wants to try it themselves, can do this with hdparm-7.7 (from
> sourceforge):
> 
>    hdparm --drq-hsm-error /dev/sda
> 
> Whether or not it hangs the machine does depend upon exactly which SATA
> LLD is used,
> and what model/revision of drive is installed.  But if it hangs for you
> (eg. Tejun),
> then you now have a way to reproduce a HSM error "on demand" for
> testing.  :)

Neat.  Is this the FIFO-draining issue?

Thanks.

-- 
tejun

From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] pata_arasan_cf: declare/use 'qc' and 'ap' variables in arasan_cf_dma_start()
Date: Fri, 26 Oct 2012 23:50:38 +0530
Message-ID: <CAKohpon8P=Ah0b2gduC+1URex4BpCTtA7_2ynNdcGG77BAifUw@mail.gmail.com>
References: <201210252108.47085.sshtylyov@ru.mvista.com>
	<CAOh2x==5iy4cDvney8uue2V10Ok1m+v5zeRJjqsw4Tk16reMaQ@mail.gmail.com>
	<508AD3D6.6080502@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:39653 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965556Ab2JZSUj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Oct 2012 14:20:39 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so2394990iag.19
        for <linux-ide@vger.kernel.org>; Fri, 26 Oct 2012 11:20:38 -0700 (PDT)
In-Reply-To: <508AD3D6.6080502@mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, jgarzik@pobox.com, spear-devel <spear-devel@list.st.com>

On 26 October 2012 23:47, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
>    Perhaps it was also worth declaring:
>
>         struct ata_taskfile *tf = &qc->tf;
>
>    I'll submit the next version of patch next week, probably...

Looks fine. Add my acked-by in advance :)

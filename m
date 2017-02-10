From: tedheadster <tedheadster@gmail.com>
Subject: Re: [PATCH] pata_legacy: Allow disabling of legacy PATA device probes
 on non-PCI systems
Date: Thu, 9 Feb 2017 19:36:59 -0500
Message-ID: <CAP8WD_aQQ6gNLoiWZbFWR6y2A8gtV42J6ePvRm+9aHQLQhvMzA@mail.gmail.com>
References: <CAP8WD_bS61spyQkd7cvktFf_dPc0wgNZ8qEa7GVrXgUobHQdvw@mail.gmail.com>
 <20170119213737.GB25133@mtj.duckdns.org> <CAP8WD_Y1HmuMots4HcQ06gQfs0fCh1W_y=Qa0As3MX1YA+LEKg@mail.gmail.com>
 <20170120191946.GA9280@mtj.duckdns.org> <20170120193828.GB9280@mtj.duckdns.org>
 <CAMHSBOVS+ehZkHG7nnUS9qQoDXKmsiBUEhBbPb=3qA2-ZaQ2Ow@mail.gmail.com>
 <CAP8WD_aya3junhovXtc=iUaaX43=Y1s8-eya_LvN_BQjXGLbew@mail.gmail.com>
 <20170124161937.GE12281@htj.duckdns.org> <CAP8WD_b2PXXXQgTQ_-a=8Z7ppNMa5xGuhsEvJGDT_WvT1EFwog@mail.gmail.com>
 <CAMHSBOUAMxTj7u5Jg4_VkxHmG5BUCr-AhDHY2UT+VMchn8daLQ@mail.gmail.com>
 <20170208194330.GB25826@htj.duckdns.org> <CAMHSBOU0tNyPzNuNyQkW2m+PpaoevZaZA4VTqRWO3jJB955qTw@mail.gmail.com>
Reply-To: whiteheadm@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yb0-f177.google.com ([209.85.213.177]:35226 "EHLO
        mail-yb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752286AbdBJAip (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 9 Feb 2017 19:38:45 -0500
Received: by mail-yb0-f177.google.com with SMTP id o65so6768079ybo.2
        for <linux-ide@vger.kernel.org>; Thu, 09 Feb 2017 16:37:20 -0800 (PST)
In-Reply-To: <CAMHSBOU0tNyPzNuNyQkW2m+PpaoevZaZA4VTqRWO3jJB955qTw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: Tejun Heo <tj@kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

I just tested this patch and it is working for me.

- Matthew

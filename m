From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] pata_legacy: Allow disabling of legacy PATA device
 probes on non-PCI systems
Date: Fri, 10 Feb 2017 08:19:18 -0500
Message-ID: <20170210131918.GA11963@mtj.duckdns.org>
References: <20170120191946.GA9280@mtj.duckdns.org>
 <20170120193828.GB9280@mtj.duckdns.org>
 <CAMHSBOVS+ehZkHG7nnUS9qQoDXKmsiBUEhBbPb=3qA2-ZaQ2Ow@mail.gmail.com>
 <CAP8WD_aya3junhovXtc=iUaaX43=Y1s8-eya_LvN_BQjXGLbew@mail.gmail.com>
 <20170124161937.GE12281@htj.duckdns.org>
 <CAP8WD_b2PXXXQgTQ_-a=8Z7ppNMa5xGuhsEvJGDT_WvT1EFwog@mail.gmail.com>
 <CAMHSBOUAMxTj7u5Jg4_VkxHmG5BUCr-AhDHY2UT+VMchn8daLQ@mail.gmail.com>
 <20170208194330.GB25826@htj.duckdns.org>
 <CAMHSBOU0tNyPzNuNyQkW2m+PpaoevZaZA4VTqRWO3jJB955qTw@mail.gmail.com>
 <CAP8WD_aQQ6gNLoiWZbFWR6y2A8gtV42J6ePvRm+9aHQLQhvMzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yb0-f195.google.com ([209.85.213.195]:35561 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751452AbdBJN21 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Feb 2017 08:28:27 -0500
Received: by mail-yb0-f195.google.com with SMTP id j82so1348015ybg.2
        for <linux-ide@vger.kernel.org>; Fri, 10 Feb 2017 05:28:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAP8WD_aQQ6gNLoiWZbFWR6y2A8gtV42J6ePvRm+9aHQLQhvMzA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: whiteheadm@acm.org, Gwendal Grignou <gwendal@google.com>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Thu, Feb 09, 2017 at 07:36:59PM -0500, tedheadster wrote:
> I just tested this patch and it is working for me.

Awesome, Gwendal, care to write up the path description?

Thanks.

-- 
tejun

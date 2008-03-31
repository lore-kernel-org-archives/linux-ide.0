From: "Grant Grundler" <grundler@google.com>
Subject: Re: [patch 2/2] pata_amd: fix sparse warning
Date: Sun, 30 Mar 2008 20:12:57 -0700
Message-ID: <da824cf30803302012h7406c7cdid190d15d56106172@mail.gmail.com>
References: <200803282133.m2SLXutE011470@imap1.linux-foundation.org>
	 <47EE6B84.4070907@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:36078 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753044AbYCaDNB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 30 Mar 2008 23:13:01 -0400
Received: from zps37.corp.google.com (zps37.corp.google.com [172.25.146.37])
	by smtp-out.google.com with ESMTP id m2V3CwAn003306
	for <linux-ide@vger.kernel.org>; Mon, 31 Mar 2008 04:12:59 +0100
Received: from wf-out-1314.google.com (wfg23.prod.google.com [10.142.7.23])
	by zps37.corp.google.com with ESMTP id m2V3CvFd008189
	for <linux-ide@vger.kernel.org>; Sun, 30 Mar 2008 20:12:58 -0700
Received: by wf-out-1314.google.com with SMTP id 23so1526038wfg.5
        for <linux-ide@vger.kernel.org>; Sun, 30 Mar 2008 20:12:57 -0700 (PDT)
In-Reply-To: <47EE6B84.4070907@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, harvey.harrison@gmail.com, alan@lxorguk.ukuu.org.uk

On Sat, Mar 29, 2008 at 9:17 AM, Jeff Garzik <jeff@garzik.org> wrote:
...
>  > +     UT = T;
>  > +     if (clock >= 2)
>  > +             UT = T / 2;
>
>  Why assign UT twice, potentially?

This construct used in many places in the kernel because it
makes the code more readable.

"UT" is a regular "int" type and assigning it twice is ok.

e.g. from tg3_writephy():
...
        ret = -EBUSY;
        if (loops != 0)
                ret = 0;

hth,
grant

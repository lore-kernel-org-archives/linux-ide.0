From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.24 sata_sil Sil3114 drive clicking / restarting?
Date: Sat, 02 Feb 2008 14:17:13 +0900
Message-ID: <47A3FCD9.80908@gmail.com>
References: <76366b180801271019w47e5fafan6ec6b7f3086e3c2@mail.gmail.com>	 <20080127183332.GA19385@jim.sh> <76366b180801271121kf3119d7w89bca2f0315a4ca9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:5112 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760469AbYBBFRV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 Feb 2008 00:17:21 -0500
Received: by rv-out-0910.google.com with SMTP id k20so967398rvb.1
        for <linux-ide@vger.kernel.org>; Fri, 01 Feb 2008 21:17:21 -0800 (PST)
In-Reply-To: <76366b180801271121kf3119d7w89bca2f0315a4ca9@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Paprocki <andrew@ishiboo.com>
Cc: Jim Paris <jim@jtan.com>, linux-ide@vger.kernel.org

Andrew Paprocki wrote:
> Both drives already had PM disabled, visible in hdparm -i:
> "AdvancedPM=yes: disabled (255) WriteCache=enabled"
> 
> Looking at the smart reporting, it is showing both drives have a
> FAILING_NOW condition for Seek_Error_Rate. I don't know what to
> believe, because it seems like whatever drives I attach to this system
> are chewed up and start showing Seek_Error_Rate failure conditions.
> 
> /dev/sda:
>  7 Seek_Error_Rate         0x000b   046   046   067    Pre-fail
> Always   FAILING_NOW 393853
> /dev/sdb:
>  7 Seek_Error_Rate         0x000b   044   044   067    Pre-fail
> Always   FAILING_NOW 2556544
> 
> I swapped in 2 more drives of the same model, and one exhibits the
> same Seek_Error_Rate FAILING_NOW condition. I now have 4 out of 5 of
> this same model drive which are failing. They appear to be from the
> same batch, so I'm not ruling out some kind of manufacturing defect,
> but this definitely seems strange. I guess I'm just fishing to see if
> there is anything on the system that could have damaged the drives.

Can you connect the drive to a separate different SPU and see whether
the problem persists?

-- 
tejun

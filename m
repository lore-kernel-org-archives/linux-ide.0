From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_promise TX2/TX4 cards rejecting smart auto-offline & auto-save
 ata cmds?
Date: Tue, 30 Jan 2007 10:57:23 +0900
Message-ID: <45BEA603.5000502@gmail.com>
References: <76366b180610292250n400fff81s76a2a9cd84d61366@mail.gmail.com> <4545A74E.8020604@gmail.com> <76366b180610292331t6827f0ddl54ffe24be39dea2c@mail.gmail.com> <4545AD0B.1030903@gmail.com> <20070129074844.GA15177@jim.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.233]:26701 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630AbXA3B5d (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Jan 2007 20:57:33 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1514880nze
        for <linux-ide@vger.kernel.org>; Mon, 29 Jan 2007 17:57:33 -0800 (PST)
In-Reply-To: <20070129074844.GA15177@jim.sh>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jim Paris <jim@jtan.com>
Cc: Bruce Allen <ballen@gravity.phys.uwm.edu>, Andrew Paprocki <andrew@ishiboo.com>, linux-ide@vger.kernel.org

Jim Paris wrote:
> Tejun Heo wrote:
>> Andrew Paprocki wrote:
>>> On 10/30/06, Tejun Heo <htejun@gmail.com> wrote:
>>>> Please read the following thread.
>>>>
>>>> http://thread.gmane.org/gmane.linux.ide/13222/focus=13235
>>> Worked like a charm! Just patched up smartmontools now and I don't get
>>> the failed cmds anymore. Hope Bruce takes that patch soon.
>> Bruce took the patch and it will be included in the next version of 
>> smartmontools.  :-)
> 
> Hello Tejun, Bruce,
> 
> Sorry to bring up an old thread, but it looks like this patch did not
> actually make it into smartmontools 5.37 or CVS.  Tejun, could you
> please take another look and update the patch?  There's a new user of
> STRANGE_BUFFER_LENGTH and I don't know enough about the code to fix
> it properly.

I definitely can do that but I guess we need Bruce's confirmation about
the patch first.  Bruce?

-- 
tejun

From: Tejun Heo <htejun@gmail.com>
Subject: Re: ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive
 0x0) r0xj0
Date: Thu, 04 Jan 2007 12:16:18 +0900
Message-ID: <459C7182.4020000@gmail.com>
References: <f4527be0612271812p7282de31j98462aebde16e5a1@mail.gmail.com> <45933A53.1090702@gmail.com> <loom.20070103T020347-255@post.gmane.org> <459B140C.1060401@gmail.com> <Pine.LNX.4.64.0701030334460.12309@dolores.legate.org> <459B2DEA.8080202@gmail.com> <Pine.LNX.4.64.0701031733001.1969@dolores.legate.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.236]:13171 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932267AbXADDQZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Jan 2007 22:16:25 -0500
Received: by nz-out-0506.google.com with SMTP id s1so2992927nze
        for <linux-ide@vger.kernel.org>; Wed, 03 Jan 2007 19:16:24 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0701031733001.1969@dolores.legate.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bbee <bumble.bee@xs4all.nl>
Cc: Andrew Lyon <andrew.lyon@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

bbee wrote:
> Sorry, I thought you meant you would need to update it *further*. I
> applied the patch you gave to Andrew with this result so far:
> 
> $ dmesg | grep -A1 "spurious interrupt"
> ata1: spurious interrupt (irq_stat 0x8 active_tag 0xfafbfcfd sactive 0x0)
> ata1: issue=0x0 SAct=0x0 SDB_FIS=004040a1:00000008
> -- 
> ata1: spurious interrupt (irq_stat 0x8 active_tag 0xfafbfcfd sactive 0x0)
> ata1: issue=0x0 SAct=0x0 SDB_FIS=004040a1:00000001

Ek... Your problem is similar too.

> No luck yet triggering the exception.
> 
> On Wed, 3 Jan 2007, Andrew Lyon wrote:
>> Alan said he was going to add the drive to a blacklist he was
>> maintaining for NCQ, perhaps that has been done in kernel 2.6.19, I
>> dont know as I am still running 2.6.18.
>>
>> Perhaps the WD Raptor drive that I have does have lousy NCQ and that
>> explains both the poor performance and the spurious interrupts.
> 
> Blacklisting NCQ on the drive(s) for all controllers might be ill
> advised, since it could be a JMicron-specific issue (or ahci-specific,
> since the person in the thread I referenced had a different ahci
> controller..). Either that, or both our drive models have "lousy NCQ"..

If it turns out to be drive's fault, I'm afraid there's no other
solution than blacklisting those drives on all controllers.  It's
protocol violation on drive's side, so I don't think there is an easy
way out here except for firmware upgrade.  I'm asking people about this,
so please be patient.

-- 
tejun

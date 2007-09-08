From: Tejun Heo <htejun@gmail.com>
Subject: Re: a disk timeout and a disk state
Date: Sat, 08 Sep 2007 17:00:22 +0900
Message-ID: <46E25696.4000504@gmail.com>
References: <5d96567b0709040009o2b1580fel4bcd91e629b5bef3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:38149 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753802AbXIHRH6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Sep 2007 13:07:58 -0400
Received: by rv-out-0910.google.com with SMTP id k20so690083rvb
        for <linux-ide@vger.kernel.org>; Sat, 08 Sep 2007 10:07:58 -0700 (PDT)
In-Reply-To: <5d96567b0709040009o2b1580fel4bcd91e629b5bef3@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Raz <raziebe@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Raz wrote:
> Jeff Hello
> 
> We have in our machines several sata (mostly maxtor-segate) disks in an array.
> These disks generate too many ata-io errors at clients sites.
> From raid1 code I have learned that a re-write sometimes fixes a disk.
> 
> Question: Why ?
> Question: Does it always work ?
> Question: Does rewriting a slow sector also reduces a disk error rate,
> does it make any sense ?

You need to post much more information to get anyone on the list interested.

* lspci -nn
* boot log (/var/log/boot.msg on some distros or the result of dmesg
after boot)
* kernel error messages (dmesg after errors)

-- 
tejun


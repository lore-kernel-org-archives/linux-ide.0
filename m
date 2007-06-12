From: Matt Sealey <matt@genesi-usa.com>
Subject: Re: [PROBLEM + PATCH] Sata port disabled by BIOS gets initialized
Date: Tue, 12 Jun 2007 19:31:07 +0100
Message-ID: <466EE66B.1040905@genesi-usa.com>
References: <20056641.1181568752111.JavaMail.root@wombat.diezmil.com> <466D8C4C.8040605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mithrandir.softwarenexus.net ([66.98.186.96]:1105 "EHLO
	mail.genesi-usa.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771AbXFLTF1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Jun 2007 15:05:27 -0400
In-Reply-To: <466D8C4C.8040605@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: shyam_iyer@dell.com, linux-ide@vger.kernel.org


Tejun Heo wrote:
> Hello,
>
>> If the user decides to disable the port through the BIOS, the driver
>> needs to respect the user's wish to not use the port and carry on.
>> Here the end result is a forceful reinitialization of the port by the
>> driver against the user's wishes.
> 
> Well, currently, the Linux driver policy is to exploit the hardware
> capability to the maximum - e.g. we unlock HPA unconditionally and force
> multi-mode controllers into its best possible mode.  We try hard to
> ignore BIOS imposed settings/limits.

Isn't there a case for speeding up boot and not wasting resources by
respecting BIOS settings in this regard? If you have an 8-port
controller on a board and one disk, forcing all of them enabled
regardless of BIOS settings is just 7 redundant port scans.

It should at least be an option - the default being to open up all
gunports, an option to respect BIOS settings and only use the ones
requested and enabled.. (I can see an edge case where a user disables
a disk in the BIOS to stop another OS from looking at/for it, but
wants the Linux system to boot from it)

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 1/10] ide: use pci_dev->revision
Date: Wed, 16 Feb 2011 20:52:58 +0300
Message-ID: <4D5C0EFA.9060507@ru.mvista.com>
References: <200708292316.38779.bzolnier@gmail.com> <46D5E77B.5030800@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45672 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752194Ab1BPRya (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Feb 2011 12:54:30 -0500
Received: by bwz15 with SMTP id 15so861917bwz.19
        for <linux-ide@vger.kernel.org>; Wed, 16 Feb 2011 09:54:28 -0800 (PST)
In-Reply-To: <46D5E77B.5030800@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Kok, Auke" <auke-jan.h.kok@intel.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>

Hello.

Kok, Auke wrote:

>> Some places were using PCI_CLASS_REVISION instead of PCI_REVISION_ID so
>> they were not converted by commit 
>> 44c10138fd4bbc4b6d6bff0873c24902f2a9da65.

> that's actually another effort that I'm working on atm. You can either 
> hold off on your patch or we'll see how my patches bounce against yours ;)

    What happened to that effort back then I wonder? I'm now dealing with 
PCI_CLASS_REVISON piecewise. BTW, there are also new PCI_REVISION_ID users. :-)

> Cheers,

WBR, Sergei


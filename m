From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] pci-quirks: disable MSI on RS400-200 and RS480, take
 #2
Date: Wed, 09 May 2007 17:50:52 +0200
Message-ID: <4641EDDC.1020102@gmail.com>
References: <4641BD26.1020501@gmail.com> <4641EAA5.4030409@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:16222 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755969AbXEIPvE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 May 2007 11:51:04 -0400
Received: by py-out-1112.google.com with SMTP id a29so201575pyi
        for <linux-ide@vger.kernel.org>; Wed, 09 May 2007 08:51:03 -0700 (PDT)
In-Reply-To: <4641EAA5.4030409@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: Greg K-H <greg@kroah.com>, Jeff Garzik <jeff@garzik.org>, linux-kernel <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, =?ISO-8859-1?Q?Mat=ED=ADas_Alejandro_Torres?= <torresmat@gmail.com>

Chuck Ebbert wrote:
> Tejun Heo wrote:
>> MSI doesn't work on RS400-200 and RS480 requiring pci=nomsi kernel
>> boot parameter for ahci to work.  This patch renames quirk_svw_msi()
>> to quirk_disable_all_msi() and use it to disable MSI on those chips.
>>
>>   http://thread.gmane.org/gmane.linux.ide/17820
>>   http://thread.gmane.org/gmane.linux.ide/17516
>>   https://bugzilla.novell.com/show_bug.cgi?id=263893
>>
> 
> FWIW several distros have turned off MSI by default and added
> a "pci=msi" option to enable it.

Yeah, it seem to cause a lot of problems on certain chips but I think
the correct path is to add PCI quirks for those.  Most MSI problems I've
seen are on these ATI chips.  Do you happen to know any other?

Thanks.

-- 
tejun

From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: current mainline ide doesn't like qemu/kvm (or vice versa)
Date: Fri, 08 Feb 2008 16:35:14 -0600
Message-ID: <47ACD922.9040101@codemonkey.ws>
References: <20080208152508.GA16290@lst.de> <20080208155350.733d2399@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:56371 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762904AbYBHWfT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Feb 2008 17:35:19 -0500
Received: by fg-out-1718.google.com with SMTP id e21so3010190fga.17
        for <linux-ide@vger.kernel.org>; Fri, 08 Feb 2008 14:35:17 -0800 (PST)
In-Reply-To: <20080208155350.733d2399@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Fri, 8 Feb 2008 16:25:08 +0100
> Christoph Hellwig <hch@lst.de> wrote:
> 
>> When trying to put some stress on qemu by running the xfs testsuite
>> I get the following:
>>
>> debian:~/xfs-cmds/xfstests# sh check 
>> [  438.166822] SGI XFS with ACLs, security attributes, realtime, large block numbers, no debug enabled
>> [  438.185557] SGI XFS Quota Management subsystem
>> [  438.193150] hdb: task_no_data_intr: status=0x41 { DriveReady Error }
>> [  438.194018] hdb: task_no_data_intr: error=0x04 { DriveStatusError }
>> [  438.194195] ide: failed opcode was: 0x9d
> 
> Drive aborted the command. Thats all correct.
>> and after that the kernel seems to hang.  Qemu is emulating a piix3
>> device, and using the piix driver.  This is on a pretty old kvm (version
>> 28) because newer ones don't even compile.

kvm-28 is ancient and there have been IDE emulation fixes since.  I am 
not aware of issues building KVM either.  The problems you reported a 
month ago on kvm-devel have been fixed.

> Old Qemu is not really a credible IDE emulation. The chances are that as
> with all the libata bugs I close for qemu the problem is qemu. Please
> file a bug with the qemu people.

Agreed, this is very likely to be a QEMU issue (that may have already 
been fixed).

Regards,

Anthony Liguori

> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


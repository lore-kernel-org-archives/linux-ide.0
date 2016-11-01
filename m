From: Bram Matthys <syzop@vulnscan.org>
Subject: Re: Write performance 50% compared to Windows
Date: Tue, 01 Nov 2016 14:55:44 +0100
Message-ID: <84eaee69c190c1acdce494bd18de1200@mail.vulnscan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.vulnscan.org ([149.210.174.15]:49614 "EHLO
        mail.vulnscan.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424360AbcKANzr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 1 Nov 2016 09:55:47 -0400
Received: from mail.vulnscan.org ([149.210.174.15])
        by mail.vulnscan.org with esmtp (Exim 4.84_2)
        (envelope-from <syzop@vulnscan.org>)
        id 1c1ZXU-00009q-TV
        for linux-ide@vger.kernel.org; Tue, 01 Nov 2016 14:55:45 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi Daniel,

Daniel Fraga schreef op 2016-11-01 14:03:
> On Tue, 01 Nov 2016 11:37:42 +0100
> Bram Matthys <syzop@vulnscan.org> wrote:
>
>> I have a Samsung SSD 850 EVO 4TB and under Linux I'm only getting
>> ~240MB/s write speed. On Windows it's 490MB/s (yes, without cache).
>> The read speed is the same on both Linux and Windows, though. Both 
>> are
>> 512MB/s.
>
> 	Just curious: are you using the "deadline" scheduler? What file
> system? Ext4?

Yes, the deadline scheduler.

On Linux I'm writing directly to /dev/sda, no file system.

Regards,

Bram


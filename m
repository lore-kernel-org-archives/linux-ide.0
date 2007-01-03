From: Matthew Stapleton <matthew4196@gmail.com>
Subject: Re: ICH7m problem using libata
Date: Wed, 3 Jan 2007 13:07:21 +1000
Message-ID: <200701031307.23024.matthew4196@gmail.com>
References: <1165253799.16504.37.camel@laundromat.jangutter.com> <45888144.9070608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.238]:3791 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754070AbXACDIS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Jan 2007 22:08:18 -0500
Received: by wx-out-0506.google.com with SMTP id h27so6282338wxd
        for <linux-ide@vger.kernel.org>; Tue, 02 Jan 2007 19:08:18 -0800 (PST)
In-Reply-To: <45888144.9070608@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Please apply the attached patch over 2.6.19 and report what the kernel says.
> 
> Thanks.
> 

I got the following errors during the timeout when running hald:

ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x1e data 0 in
         res 40/00:03:00:00:00/00:00:00:00:00/b0 Emask 0x4 (timeout)
ata1.01: CDB: 1e:00:00:00:00:00:00:00 00:00:00:00:00:00:00:00 p=6

ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.01: (BMDMA stat 0x64)
ata1.01: cmd a0/01:00:00:00:00/00:00:00:00:00/b0 tag 0 cdb 0x25 data 8 in
         res 40/00:03:00:00:00/00:00:00:00:00/b0 Emask 0x4 (timeout)
ata1.01: CDB: 25:00:00:00:00:00:00:00 00:00:00:00:00:00:00:00 p=7

With my test program that opens and closes the cdrom drive every second, I got 
the following errors during the timeout:

ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.01: (BMDMA stat 0x64)
ata1.01: cmd a0/01:00:00:00:00/00:00:00:00:00/b0 tag 0 cdb 0x43 data 12 in
         res 40/00:03:00:00:00/00:00:00:00:00/b0 Emask 0x4 (timeout)
ata1.01: CDB: 43:00:00:00:00:00:00:00 0c:40:00:00:00:00:00:00 p=7

ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.01: (BMDMA stat 0x4)
ata1.01: cmd a0/01:00:00:00:00/00:00:00:00:00/b0 tag 0 cdb 0x25 data 8 in
         res 40/00:03:00:00:00/00:00:00:00:00/b0 Emask 0x4 (timeout)
ata1.01: CDB: 25:00:00:00:00:00:00:00 00:00:00:00:00:00:00:00 p=7

-- 
Matthew Stapleton

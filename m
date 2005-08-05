From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH linux-2.6.13-rc3] SATA: rewritten sil24 driver
Date: Fri, 05 Aug 2005 11:30:05 +0900
Message-ID: <42F2CF2D.50500@gmail.com>
References: <20050728013622.GA14026@htj.dyndns.org> <42E93FB9.6090800@pobox.com> <20050730081734.GA14242@htj.dyndns.org> <42EFFA05.8010003@google.com> <20050804085104.GA10201@htj.dyndns.org> <42F263B3.3050509@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.196]:43137 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262807AbVHECaL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Aug 2005 22:30:11 -0400
Received: by zproxy.gmail.com with SMTP id r28so315811nza
        for <linux-ide@vger.kernel.org>; Thu, 04 Aug 2005 19:30:10 -0700 (PDT)
In-Reply-To: <42F263B3.3050509@google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Edward Falk <efalk@google.com>
Cc: linux-ide@vger.kernel.org

Edward Falk wrote:
> Tejun Heo wrote:
> 
>>  Hi, again, Edward.
>>
>>  Bad news...
>>
>> On Tue, Aug 02, 2005 at 03:56:05PM -0700, Edward Falk wrote:
>>
>>> Again, you would need to fetch them from the returned FIS structure. 
>>> Here's a code fragment derived from SiI's issue_soft_reset() function:
> 
> 
> Yeah, well, that's what I get for sending code fragments I haven't 
> tested.  Stand by, I'll tinker with my own version of the driver and 
> send you an improved fragment.
> 
>     -ed

  One more thing I've found out.  They actually look like valid FIS 
values except for the FIS type.  I missed that as I was looking too hard 
at the FIS type value.

POSTRESET c:p=0080:0000 rc=00000000
fis=01500000:00000001:00000000:00000001
       ^    ^        ^                 ^
      DRDY  |      sect num        sect cnt
        FIS type 0?

  The following is from new driver w/ ATAPI device after SATA phy reset. 
(not softreset)

** POST RESET
c:p=0080:0000 rc=00000000
fis=01000027:00eb1401:00000000:00000001
            ^   ^^^^^^                 ^
       type 27? |----- valid sig ------|

  Also, after command completion, the status/error registers seem to 
carry the correct values.  The following is after issuing 
ATA_DEV_IDENTIFY to a ATAPI device.

** POST INTERRUPT
c:p=ffff:ffff rc=00000000
fis=0451e000:a0eb1400:1f000000:00000003
      ^ ^   ^
   ABRT |  FIS type 00 -_-;;
     DRDY/ERR

  So, it almost seems like I can just ignore the FIS type value. 
However, after a SATA phy reset, a hard disk returns the following.

** POST RESET
c:p=ffff:ffff rc=00000200
fis=0050fc90:e0000000:00000000:00000000

  This doesn't contain valid signature....

  I'll wait for further comment from you.  Thanks a lot.  ;-)

-- 
tejun

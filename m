From: "Berck E. Nash" <flyboy@gmail.com>
Subject: Re: libata Intel PIIX/ICH fails to detect both PATA drives, spews
 ACPI errors
Date: Mon, 12 Mar 2007 17:40:22 -0600
Message-ID: <45F5E4E6.7010600@gmail.com>
References: <45705618.2020608@gmail.com> <45E447DD.9050308@gmail.com> <45F3F8AA.4060501@gmail.com> <45F4FCA3.1080301@gmail.com> <45F54147.1060509@gmail.com> <45F546C0.1030502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.228]:35523 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752421AbXCLXk2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Mar 2007 19:40:28 -0400
Received: by nz-out-0506.google.com with SMTP id s1so1426924nze
        for <linux-ide@vger.kernel.org>; Mon, 12 Mar 2007 16:40:27 -0700 (PDT)
In-Reply-To: <45F546C0.1030502@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Tejun Heo wrote:
>>>>>> Testing the new libata ICH PATA drivers.  There's one PATA port on this
>>>>>> chip, and I've got two optical drives connected to it.  The master drive
>>>>>> fails to detect.  The slave detects and works properly.
>>>>> Can you test 2.6.20.1 and post full dmesg?
>>>> Here's 2.6.20.2...  No ACPI errors, but still doesn't detect both drives.
>>> Please apply the attached patch and see if it works.  If it works,
>>> please post the result of hdparm -I /dev/srX of the optical drive.  Thanks.
>> You forgot to attach the patch  :)
> Heh heh.  Sorry about that.  Here it is.

It works!  I'm having trouble getting the hdparm info for you, it
doesn't seem to like the libata interface?  Appears to be the newest
version of hdparm (6.9).  Something I'm missing?

luna:~# hdparm -I /dev/sr0

/dev/sr0:
 HDIO_DRIVE_CMD(identify) failed: Input/output error
luna:~# hdparm -i /dev/sr0

/dev/sr0:
 HDIO_GET_IDENTITY failed: Inappropriate ioctl for device
luna:~# sdparm -i /dev/sr0
    /dev/sr0: LITE-ON   LTR-48246S        SS0E  [cd/dvd]
INQUIRY fetching VPD page=0x83 failed

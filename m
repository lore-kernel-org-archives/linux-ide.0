From: Tejun Heo <htejun@gmail.com>
Subject: Re: ICH4-M ACPI Error
Date: Wed, 16 Aug 2006 16:40:05 +0900
Message-ID: <44E2CBD5.9000307@gmail.com>
References: <44E2B4A1.1030901@PicturesInMotion.net> <44E2B776.7080109@gmail.com> <44E2C82A.3040802@PicturesInMotion.net> <44E2CB82.8050100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:50604 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750977AbWHPHj7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Aug 2006 03:39:59 -0400
Received: by py-out-1112.google.com with SMTP id z74so465455pyg
        for <linux-ide@vger.kernel.org>; Wed, 16 Aug 2006 00:39:59 -0700 (PDT)
In-Reply-To: <44E2CB82.8050100@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lee Trager <Lee@PicturesInMotion.net>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

[resending as reply to add linux-ide back, please don't drop cc list]

Tejun Heo wrote:
> Lee Trager wrote:
>> Tejun Heo wrote:
>>> Lee Trager wrote:
>>>> Hey I've been having this problem for awhile on my laptop(IBM Thinkpad
>>>> T40) and have no been able to figure out how to fix it. It seems that
>>>> when ever I resume my laptop from suspend(from hard drive or RAM) my
>>>> dmesg is filled with this and I am unable to do anything that requires
>>>> access to the hard drive.
>>>>
>>>> ide: failed opcode was: unknown
>>>> hda: task_out_intr: status=0x51 { DriveReady SeekComplete Error }
>>>> hda: task_out_intr: error=0x10 { SectorIdNotFound }, LBAsect=74853287,
>>>> sector=74853287
> 
> Ah... it was the IDE driver, sorry.  You can try using Alan Cox's libata 
> pata drivers patch which is included in recent -mm trees.  With the 
> patch, libata ata_piix driver can drive the controller instead of ide 
> and it has better error handling.
> 
> Be warned that the drive will come up as /dev/sda instead of /dev/hda 
> and it currently doesn't disable host protected area unlike IDE, so your 
> disk can be messed up.

-- 
tejun

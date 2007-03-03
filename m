From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.20] libata: Support HDIO_DRIVE_TASKFILE ioctl
Date: Fri, 02 Mar 2007 19:32:56 -0500
Message-ID: <45E8C238.5030704@garzik.org>
References: <31e4e9500702211813g6d3d6431oda1f6191f056a02e@mail.gmail.com> <45DFBF27.1060707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55161 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992801AbXCCAdA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Mar 2007 19:33:00 -0500
In-Reply-To: <45DFBF27.1060707@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: anand.kulkarni.remove.this@banashankari.net, linux-ide@vger.kernel.org, Anand.Kulkarni@hitachigst.com

Tejun Heo wrote:
> Hello,
> 
> Anand Kulkarni wrote:
>> Hi,
>>
>> Attached is a patch to allow HDIO_DRIVE_TASKFILE ioctl calls to libata
>> devices so that arbitrary ATA commands that need PIO data transfers in
>> either direction can be issued. I have tested it with linux kernel
>> 2.6.20. The format of the input arguments is the same as for the
>> regular ATA HDIO_DRIVE_TASKFILE ioctl : Code that makes ioctl calls to
>> ATA devices on /dev/hda can be sent as is to SATA devices on /dev/sda.
>>
>> Since this is the first time I am sending a patch, please let me know
>> if I should do anything differently.
> 
> I was kind of hoping we could drop HDIO_DRIVE_TASKFILE.  Please take a

I tend to agree



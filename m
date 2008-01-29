From: Mark Lord <liml@rtr.ca>
Subject: Re: Problem with ata layer in 2.6.24
Date: Tue, 29 Jan 2008 13:09:14 -0500
Message-ID: <479F6BCA.4090701@rtr.ca>
References: <200801272122.21823.gene.heskett@gmail.com> <200801291004.12565.gene.heskett@gmail.com> <479F507A.1030203@rtr.ca> <200801291136.42612.gene.heskett@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933278AbYA2SJr@vger.kernel.org>
In-Reply-To: <200801291136.42612.gene.heskett@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gene Heskett <gene.heskett@gmail.com>
Cc: Florian Attenberger <valdyn@gmail.com>, Jeff Garzik <jeff@garzik.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux IDE mailing list <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Gene Heskett wrote:
> On Tuesday 29 January 2008, Mark Lord wrote:
>> Gene Heskett wrote:
>>> ..
>>> Does anyone know why my dvdwriter isn't being assigned a '/dev/sdx' number
>>> when dmesg says its found ok at ata2.00?  I've turned on an option that
>>> says something about using the bios for device access this build, but I'll
>>> be surprised if that's it. :)
>> ..
>>
>> It should show up as /dev/scd0 or something very similar.
> 
> Tisn't.  Darnit.
..

It requires CONFIG_SCSI, CONFIG_BLK_DEV_SD, CONFIG_BLK_DEV_SR, in the kernel .config.

The _SR one ("SCSI Reader") is for CD/DVD support.

Cheers

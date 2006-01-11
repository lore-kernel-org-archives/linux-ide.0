From: Matt Darcy <kernel-lists@projecthugo.co.uk>
Subject: Re: [git patch] 2.6.x libata fix
Date: Wed, 11 Jan 2006 10:18:46 +0000
Message-ID: <43C4DB86.7030603@projecthugo.co.uk>
References: <20060109171104.GA25793@havoc.gtf.org>
Reply-To: kernel-lists@projecthugo.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.ifl.net ([213.18.248.104]:9957 "EHLO mx1.ifl.net")
	by vger.kernel.org with ESMTP id S932382AbWAKKTz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Jan 2006 05:19:55 -0500
In-Reply-To: <20060109171104.GA25793@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Jeff Garzik wrote:

>Please pull from 'upstream-linus' branch of
>master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
>
>to receive the following updates:
>
> drivers/scsi/sata_nv.c |   30 ++++++++++++++++++++++++------
> 1 files changed, 24 insertions(+), 6 deletions(-)
>
>Andrew Chew:
>      sata_nv, spurious interrupts at system startup with MAXTOR 6H500F0 drive
>
>diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
>index c0cf52c..bbbb55e 100644
>--- a/drivers/scsi/sata_nv.c
>+++ b/drivers/scsi/sata_nv.c
>
> <snip reset of patch>
>  
>
Hi Jeff, et all

I pulled this down last night from 
git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
as I don't have an account on master.kernel.org, I assume these are the 
same physical tree.

This built fine and seemed aware of all the SATA disks on my controller 
(as did previous git branches).

Again using my raid5 (7 disks 1.4tb) example, I am unable to build an 
array without the machine hanging.

I am able to access the individual disks for a short period of time 
before the box hangs totally which I assume is why the raid array will 
not build as the access for the disks hangs, not the actual building of 
the array.

I havn't got any output yet on the errors (if there are any) as I left 
the array building overnight (300+ minutes) and when I woke up this 
morning the box had hung, but power saver had come on the screen so I 
couldn't see the messages.

I'll do another test this afternoon and try to get some output for you, 
but I just thought I'd let you know this was coming.

Aslo FYI: I'm using maxtor SATA disks, so your patch was of particular 
interesting to me.

Many thanks,

Matt




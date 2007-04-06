From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ugly messages trying to open CD drive with no media present
Date: Fri, 6 Apr 2007 23:05:56 +0200
Message-ID: <200704062305.56964.bzolnier@gmail.com>
References: <DFEF91B22ED07447AB6AA4B237F913F9524A30@ausx3mpc125.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:35041 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932987AbXDFVEf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 6 Apr 2007 17:04:35 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1232788uga
        for <linux-ide@vger.kernel.org>; Fri, 06 Apr 2007 14:04:34 -0700 (PDT)
In-Reply-To: <DFEF91B22ED07447AB6AA4B237F913F9524A30@ausx3mpc125.aus.amer.dell.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stuart_Hayes@dell.com
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

On Monday 02 April 2007, Stuart_Hayes@dell.com wrote:
> 
> I get the following error messages when trying to open a CD device
> (specifically, the Teac CD-ROM CD-224E) that has no media present:
> 
> hda: packet command error: status=0x51 { DriveReady SeekComplete Error }
> hda: packet command error: error=0x54 { AbortedCommand
> LastFailedSense=0x05 }
> ide: failed opcode was: unknown
> 
> This happens when a "start stop unit" command (0x1b 0 0 0 3 0 0 0 0 0)
> is sent to the drive to try to close the CD-ROM tray, but this drive
> doesn't have that capability (it's a slim portable-type CD-ROM), so it
> reports sense key 5 (illegal request) with asc/ascq 24/0.  This is
> exactly how SFF8090i says it should respond.
> 
> But ide-cd.c (in cdrom_decode_status() ) just sees sense key 5 and spews
> out an error.  It then goes on to request sense data, and
> cdrom_log_sense() understands this error and doesn't log it.
> 
> The patch, for kernel 2.6.20.4, suppresses this error message.
> 
> Signed-off-by: Stuart Hayes <stuart_hayes@dell.com>

Alan, any opinions on this one (this is ide-cd specific patch)?

I applied it to my tree for now and would like to send it to Linus
soon so the patch still makes it into 2.6.21...

Bart

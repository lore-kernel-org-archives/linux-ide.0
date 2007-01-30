From: "Eric D. Mudama" <edmudama@gmail.com>
Subject: Re: HPA and failed opcode was: 0x37 ?
Date: Tue, 30 Jan 2007 08:44:23 -0700
Message-ID: <311601c90701300744n294ecae7ia2dffeae55cfab1c@mail.gmail.com>
References: <45BF5003.3000503@imc-berlin.de> <45BF512D.4040500@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:56895 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652AbXA3Po0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Jan 2007 10:44:26 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1564951uga
        for <linux-ide@vger.kernel.org>; Tue, 30 Jan 2007 07:44:25 -0800 (PST)
In-Reply-To: <45BF512D.4040500@imc-berlin.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: linux-ide@vger.kernel.org

On 1/30/07, Steven Scholz <steven.scholz@imc-berlin.de> wrote:
> > hda: Host Protected Area detected.
> >         current capacity is 78140160 sectors (40007 MB)
> >         native  capacity is 185074430006016 sectors (94758108163 MB)
> > hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> > hda: task_no_data_intr: error=0x04 { DriveStatusError }
> > ide: failed opcode was: 0x37
> > hda: 78140160 sectors (40007 MB) w/8192KiB Cache, CHS=16383/255/63
> >
> > My quetsions are:
> >
> > 1. what's that 185074430006016 sectors native capacity about?
>
> Sectors written in hex:
> current capacity is 78140160 sectors would be           0x000004A85300
> native  capacity is 185074430006016 sectors would be    0xA852FFA85300

0x37 is READ NATIVE MAX ADDRESS EXT, which is the 48-bit version of
the command to figure out how big the drive "really" is.  It appears
that model of drive indicated support for 48-bit commands, but then
aborted the 48-bit version of READ NATIVE MAX ADDRESS.

Is it really a 40GB drive?

--eric
